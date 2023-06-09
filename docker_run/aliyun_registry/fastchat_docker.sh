docker run -dt --name fastchat3 --shm-size 64g --restart=always --gpus all --network=host \
-v /home/lan/CodeSpace/FastChat:/workspace/code \
-v ~/.cache/huggingface/:/workspace/hf \
-v /home/lan/CodeSpace/LLM_outputs:/workspace/output \
-v /home/lan/CodeSpace/Easy-LLM-Finetuner/finetune/fastchat:/workspace/easy_llm_finetuner \
-w /workspace \
registry.cn-hangzhou.aliyuncs.com/llm_dockers/fastchat:0.0.2 \
/bin/bash