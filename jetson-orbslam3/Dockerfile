FROM nvcr.io/nvidia/l4t-jetpack:r35.1.0

RUN apt-get update

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y gnupg2 curl lsb-core vim wget python3-pip libpng16-16 libjpeg-turbo8 libtiff5


# Installing ROS-noetic
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | apt-key add -
RUN apt update
RUN apt install -y ros-noetic-desktop
RUN apt-get install -y python3-rosdep
RUN rosdep init
RUN rosdep update
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
RUN apt install -y python3-rosinstall python3-rosinstall-generator python3-wstool build-essential

# Intalling python-catkin
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list'
RUN wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
RUN apt-get update
RUN apt-get install -y python3-catkin-tools
RUN apt-get install -y software-properties-common

RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bash_profile


RUN apt-get install -y \
        # Base tools
        cmake \
        build-essential \
        git \
        unzip \
        pkg-config \
        python-dev \
        # OpenCV dependencies
        python-numpy \
        # Pangolin dependencies
        libgl1-mesa-dev \
        libglew-dev \
        libpython2.7-dev \
        libeigen3-dev \
        apt-transport-https \
        ca-certificates\
        software-properties-common

RUN curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
RUN add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"
RUN apt update
RUN apt install -y sublime-text

# Build OpenCV (3.0 or higher should be fine)
RUN apt-get install -y python3-dev python3-numpy 
RUN apt-get install -y python-dev python-numpy
RUN apt-get install -y libavcodec-dev libavformat-dev libswscale-dev
RUN apt-get install -y libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev
RUN apt-get install -y libgtk-3-dev



# # Build Pangolin
RUN cd /tmp && git clone https://github.com/stevenlovegrove/Pangolin && \
    cd Pangolin && git checkout v0.6 && mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS=-std=c++11 .. && \
    make -j$nproc && make install && \
    cd / && rm -rf /tmp/Pangolin

    # Open CV
RUN cd /tmp && git clone https://github.com/opencv/opencv/
RUN cd /tmp && git clone https://github.com/opencv/opencv_contrib/
RUN cd /tmp/opencv && \
    mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS=-std=c++11 -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules .. && \
    make -j4 && make install && \
    cd / && rm -rf /tmp/opencv && rm -rf /tmp/opencv_contrib

RUN apt install -y libopencv-dev python3-opencv python-is-python3

RUN cd / && \
    git clone -b docker_opencv3.2_fix https://github.com/jahaniam/ORB_SLAM3 /ORB_SLAM3 && \
    cd /ORB_SLAM3 && chmod +x build.sh && ./build.sh 

COPY ros_entrypoint.sh /ros_entrypoint.sh
RUN chmod +x  /ros_entrypoint.sh
ENV ROS_DISTRO noetic
ENV LANG en_US.UTF-8

ENTRYPOINT ["/ros_entrypoint.sh"]

USER $USERNAME
# terminal colors with xterm
ENV TERM xterm
WORKDIR /ORB_SLAM3
CMD ["bash"]
