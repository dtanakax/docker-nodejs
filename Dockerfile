# Set the base image
FROM dtanakax/debianjp:wheezy

# File Author / Maintainer
MAINTAINER Daisuke Tanaka, dtanakax@gmail.com

ENV DEBIAN_FRONTEND noninteractive

ENV NODE_VERSION 0.12.2
ENV NPM_VERSION 2.7.5

RUN apt-get update && \
    apt-get -y install curl && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 7937DFD2AB06298B2293C3187D33FF9D0246406D 114F43EE0176B71C7BC219DD50A3051F888C628D

# Installing nodejs
RUN curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz"
RUN curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc"
RUN gpg --verify SHASUMS256.txt.asc
RUN grep " node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c -
RUN tar --strip-components 1 -xzvf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local
RUN rm "node-v$NODE_VERSION-linux-x64.tar.gz"  SHASUMS256.txt.asc

RUN npm install -g npm@"$NPM_VERSION" && \
    npm cache clear