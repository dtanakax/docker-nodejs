# Set the base image
FROM tanaka0323/debianjp:latest

# File Author / Maintainer
MAINTAINER Daisuke Tanaka, tanaka@infocorpus.com

ENV DEBIAN_FRONTEND noninteractive

ENV NODE_VERSION 0.12.0
ENV NPM_VERSION 2.7.1

RUN apt-get -y update

RUN apt-get install -y curl

RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 7937DFD2AB06298B2293C3187D33FF9D0246406D 114F43EE0176B71C7BC219DD50A3051F888C628D

# Installing nodejs
RUN curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz"
RUN curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc"
RUN gpg --verify SHASUMS256.txt.asc
RUN grep " node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c -
RUN tar --strip-components 1 -xzvf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local
RUN rm "node-v$NODE_VERSION-linux-x64.tar.gz"  SHASUMS256.txt.asc
RUN apt-get clean all
RUN npm install -g npm@"$NPM_VERSION"
RUN npm cache clear