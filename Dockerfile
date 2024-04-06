# Use the latest Ubuntu as the base image
FROM ubuntu:latest AS base

# Set environment variable to make install non-interactive
ENV DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
RUN apt-get update && apt-get install -y \
    software-properties-common \
    curl \
    xclip \
    ripgrep \
    git \
    bash \
    build-essential \
    python3 \
    python3.10 \
    python3-pip \
    ca-certificates \
    openssl \
    && add-apt-repository -y ppa:neovim-ppa/unstable \
    && apt-get update \
    && apt-get install -y neovim \ 
    && pip install djhtml

# Install Go
ENV GO_VERSION 1.21.5
RUN curl -LO https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go$GO_VERSION.linux-amd64.tar.gz \
    && rm go$GO_VERSION.linux-amd64.tar.gz

# Set PATH for Go
ENV PATH "/usr/local/go/bin:$PATH"

# Install Node.js using NVM
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION v20.10.0
RUN mkdir -p $NVM_DIR \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# Set PATH for Node.js
ENV PATH "$NVM_DIR/versions/node/$NODE_VERSION/bin:$PATH"

# Install Node.js packages
RUN npm i -g vscode-langservers-extracted \
    && npm i -g prettier \
    && npm i -g @johnnymorganz/stylua-bin

# Install Go development utilities
RUN go install github.com/cosmtrek/air@v1.49.0 \
    && go install golang.org/x/tools/cmd/goimports@latest \
    && go install golang.org/x/tools/gopls@latest

# Configure Git
RUN git config --global --add safe.directory '*' \
    && git config --global user.name "Carlos Molero" \
    && git config --global user.email "carlos@novascript.io"

# Set the working directory
WORKDIR /workspace

# Keep the container running
CMD ["sleep", "infinity"]
