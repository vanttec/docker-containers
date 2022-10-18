FROM nvcr.io/nvidia/l4t-jetpack:r35.1.0

RUN apt-get update

ARG DEBIAN_FRONTEND=noninteractive
	# Installing Base Tools
RUN apt-get update && apt-get install -y \
	gnupg2 \
	curl \
	lsb-core \
	vim wget \
	python3-pip \
	libpng16-16 \
	libjpeg-turbo8 \
	libtiff5 \
	build-essential \
	cmake \
        git \
        unzip \
        pkg-config \
	&& rm -rf /var/lib/apt/lists/*

	# Installing ROS-noetic
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
	apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 && \
	curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | apt-key add - && \
	apt-get  update && apt-get install -y \
	ros-noetic-desktop \
	python3-rosdep \
	python3-rosinstall \
	python3-rosinstall-generator \
	python3-wstool \
	&& rm -rf /var/lib/apt/lists/* && \
	rosdep init && rosdep update && \
	echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

	# Intalling python-catkin
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list' && \
	wget http://packages.ros.org/ros.key -O - | sudo apt-key add - && \
	apt-get update && apt-get install -y \
	python3-catkin-tools \
	software-properties-common \
	&& rm -rf /var/lib/apt/lists/*

RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bash_profile

RUN apt-get update && apt-get install -y \
        # Pangolin dependencies
        libgl1-mesa-dev \
        libglew-dev \
        libpython2.7-dev \
        libeigen3-dev \
        apt-transport-https \
        ca-certificates\
        software-properties-common \
    	# Build OpenCV Dependencies
	python3-dev \
	python3-numpy \
	python-dev \
	python-numpy \
	libavcodec-dev \
	libavformat-dev \
	libswscale-dev \
	libgstreamer-plugins-base1.0-dev \
	libgstreamer1.0-dev \
	libgtk-3-dev \
	libopencv-dev \
	python3-opencv \
 	&& rm -rf /var/lib/apt/lists/*


    # Build Pangolin
RUN cd /tmp && git clone https://github.com/stevenlovegrove/Pangolin && \
    cd Pangolin && git checkout v0.6 && mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS=-std=c++11 .. && \
    make -j$nproc && make install && \
    cd / && rm -rf /tmp/Pangolin

    # Install Open CV from source 
RUN cd /tmp && git clone https://github.com/opencv/opencv/ && \
    git clone https://github.com/opencv/opencv_contrib/ && \
    cd /tmp/opencv && \
    mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS=-std=c++11 -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules .. && \
    make -j4 && make install && \
    cd / && rm -rf /tmp/opencv && rm -rf /tmp/opencv_contrib

    # Set Python3 as default
RUN apt-get update && apt-get install -y \
    python-is-python3 \
    && rm -rf /var/lib/apt/lists/*
    
    # Clone and build ORB-SLAM3
RUN cd / && \
    git clone -b docker_opencv3.2_fix https://github.com/jahaniam/ORB_SLAM3 /ORB_SLAM3 && \
    cd /ORB_SLAM3 && chmod +x build.sh && ./build.sh 

COPY ros_entrypoint.sh ros_entrypoint.sh
RUN chmod +x  /ros_entrypoint.sh
ENV ROS_DISTRO noetic
ENV LANG en_US.UTF-8

ENTRYPOINT ["/ros_entrypoint.sh"]

USER $USERNAME
# terminal colors with xterm
ENV TERM xterm
WORKDIR /ORB_SLAM3
CMD ["bash"]
