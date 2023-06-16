srcfile="eval/table/input/$PROJECT_NAME/source_data.json"
outfile="eval/table/question/$PROJECT_NAME/example_questions.json"
python -m eval.generate_example --srcfile "${srcfile}" --outfile "${outfile}"
