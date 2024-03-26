FROM gematria
# Relies on having the gematria image built from https://github.com/google/gematria
# and a certificate, custom-cert.crt, present in the root directory that you're
# building from.
COPY custom-cert.crt /usr/local/share/ca-certificates
RUN update-ca-certificates
RUN echo "Options = UnsafeLegacyRenegotiation" >> /etc/ssl/openssl.cnf
RUN apt-get install -y vim libpfm4-dev golang flex bison libelf-dev libtraceevent-dev libdw-dev libunwind-dev libdwarf-dev libc6-dbg
RUN GOBIN=/usr/local/bin go install github.com/bazelbuild/buildtools/buildifier@latest
ENV TEST_TMPDIR=/tmp/bazel-cache
ENV PATH="${PATH}:/root/go/bin"
ENV USE_BAZEL_VERSION=6.4.0
