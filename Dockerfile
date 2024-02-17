ARG BASE_IMAGE=nvcr.io/nvidia/cuda:12.1.0-runtime-ubuntu22.04

# Basic image with CUDA for use with VSCode SSH
# Example CUDA Dockerfile: https://github.com/oobabooga/text-generation-webui/blob/main/docker/nvidia/Dockerfile

FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.source https://github.com/vemonet/gpu-workspace

ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=Europe/Amsterdam \
    PYTHONUNBUFFERED=1

# CUDA image requires to install python
RUN apt-get update && \
    apt-get install -y git vim zsh bash build-essential python3-dev python3-venv pip curl wget unzip htop tmux && \
    pip install --upgrade pip hatch

# Install Oh My ZSH! and custom theme
RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN curl -fsSL -o ~/.oh-my-zsh/custom/themes/biratime.zsh-theme https://raw.github.com/vemonet/biratime/main/biratime.zsh-theme
RUN sed -i 's/^ZSH_THEME=".*"$/ZSH_THEME="biratime"/g' ~/.zshrc
RUN echo "\`conda config --set changeps1 false\`" >> ~/.oh-my-zsh/plugins/virtualenv/virtualenv.plugin.zsh
RUN echo 'setopt NO_HUP' >> ~/.zshrc

# Add a few aliases to make git easier to use
RUN echo 'alias gus="git status"' >> ~/.zshrc
RUN echo 'alias gimmit="git commit -m $1"' >> ~/.zshrc
RUN echo 'alias gadd="git add . && git commit -m $1"' >> ~/.zshrc

ENV SHELL=/bin/zsh

WORKDIR /app
VOLUME [ "/app" ]

ENTRYPOINT ["tail", "-f", "/dev/null"]
