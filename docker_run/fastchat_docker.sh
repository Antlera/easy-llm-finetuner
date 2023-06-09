docker run -dt --name fastchat --restart=always --gpus all --network=host \
-v <Your code directory>:/code \
-v <Your model and dataset directory>:/hf \
-v <Your output directory>:/output \
-w /code \
tafflan/llm_dockers:fastchat-0.0.2 \
/bin/bash