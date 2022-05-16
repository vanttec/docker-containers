FROM ros:kinetic

MAINTAINER Abiel Fernandez <contact@abiel.dev>

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND noninteractive

# workaround to enable bash completion for apt-get
# see: https://github.com/tianon/docker-brew-ubuntu-core/issues/75
#RUN rm /etc/apt/apt.conf.d/docker-clean

# use closest mirror for apt updates
#RUN sed -i -e 's/http:\/\/archive/mirror:\/\/mirrors/' -e 's/http:\/\/security/mirror:\/\/mirrors/' -e 's/\/ubuntu\//\/mirrors.txt/' /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y curl apt-transport-https ca-certificates && \
    apt-get clean

# need to renew the key for some reason
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -

# OSRF distribution is better for gazebo
RUN sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list' && \
    curl -L http://packages.osrfoundation.org/gazebo.key | apt-key add -

# add non-root user
RUN useradd -m developer && \
    echo developer ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer

# install depending packages (install moveit! algorithms on the workspace side, since moveit-commander loads it from the workspace)
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y ros-$ROS_DISTRO-tf2-geometry-msgs ros-$ROS_DISTRO-pcl-ros protobuf-compiler && \
    apt-get clean

RUN apt-get update -y && apt-get install -y python3 && curl -sS https://bootstrap.pypa.io/pip/3.5/get-pip.py | sudo python3 && rm -rf /var/lib/apt/lists/*

RUN cd / && git clone https://github.com/acados/acados.git && cd acados && ls && \
    git submodule update --recursive --init && mkdir -p build && cd build && \
    cmake -DACADOS_INSTALL_DIR=/acados .. && make install -j4 && cp /acados/lib/*.so /usr/lib && \
    ldconfig

RUN pip3 install wheel && pip3 install -e /acados/interfaces/acados_template

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/acados/lib
ENV ACADOS_SOURCE_DIR=/acados

USER developer
WORKDIR /home/developer

ENV HOME /home/developer
ENV SHELL /bin/bash

# jre is required to use XML editor extension
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# colorize less
RUN echo "export LESS='-R'" >> ~/.bash_profile && \
    echo "export LESSOPEN='|pygmentize -g %s'" >> ~/.bash_profile

# enable bash completion
RUN git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it && \
    ~/.bash_it/install.sh --silent && \
    rm ~/.bashrc.bak && \
    echo "source /usr/share/bash-completion/bash_completion" >> ~/.bashrc && \
    bash -i -c "bash-it enable completion git"

RUN echo 'eval "$(register-python-argcomplete sim)"' >> ~/.bashrc

RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
    ~/.fzf/install --all

# init rosdep
RUN rosdep update

# enter ROS world
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc