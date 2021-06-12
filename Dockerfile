
FROM ubuntu:latest
ARG AKASH_VERSION
ARG AKASH_CHAIN_ID
ARG AKASH_NODE

RUN if [ -z "$AKASH_VERSION" ] ; then echo Argument not provided ; else echo Argument is $AKASH_VERSION ; fi
RUN if [ -z "$AKASH_CHAIN_ID" ] ; then echo Argument not provided ; else echo Argument is $AKASH_CHAIN_ID ; fi
RUN if [ -z "$AKASH_NODE" ] ; then echo Argument not provided ; else echo Argument is $AKASH_NODE ; fi
RUN apt-get update && apt-get install -y

RUN apt-get install apt-utils -y
RUN apt-get  install  \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    net-tools \
    lsb-release \
    zip \
    unzip \
    vim \
    bridge-utils -y

ENV TZ="America/New_York"
RUN apt-get install python3-pip -y
RUN pip3 install virtualenv
RUN apt-get upgrade -y
ENV AKASH_NET="https://raw.githubusercontent.com/ovrclk/net/master/mainnet"

ENV AKASH_KEY_NAME="putyour name here"
ENV AKASH_KEYRING_BACKEND="os"

RUN apt install git -y
RUN curl https://raw.githubusercontent.com/ovrclk/akash/master/godownloader.sh | sh
RUN virtualenv --python=python3 venv
RUN . venv/bin/activate
RUN curl -s "$AKASH_NET/genesis.json" > .akash/config/genesis.json
RUN git clone https://github.com/kubernetes-sigs/kubespray.git
RUN pip3 install -r kubespary/requirements.txt
