#!/bin/bash

export CUDA_VISIBLE_DEVICES=1
MODEL_NAME="vicuna-7b"
BASE_MODEL_PATH="/home/lan/CodeSpace/FastChat/model_zoo/vicuna-7b"
TUNED_MODEL_PATH="/home/lan/CodeSpace/FastChat/output/vicuna7b_CrimeKGAssitantClean_1/checkpoint-1272"

MODELS=("base" "tuned")

for MODEL_PATH in "${MODELS[@]}"
do
    # 根据 MODEL_PATH 类型构建完整的模型路径
    if [[ $MODEL_PATH == "base" ]]; then
        FULL_MODEL_PATH="$BASE_MODEL_PATH"
    elif [[ $MODEL_PATH == "tuned" ]]; then
        FULL_MODEL_PATH="$TUNED_MODEL_PATH"
    else
        echo "Invalid MODEL_PATH specified. Please provide 'base' or 'tuned'."
        exit 1
    fi

    # 在这里执行你想要的操作，使用 $FULL_MODEL_PATH 来访问当前模型路径
    echo "Processing model: $FULL_MODEL_PATH"

    # 根据 MODEL_PATH 类型构建 MODEL_ID
    if [[ $MODEL_PATH == "base" ]]; then
        MODEL_ID="base"
    elif [[ $MODEL_PATH == "tuned" ]]; then
        MODEL_ID="tuned"
    fi

    echo "Processing model id: $MODEL_ID"
    
    # 例如，可以调用 Python 脚本，并将模型路径作为参数传递
    python -m eval.get_model_answer --model-id $MODEL_ID --model-path $FULL_MODEL_PATH --question-file /home/lan/CodeSpace/Easy-LLM-Finetuner/eval/table/question.jsonl --answer-file "/home/lan/CodeSpace/Easy-LLM-Finetuner/eval/table/answer/answer_${MODEL_NAME}_${MODEL_ID}.jsonl" --num-gpus 1

    # 或者可以执行其他操作，如复制、移动或删除文件等
done
