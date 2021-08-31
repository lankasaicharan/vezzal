FROM ubuntu
WORKDIR /vezzal/
RUN apt-get update
RUN apt-get -q -y install python3 m4 libx11-dev gcc mesa-common-dev libglu1-mesa-dev git tree
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -q -y install tcl-dev tk-dev
RUN mkdir /vezzal/tools/
RUN mkdir /vezzal/scripts/
COPY ./scripts /vezzal/scripts
COPY ./Makefile /vezzal/Makefile
COPY ./README.md /vezzal/README.md
RUN chmod 755 /vezzal/Makefile
RUN chmod 755 /vezzal/scripts/*

