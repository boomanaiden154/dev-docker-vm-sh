FROM ubuntu:22.04 AS llvm-development-base
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
    php \
    php-curl \
    flex \
    bison \
    libelf-dev \
    libdw-dev \
    libtraceevent-dev \
    libunwind-dev \
    curl

FROM llvm-development-base AS toolchain-build
COPY ./sh/build-llvm-optimized.sh /
RUN /build-llvm-optimized.sh

FROM llvm-development-base AS llvm-development
COPY --from=toolchain-build /llvm-install /llvm-install
RUN curl -L https://raw.githubusercontent.com/llvm/llvm-project/main/llvm/docs/requirements.txt > /docs-requirements.txt \
  && pip3 install -r /docs-requirements.txt \
  && rm /docs-requirements.txt
ENV LC_ALL=C
RUN ln -sf /llvm-install/bin/clang /usr/bin/cc && \
  ln -sf /llvm-install/bin/clang++ /usr/bin/c++ && \
  ln -sf /llvm-install/bin/ld.lld /usr/bin/ld
COPY ./sh /sh-utils
RUN /sh-utils/configure-git.sh
