FROM ros:foxy-ros-base 

RUN apt-get update
RUN sudo apt -y install wget 
RUN sudo apt -y install curl 
RUN sudo apt -y install git-all

USER $USERNAME
# terminal colors with xterm
ENV TERM xterm

RUN mkdir /home/ws
WORKDIR /home/ws

