FROM ubuntu:22.04
RUN apt-get update && apt-get install -y git vim curl python3 python3-pip
RUN pip3 install gurobipy
ARG LICENSE_PATH
COPY $LICENSE_PATH /opt/gurobi/gurobi.lic
COPY ./sh /sh-utils
RUN /sh-utils/configure-git.sh
