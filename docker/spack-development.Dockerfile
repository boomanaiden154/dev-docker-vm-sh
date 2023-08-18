FROM ubuntu:22.04
RUN apt-get update && apt-get install -y \
  python3 \
  python3-pip \
  file \
  zip \
  tar \
  curl \
  git \
  vim \
  patchelf \
  pkgconf \
  gcc \
  g++ \
  make \
  patch \
  unzip \
  lsb-release \
  gnupg2 \
  subversion \
  mercurial \
  python3-dev
RUN pip3 install black isort mypy flake8 pytest pytest-xdist

