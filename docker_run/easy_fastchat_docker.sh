#!/bin/bash
git clone https://github.com/lm-sys/FastChat.git ./workspace/code/Fastchat

current_dir=$(pwd)
docker run -dt --name easy_fastchat --shm-size 64g --restart=always --gpus all --network=host \
-v "${current_dir}/workspace/code/Fastchat":"/workspace/code" \
-v "${current_dir}/finetune/fastchat":"/workspace/easy_llm_finetuner" \
-w /workspace \
tafflan/llm_dockers:fastchat-0.0.2 \
/bin/bash