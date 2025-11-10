FROM ubuntu:24.04
RUN apt-get update && apt-get install -y curl
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
RUN . ~/.nvm/nvm.sh && nvm install --lts && nvm use --lts
