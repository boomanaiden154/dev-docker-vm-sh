FROM mlgo-development
# Relies on having mlgo-development built from https://github.com/google/ml-compiler-opt
# and a certificate, custom-cert.crt, present in the root directory that you're
# building from.
COPY custom-cert.crt /usr/local/share/ca-certificates/extra
RUN update-ca-certificates
RUN echo "Options = UnsafeLegacyRenegotiation" >> /etc/ssl/openssl.cnf
