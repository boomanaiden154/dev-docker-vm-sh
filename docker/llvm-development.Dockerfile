FROM ghcr.io/llvm/ci-ubuntu-24.04
RUN curl -L https://raw.githubusercontent.com/llvm/llvm-project/main/llvm/docs/requirements.txt > /tmp/docs-requirements.txt \
  && pip3 install -r /tmp/docs-requirements.txt --break-system-packages \
  && rm /tmp/docs-requirements.txt
RUN sudo apt-get update && sudo apt-get install -y vim
RUN sudo ln -sf /opt/llvm/bin/clang /usr/bin/cc && \
  sudo ln -sf /opt/llvm/bin/clang++ /usr/bin/c++ && \
  sudo ln -sf /opt/llvm/bin/ld.lld /usr/bin/ld
ENV PATH="${PATH}:/opt/llvm/bin"
