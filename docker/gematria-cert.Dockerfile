FROM gematria
# Relies on having the gematria built from https://github.com/google/gematria
# and a certificate, custom-cert.crt, present in the root director that you're
# building from.
COPY custom-cert.crt /usr/local/share/ca-certificates/
RUN update-ca-certificates
RUN if [ -n "$ENABLE_LEGACY_RENEGOTIATION" ]; then echo "Options = UnsafeLegacyRenegotiation" >> /etc/ssl/openssl.cnf ; fi
RUN apt-get install -y vim libpfm4-dev
ENV TEST_TMPDIR=/tmp/bazel-cache
