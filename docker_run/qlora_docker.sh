docker run -dt --name qlora --restart=always --gpus all --network=host \
-v <Your code directory>:/code \
-v <Your model and dataset directory>:/hf \
-v <Your output directory>:/output \
-w /code \
tafflan/llm_dockers:qlora-0.0.1 \
/bin/bash
