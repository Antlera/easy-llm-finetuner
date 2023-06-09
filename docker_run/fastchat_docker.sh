#!/bin/bash

# Here, you need to replace <Your code directory>, <Your input directory>, and <Your output directory> with your actual directories
CODE_DIR="<Your code directory>"
INPUT_DIR="<Your input directory>"
OUTPUT_DIR="<Your output directory>"

# Check if the directories have been replaced
if [[ "$CODE_DIR" == "<Your code directory>" ]] || [[ "$INPUT_DIR" == "<Your input directory>" ]] || [[ "$OUTPUT_DIR" == "<Your output directory>" ]]; then
    echo "Please replace <Your code directory>, <Your input directory>, and <Your output directory> in the script with actual directory paths"
    exit 1
fi

# If directories have been replaced, proceed with the rest of the script
git clone https://github.com/lm-sys/FastChat.git ./workspace/code/Fastchat

current_dir=$(pwd)

docker run -dt --name easy_fastchat --shm-size 64g --restart=always --gpus all --network=host \
-v "$CODE_DIR":/workspace/code \
-v "$INPUT_DIR":/workspace/input \
-v "$OUTPUT_DIR":/workspace/output \
-v "${current_dir}/finetune/fastchat":/workspace/easy_llm_finetuner \
-w /workspace \
tafflan/llm_dockers:fastchat-0.0.2 \
/bin/bash
