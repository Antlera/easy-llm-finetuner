import openai
import json
import os
import logging
import time
import argparse

# Setup logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

openai.api_key = os.getenv("OPENAI_API_KEY")

def generate_questions(category, example_questions, start_id):
    question_id = start_id
    questions = []
    
    for example_question in example_questions:
        sys_prompt = f"You are an AI language model and the user will provide a category and an example question. Your task is to generate an engaging and open-ended question that is similar in nature to the example and relevant to the given category. The response should only contain the question, without any additional dialogue or explanation."
        user_prompt = f"Considering the category of {category}, generate a question that explores an aspect relevant to this category. For instance, an appropriate question might be: '{example_question}'. Please generate a similar question for the category {category}. Ensure your question is engaging and open-ended."
        
        while True:
            try:
                response = openai.ChatCompletion.create(
                    model="gpt-3.5-turbo",
                    messages=[
                        {"role": "system", "content": sys_prompt},
                        {
                            "role": "user",
                            "content": user_prompt,
                        },
                    ],
                    temperature=0.8, 
                    max_tokens=256,
                )
                break
            except openai.error.RateLimitError:
                logger.info("Rate limit reached. Sleeping for 60 seconds...")
                time.sleep(60)  # sleep for 60 seconds

        question_text = response["choices"][0]["message"]["content"]
        question = {"question_id": question_id, "text": question_text, "category": category+"_GPT"}
        questions.append(question)
        
        logger.info(f"Generated question: {question}")
        question_id += 1
    
    return questions

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--category', type=str, required=True, help='Category of the questions')
    parser.add_argument('--srcfile', type=str, required=True, help='Path to the source file for reference questions')
    parser.add_argument('--outfile', type=str, required=True, help='Path to save the final generated questions combining reference and GPT-generated questions')
    args = parser.parse_args()

    category = args.category  # Category of the questions
    src_file = args.srcfile  # Path to the source file for reference questions
    out_file = args.outfile  # Path to save the final generated questions

    example_questions = load_reference_questions(src_file)

    # Add example questions to the output list
    questions = [{"question_id": i + 1, "text": question, "category": category} for i, question in enumerate(example_questions)]

    # Generate new questions using GPT
    questions += generate_questions(category, example_questions, len(questions) + 1)

    # Write the questions to the output JSON file
    with open(out_file, 'w') as f:
        for question in questions:
            f.write(json.dumps(question, ensure_ascii=False) + '\n')

    logger.info(f"Questions have been saved to {out_file}")

def load_reference_questions(file_path):
    # Load example questions from the input JSON file
    with open(file_path, 'r') as f:
        example_questions_data = json.load(f)
    example_questions = [example['input'] for example in example_questions_data]
    return example_questions

if __name__ == "__main__":
    main()

