#!/bin/bash

# Set CUDA_VISIBLE_DEVICES environment variable
export CUDA_VISIBLE_DEVICES=0

# Project name
project_name="$PROJECT_NAME"

# Base model path and tuned model path
base_model_path="$BASE_MODEL_PATH"
tuned_model_path="$TUNED_MODEL_PATH"

# Base model name and tuned model name
base_model_name="$BASE_MODEL_NAME"
tuned_model_name="$TUNED_MODEL_NAME"

# Array of model paths and model names
model_paths=("$base_model_path" "$tuned_model_path")
model_names=("$base_model_name" "$tuned_model_name")

# Loop through model_paths array
for index in "${!model_paths[@]}"
do
    # Get the current model path and model name
    model_path="${model_paths[$index]}"
    model_name="${model_names[$index]}"
    
    # Print the current model being processed
    echo "Processing model: $model_path"

    # Call the Python script with the corresponding model ID, model path, and other files
    python -m eval.get_model_answer --model-id "$model_name" --model-path "$model_path" --question-file "eval/table/question/${project_name}/questions.jsonl" --answer-file "eval/table/answer/${project_name}/answer_${model_name}.jsonl" --num-gpus 1

done

