FROM ubuntu:24.04 AS build-base
ENV DEBIAN_FRONTEND=noninteractive

# Install all prereqs
RUN apt-get -y update && \
    apt-get -y install \
      apt-utils curl git jlha-utils lhasa python3 python3-pip srecord wget \
      autoconf bison flex g++ gcc gettext git libgmpxx4ldbl libgmp-dev \
      libmpfr6 libmpfr-dev libmpc3 libmpc-dev libncurses-dev make rsync \
      texinfo

# Make jlha the default
RUN cd /usr/bin && mv lha lha.lhasa && ln -s jlha lha

FROM build-base AS build-gcc6

ENV PREFIX=/opt/amiga-gcc-6.5.0
# Install Bebbo's amiga-gcc6
RUN git config --global pull.rebase false && \
    cd /root && \
    git clone --depth 1 https://github.com/AmigaPorts/m68k-amigaos-gcc amiga-gcc && \
    cd /root/amiga-gcc && \
    mkdir -p ${PREFIX} && \
    make update && \
    make -j2 min ndk && \
    cd / && \
    rm -rf /root/amiga-gcc

FROM build-base AS build-gcc13
# Install Bebbo's amiga-gcc 13.2
ENV PREFIX=/opt/amiga-gcc-13.2

RUN git config --global pull.rebase false && \
    cd /root && \
    git clone --depth 1 https://github.com/AmigaPorts/m68k-amigaos-gcc amiga-gcc && \
    cd /root/amiga-gcc && \
    mkdir -p ${PREFIX} && \
    make branch branch=amiga13.2 mod=gcc && \
    make update && \
    make -j2 min ndk && \
    cd / && \
    rm -rf /root/amiga-gcc

FROM ubuntu:24.04

EXPOSE 10240/tcp
ENV EXTRA_ARGS="--language c --language c++"
ARG NODE_VERSION=v22.16.0
ENV DEBIAN_FRONTEND=noninteractive

COPY --from=build-gcc6 /opt/amiga-gcc-6.5.0 /opt/amiga-gcc-6.5.0
COPY --from=build-gcc13 /opt/amiga-gcc-13.2 /opt/amiga-gcc-13.2

RUN apt-get update && apt-get install -y \
    make \
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