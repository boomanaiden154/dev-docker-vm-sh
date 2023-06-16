FROM alpine:edge
RUN echo "/home/builder/packages/main" > /etc/apk/repositories && \
    echo "/home/builder/packages/community" >> /etc/apk/repositories && \
    echo "/home/builder/packages/testing" >> /etc/apk/repositories && \
    echo "https://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk upgrade --available && apk add alpine-sdk vim sudo
# Setup a cache so that we don't have to pull packages from the network every time
RUN mkdir /apk-cache && ln -s /apk-cache /etc/apk/cache
RUN adduser -D -s /bin/sh builder
RUN echo "builder ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers
RUN addgroup builder abuild
USER builder
RUN abuild-keygen -a -i -n
WORKDIR /home/builder
RUN git clone https://gitlab.alpinelinux.org/alpine/aports.git
WORKDIR /home/builder/aports
RUN git remote add fork https://gitlab.alpinelinux.org/boomanaiden154/aports.git
COPY ./sh/configure-git.sh ./
RUN ./configure-git.sh && rm ./configure-git.sh
ENTRYPOINT ["/bin/sh"]
