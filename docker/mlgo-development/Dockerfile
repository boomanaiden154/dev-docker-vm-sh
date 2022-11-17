FROM debian:bullseye
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
    vim
RUN git clone https://github.com/google/ml-compiler-opt
RUN mkdir /tflite
WORKDIR /tflite
RUN /ml-compiler-opt/buildbot/build_tflite.sh
WORKDIR /
RUN python3 -m pip install -r /ml-compiler-opt/requirements-dev.txt
RUN git config --global user.name "Aiden Grossman"
RUN git config --global user.email "agrossman154@yahoo.com"
