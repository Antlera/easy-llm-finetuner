#!/bin/bash

# Set the variables
category="$CATEGORY"
srcfile="eval/table/question/$project_name/example_questions.json"
outfile="eval/table/question/$project_name/questions.jsonl"

# Run the script and pass the arguments
python -m eval.generate_questions --category "$category" --srcfile "$srcfile" --outfile "$outfile"
