#!/bin/bash
set -e -u -x

if [[ $(arch) == "aarch64" ]]
then
NODE_ARCH=arm64
else
NODE_ARCH=x64
fi
NODE_TAR=node-${NODE_VERSION}-linux-${NODE_ARCH}.tar.xz
NODE_URL=https://nodejs.org/dist/${NODE_VERSION}/${NODE_TAR}

curl -fsSL ${NODE_URL} -o /tmp/${NODE_TAR}
tar -xJf /tmp/${NODE_TAR} -C /usr/local --strip-components=1
rm /tmp/${NODE_TAR}
