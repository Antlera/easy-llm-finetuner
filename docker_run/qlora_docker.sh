docker run -dt --name qlora  --shm-size 64g --restart=always --gpus all --network=host \
-v <Your code directory>:/code \
-v <Your model and dataset directory>:/hf \
-v <Your output directory>:/output \
-v Easy-LLM-Finetuner/finetune/qlora:/code/easy_llm_finetuner \
-w /code \
tafflan/llm_dockers:qlora-0.0.1 \
/bin/bash
