base_model_name="$BASE_MODEL_NAME"
tuned_model_name="$TUNED_MODEL_NAME"

python -m eval.eval_gpt_review \
  -q eval/table/question/$PROJECT_NAME/questions.jsonl \
  -a eval/table/answer/$PROJECT_NAME/answer_${tuned_model_name}.jsonl \
  eval/table/answer/$PROJECT_NAME/answer_${base_model_name}.jsonl \
  -p eval/table/gpt_reviewer/$PROJECT_NAME/prompt.jsonl \
  -r eval/table/gpt_reviewer/$PROJECT_NAME/reviewer.jsonl \
  -o eval/table/review/$PROJECT_NAME/review_${tuned_model_name}_${base_model_name}.jsonl
