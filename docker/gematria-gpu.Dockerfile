FROM tensorflow/tensorflow:2.14.0-gpu
RUN apt-get update && apt-get install -y clang git curl libpfm4-dev golang flex bison libelf-dev libtraceevent-dev libdw-dev libunwind-dev libdwarf-dev libc6-dbg vim
ARG bazelisk_version=1.19.0
RUN curl -L https://github.com/bazelbuild/bazelisk/releases/download/v${bazelisk_version}/bazelisk-linux-amd64 > /usr/bin/bazelisk && chmod +x /usr/bin/bazelisk && ln -s /usr/bin/bazelisk /usr/bin/bazel
COPY custom-cert.crt /usr/local/share/ca-certificates
RUN update-ca-certificates && echo "Options = UnsafeLegacyRenegotiation" >> /etc/ssl/openssl.cnf
RUN curl https://raw.githubusercontent.com/boomanaiden154/gematria/requirements-lockfile/requirements.txt > /requirements.in && pip3 install -r /requirements.in
RUN GOBIN=/usr/local/bin go install github.com/bazelbuild/buildtools/buildifier@latest
ENV TEST_TMPDIR=/tmp/bazel-cache
ENV PATH="${PATH}:/root/go/bin"
ENV USE_BAZEL_VERSION=6.4.0
