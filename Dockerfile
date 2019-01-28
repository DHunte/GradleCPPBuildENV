#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:16.04
RUN apt-get update
RUN apt-get install locales

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN add-apt-repository ppa:cwchien/gradle && \
RUN apt-get update && \
RUN apt-get -y upgrade && \
RUN apt-get install -qq wget unzip build-essential cmake gcc libcunit1-dev libudev-dev && \
RUN apt-get install -y openjdk-8-jdk wget unzip && \
RUN apt-get install -y software-properties-common && \
RUN apt-get install gradle && \
RUN apt-get install -y byobu curl git htop man unzip vim wget

# Grab the checked out source
RUN mkdir -p /workdir
WORKDIR /workdir
RUN wget https://services.gradle.org/distributions/gradle-4.10.2-bin.zip
RUN unzip -d /opt/gradle /workdir/gradle-*.zip
COPY . /workdir
COPY gradle.sh /etc/profile.d/
RUN chmod +x /etc/profile.d/gradle.sh
RUN source /etc/profile.d/gradle.sh