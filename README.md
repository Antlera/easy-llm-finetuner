# easy-llm-finetuner

![GitHub stars](https://img.shields.io/github/stars/Antlera/easy-llm-finetuner?style=social)
![GitHub forks](https://img.shields.io/github/forks/Antlera/easy-llm-finetuner?style=social)
![GitHub watchers](https://img.shields.io/github/watchers/Antlera/easy-llm-finetuner?style=social)

## Introduction

`easy-llm-finetuner` is a project aimed to simplify the deployment and utilization of state-of-the-art large language models (LLMs) for fine-tuning. Leveraging Docker, this project eliminates the hassle of environment setup, allowing users to focus more on model training and less on configuration.

## How to Use?

### Prerequisites

Ensure Docker is installed on your machine. If not, download and install it from the following links:

- [Windows](https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe)
- [macOS](https://download.docker.com/mac/stable/Docker.dmg)
- Linux (use the command below)
  ```shell
  curl -fsSL https://get.docker.com -o get-docker.sh
  sh get-docker.sh
  ```

## Supported Projects

Currently, `easy-llm-finetuner` supports the following projects:

- [stanford alpaca](https://github.com/tatsu-lab/stanford_alpaca)
- [alpaca lora](https://github.com/tloen/alpaca-lora)
- [qlora](https://github.com/artidoro/qlora)
- [fastchat](https://github.com/lm-sys/FastChat)

Each of these projects can be easily fine-tuned using the `easy-llm-finetuner` environment. Check out each project's page for more specific details on how to utilize them within this system.

### Get Started

1. **Pull the Docker image**

   Run the pull script provided in the repository to fetch the Docker image that's preconfigured with everything needed for LLM fine-tuning.

   ```shell
   ./pull_image.sh
   ```

2. **Run the Docker container**

   Use the provided script to start the Docker container. This script mounts your local directories for code, model data, and output to the corresponding directories in the container.

   ```shell
   ./run_docker.sh
   ```

3. **Start the model training**

   Within the Docker container, execute the one-click training script to start fine-tuning your model.

   ```shell
   ./train_model.sh
   ```

And that's it! You are now fine-tuning your LLM using state-of-the-art methods, all within a neatly encapsulated environment.

## Feedback & Contributions

If you encounter any issues or have suggestions for improvements, feel free to submit an issue or a pull request.

## License

This project is licensed under the terms of the MIT license. See the [LICENSE](LICENSE) file for details.

We hope `easy-llm-finetuner` makes your journey in large language model fine-tuning a breeze. If you find this project useful, please consider giving it a star!

