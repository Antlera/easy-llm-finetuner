"""Generate json file for webpage."""
import argparse
import json
import logging
import os
import re

models = ["tuned", "base"]
# Setup logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def read_jsonl(path: str, key: str = None):
    data = []
    with open(os.path.expanduser(path)) as f:
        for line in f:
            if not line:
                continue
            data.append(json.loads(line))
    if key is not None:
        data.sort(key=lambda x: x[key])
        data = {item[key]: item for item in data}
    return data


def trim_hanging_lines(s: str, n: int) -> str:
    s = s.strip()
    for _ in range(n):
        s = s.split("\n", 1)[1].strip()
    return s


if __name__ == "__main__":


    # Create an argument parser
    parser = argparse.ArgumentParser(description='Generate JSON file for webpage.')
    parser.add_argument('--project_name', required=True, help='Name of the project')
    parser.add_argument('--basemodel', required=True, help='Name of the base model')
    parser.add_argument('--tunedmodel', required=True, help='Name of the tuned model')
    args = parser.parse_args()

    # Get command-line arguments
    project_name = args.project_name
    base_model_name = args.basemodel
    tuned_model_name = args.tunedmodel

    # Load data from JSON files
    questions = read_jsonl("eval/table/question/{}/questions.jsonl".format(project_name), key="question_id")
    base_model_answers = read_jsonl("eval/table/answer/{}/answer_{}.jsonl".format(project_name, base_model_name), key="question_id")
    tuned_model_answers = read_jsonl("eval/table/answer/{}/answer_{}.jsonl".format(project_name, tuned_model_name), key="question_id")

    # Load review data
    logger.info("eval/table/review/{}/review_{}_{}.jsonl".format(project_name, tuned_model_name, base_model_name))
    review = read_jsonl(
        "eval/table/review/{}/review_{}_{}.jsonl".format(project_name, tuned_model_name, base_model_name), key="question_id"
    )
    logger.info("Loaded {} records".format(len(review)))


    records = []
    for qid in questions.keys():
        r = {
            "id": qid,
            "category": questions[qid]["category"],
            "question": questions[qid]["text"],
            "answers": {
                "tuned": tuned_model_answers[qid]["text"],
                "base": base_model_answers[qid]["text"],
            },
            "evaluations": {
                "tuned": review[qid]["text"],
            },
            "scores": {
                "tuned": review[qid]["score"],
            },
        }

        # cleanup data
        cleaned_evals = {}
        for k, v in r["evaluations"].items():
            v = v.strip()
            lines = v.split("\n")
            # trim the first line if it's a pair of numbers
            if re.match(r"\d+[, ]+\d+", lines[0]):
                lines = lines[1:]
            v = "\n".join(lines)
            cleaned_evals[k] = v.replace("Assistant 1", "**Assistant 1**").replace(
                "Assistant 2", "**Assistant 2**"
            )

        r["evaluations"] = cleaned_evals
        records.append(r)

    # Write to file
    with open("eval/webpage/data.json", "w") as f:
        json.dump({"questions": records, "models": models}, f, indent=2)
