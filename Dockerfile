############
#Dockerfile to build test platform Simple1
#Based on Ubuntu
############


FROM ubuntu:latest
MAINTAINER qwerty 
RUN mkdir /home/Documents
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y npm 
RUN apt-get install -y nodejs-lts --version 6.17.1
RUN apt-get install -y mongodb
RUN apt-get install -y gulp
CMD cd /home/Documents/

