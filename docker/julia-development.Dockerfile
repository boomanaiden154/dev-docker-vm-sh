ARG CUSTOM_CERT
ARG ENABLE_LEGACY_RENEGOTIATION

FROM ubuntu:22.04

ARG CUSTOM_CERT
ARG ENABLE_LEGACY_RENEGOTIATION

RUN apt-get update && apt-get install -y \
  build-essential \
  libatomic1 \
  python3 \
  gfortran \
  perl \
  wget \
  m4 \
  cmake \
  pkg-config \
  git \
  curl \
  vim

# Setup a custom certificate/SSL settings depending upon build arguments
# Include README.md here so that the build doesn't fail if there is no custom
# certificate specified. Then we just delete it afterwards.
COPY LICENSE $CUSTOM_CERT /usr/local/share/ca-certificates/
RUN rm /usr/local/share/ca-certificates/LICENSE \
  && update-ca-certificates
RUN if [ -n "$ENABLE_LEGACY_RENEGOTIATION" ]; then echo "Options = UnsafeLegacyRenegotiation" >> /etc/ssl/openssl.cnf ; fi
