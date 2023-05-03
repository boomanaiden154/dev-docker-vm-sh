FROM ubuntu:22.04
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    python3-distutils \
    python-is-python3 \
    python3 \
    python3-pip \
    tmux \
    g++ \
    ccache \
    binutils-gold \
    binutils-dev \
    ninja-build \
    pkg-config \
    gcc-multilib \
    g++-multilib \
    gawk \
    dos2unix \
    libxml2-dev \
    rsync \
    git \
    libtool \
    m4 \
    automake \
    libgcrypt-dev \
    liblzma-dev \
    libssl-dev \
    libgss-dev \
    python3-dev \
    wget \
    zlib1g-dev \
    tcl-dev \
    libpfm4-dev \
    software-properties-common \
    cmake \
    git \
    vim \
    doxygen \
    python3-sphinx \
    python3-recommonmark \
    lld
COPY ./sh /sh-utils
RUN /sh-utils/configure-git.sh
ENV CCACHE_DIR=/ccache
