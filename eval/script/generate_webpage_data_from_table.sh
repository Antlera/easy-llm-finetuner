project_name="$PROJECT_NAME"
base_model_name="$BASE_MODEL_NAME"
tuned_model_name="$TUNED_MODEL_NAME"
python -m eval.generate_webpage_data_from_table --project_name "$project_name" --basemodel "$base_model_name" --tunedmodel "$tuned_model_name"
