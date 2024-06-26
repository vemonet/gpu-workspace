ARG BASE_IMAGE=nvcr.io/nvidia/cuda:12.2.2-runtime-ubuntu22.04
FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.description "Basic image with CUDA for use with VSCode SSH"
LABEL org.opencontainers.image.source https://github.com/vemonet/gpu-workspace

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Amsterdam \
    PYTHONUNBUFFERED=1

# CUDA image requires to install python
RUN apt-get update && \
    apt-get install -y git vim zsh bash build-essential python3-dev python3-venv pip curl wget unzip htop tmux && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --upgrade pip hatch

# Install Oh My ZSH! and custom theme
RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN curl -fsSL -o ~/.oh-my-zsh/custom/themes/biratime.zsh-theme https://raw.github.com/vemonet/biratime/main/biratime.zsh-theme
RUN sed -i 's/^ZSH_THEME=".*"$/ZSH_THEME="biratime"/g' ~/.zshrc
RUN echo 'setopt NO_HUP' >> ~/.zshrc

# Add a few aliases to make git easier to use
RUN echo 'alias gus="git status"' >> ~/.zshrc
RUN echo 'alias gimmit="git commit -m $1"' >> ~/.zshrc
RUN echo 'alias gadd="git add . && git commit -m $1"' >> ~/.zshrc

ENV SHELL=/bin/zsh

WORKDIR /app

ENTRYPOINT ["sleep", "infinity"]
