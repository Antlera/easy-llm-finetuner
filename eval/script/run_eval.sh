#!/bin/bash

export BASE_MODEL_PATH="/path/to/base_model"
export TUNED_MODEL_PATH="/path/to/tuned_model"
export BASE_MODEL_NAME="base_model_name"
export TUNED_MODEL_NAME="tuned_model_name"
export PROJECT_NAME="project_name"
export CATEGORY="category"

# Replace the placeholder values with your own corresponding data
# BASE_MODEL_PATH: Set the path to the base model
# TUNED_MODEL_PATH: Set the path to the tuned model
# BASE_MODEL_NAME: Set the name of the base model
# TUNED_MODEL_NAME: Set the name of the tuned model
# PROJECT_NAME: Set the name of the project
# CATEGORY: Set the category

# Generate example data
. eval/script/generate_example.sh

# Generate question data
. eval/script/generate_question.sh

# Get model answers
. eval/script/get_model_answer.sh

# Evaluate GPT review
. eval/script/eval_gpt_review.sh

# Generate webpage data from table
. eval/script/generate_webpage_data_from_table.sh

# Unset environment variables
unset BASE_MODEL_PATH
unset TUNED_MODEL_PATH
unset BASE_MODEL_NAME
unset TUNED_MODEL_NAME
unset PROJECT_NAME
unset CATEGORY
