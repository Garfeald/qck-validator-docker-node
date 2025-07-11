# Use the image FROM ubuntu:22.04
FROM ubuntu:22.04

# 1. Install the necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gnupg2 \
    ca-certificates \
    sudo \
    lz4 \
    git \
    make \
    mc \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# 2. Installing Go (version 1.23.10)
RUN wget https://go.dev/dl/go1.23.10.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.23.10.linux-amd64.tar.gz && \
    rm go1.23.10.linux-amd64.tar.gz

# 3. Setting up the Go environment
ENV PATH="/usr/local/go/bin:${PATH}"

# 4. Install Quicksilver, drop the binary into usr/local/bin
RUN git clone https://github.com/ingenuity-build/quicksilver.git && \
    cd quicksilver && \
    git checkout v1.8.1 && \
    make build && \
    cp build /usr/local/bin/

# 5. open ports
EXPOSE 26656 26657 1317 9090

# 6. we are starting the service
CMD ["quicksilverd", "start"]