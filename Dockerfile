#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:18.04
RUN apt-get update
RUN apt-get install locales

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update 
RUN apt-get -y upgrade
RUN apt-get install -y wget
RUN apt-get install -y unzip
RUN apt-get install -y build-essential
RUN apt-get install -y cmake
RUN apt-get install -y gcc
RUN apt-get install -y libcunit1-dev
RUN apt-get install -y libudev-dev
RUN apt-get install -y openjdk-8-jdk wget unzip
RUN apt-get install -y software-properties-common
RUN apt-get install -y byobu
RUN apt-get install -y curl
RUN apt-get install -y git
RUN apt-get install -y htop
RUN apt-get install -y man
RUN apt-get install -y unzip
RUN apt-get install -y vim
RUN apt-get install -y wget

#create work dir
RUN mkdir -p /workdir
WORKDIR /workdir

# Grab the checked out source
RUN wget https://services.gradle.org/distributions/gradle-4.10.2-bin.zip
RUN unzip -d /opt/gradle /workdir/gradle-*.zip
COPY . /workdir
COPY gradle.sh /etc/profile.d/
RUN chmod +x /etc/profile.d/gradle.sh
RUN sh /etc/profile.d/gradle.sh
ENV GRADLE_HOME="/opt/gradle/gradle-4.10.2/"
ENV PATH=${GRADLE_HOME}/bin:${PATH}

# Get the RPI ARM toolchains
RUN wget https://github.com/raspberrypi/tools/archive/master.zip
RUN unzip master.zip


#set tools-master as env variable to access compiler commands
#from gradle
#arm-linux-gnueabihf-g++ -std=c++11 -o hello_world_cpp hello_world.cpp
ENV PATH=${PATH}:/workdir/tools-master/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/bin
RUN gradle -v
RUN arm-linux-gnueabihf-g++ -v