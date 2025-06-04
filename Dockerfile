FROM liv2/amiga-gcc:latest

EXPOSE 10240/tcp

ENV EXTRA_ARGS="--language c --language c++"

ARG NODE_VERSION=v22.16.0

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    git \
    rsync \
    gcc \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

# Download and extract Node.js binary tarball
ADD scripts/node_install.sh /node_install.sh
RUN /node_install.sh

RUN mkdir /compiler-explorer && chown ubuntu:ubuntu /compiler-explorer

USER ubuntu

RUN git clone https://github.com/compiler-explorer/compiler-explorer.git

ADD configs/* /compiler-explorer/etc/config/

WORKDIR /compiler-explorer

RUN make prebuild

CMD [ "make" ]