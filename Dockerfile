FROM ubuntu:latest

 
RUN apt-get -y update
RUN apt-get -y upgrade
# RUN apt-get install -y build-essential

VOLUME /data

#TO RUN
# docker build -t "<IMAGENAME>:<TAGNAME>" .

#EXAMPLE
# docker build -t "ubuntu-test:Dockerfile" .

# docker run -it ubuntu-test:Dockerfile
