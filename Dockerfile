FROM ubuntu:latest AS base

ENV DEBIAN_FRONTEND=noninteractive

# Neovim + distro utilities
RUN apt-get update && apt-get install -y \
    software-properties-common \
    xclip \
    curl \
    tmux \
    git \
    bash \
    build-essential \
    && add-apt-repository -y ppa:neovim-ppa/unstable \
    && apt-get update \
    && apt-get install -y neovim

# GO installation
ENV GO_VERSION 1.21.5
RUN apt-get update && apt-get install -y \
    curl \
    && curl -LO https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go$GO_VERSION.linux-amd64.tar.gz \
    && rm go$GO_VERSION.linux-amd64.tar.gz

ENV PATH "/usr/local/go/bin:$PATH"

# Node.js installation
ENV NVM_DIR /usr/local/nvm

ENV PATH "$NVM_DIR/versions/node/$NODE_VERSION/bin:$PATH"

RUN mkdir -p $NVM_DIR

ENV NODE_VERSION v20.10.0

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    openssl \
    python3 \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# Common GO development utils
RUN go install github.com/cosmtrek/air@v1.49.0
RUN go install golang.org/x/tools/cmd/goimports@latest
RUN go install golang.org/x/tools/gopls@latest

# Git config
RUN git config --global --add safe.directory '*'
RUN git config --global user.name "Carlos Molero"
RUN git config --global user.email "carlos@novascript.io"

WORKDIR /workspace

CMD ["sleep", "infinity"]
