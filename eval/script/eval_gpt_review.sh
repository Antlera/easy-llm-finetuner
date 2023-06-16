MODEL_NAME="vicuna-7b"
BASE_MODEL_NAME="vicuna-7b_base"
TUNED_MODEL_NAME="vicuna-7b_tuned"

python -m eval.eval_gpt_review \
  -q eval/table/question.jsonl \
  -a eval/table/answer/answer_${TUNED_MODEL_NAME}.jsonl \
  eval/table/answer/answer_${BASE_MODEL_NAME}.jsonl \
  -p eval/table/prompt.jsonl \
  -r eval/table/reviewer.jsonl \
  -o eval/table/review/${MODEL_NAME}/review_${TUNED_MODEL_NAME}_${BASE_MODEL_NAME}.jsonl
