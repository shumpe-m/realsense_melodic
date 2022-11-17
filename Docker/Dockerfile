FROM nvidia/opengl:base-ubuntu18.04

ENV DEBIAN_FRONTEND=noninteractive


########################
### INSTALL PACKAGES ###
########################
RUN apt-get update && apt-get install -y \
    vim \
    wget \
    unzip \
    git \
    python-tk \
    python3-pip


###################
### ROS melodic ###
###################
RUN apt-get update && apt-get install -y \
    lsb-release \
    curl \
    gnupg2 
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt-get update && apt-get install -y \
	ros-melodic-desktop-full \
	&& echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc

RUN apt-get update && apt-get install -y --no-install-recommends \
    python-rospkg \
    python-catkin-pkg \
    python-rosinstall \
    python-rosinstall-generator \
    python-rosdep \
    python-catkin-tools \
    ros-melodic-moveit-commander \
    python
#####################
### INSTALL CMAKE ###
#####################
# Reference: https://apt.kitware.com/
RUN git clone https://gitlab.kitware.com/cmake/cmake.git \
	&& cd cmake \
	&& git checkout tags/v3.16.3 \
	&& ./bootstrap --parallel=8 \
	&& make -j8 \
	&& make install \
	&& cd .. \
	&& rm -rf cmake


##################	
### EXTRA DEPS ###
##################
RUN pip3 install catkin_pkg \
	&& pip3 install "pybind11[global]" \
	&& pip3 install pyyaml \
	&& pip3 install empy \
	&& wget -q --show-progress --progress=bar:force https://gitlab.com/libeigen/eigen/-/archive/3.3.7/eigen-3.3.7.tar.gz \
	&& tar -xzf eigen-3.3.7.tar.gz \
	&& cd eigen-3.3.7 \
	&& mkdir build && cd build \
	&& cmake .. \
	&& make install \
	&& cd ../.. \
	&& rm eigen-3.3.7.tar.gz


#########################
### INSTALL REALSENSE ###
#########################
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update \
	&& apt-get install -y software-properties-common

RUN apt-get update \
	# && apt-key adv --keyserver keys.gnupg.net --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE \
	&& apt-key adv --keyserver keyserver.ubuntu.com --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE \
	&& add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u \
	&& apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 6F3EFCDE \
	&& apt-get update \
	# Install the librealsense, Development packages & and other needed packages
	&& apt-get install -y \
	librealsense2-dkms \
	librealsense2-utils \
	librealsense2-dev  \
	librealsense2-dbg \
	# Upgrade the local packages 
	&& apt-get update && apt-get --only-upgrade install -y librealsense2-utils librealsense2-dkms ros-melodic-realsense2-camera ros-melodic-ddynamic-reconfigure

# Create catkin workspace and clone realsense git repository
RUN mkdir -p /root/catkin_ws/src
RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc \
	&& /bin/bash -c "source ~/.bashrc" \
	&& cd /root/catkin_ws/src \
	&& git clone https://github.com/IntelRealSense/realsense-ros.git -b ros1-legacy\
	&& cd realsense-ros

# Build the workspace from the repository
RUN /bin/bash -c "source ~/.bashrc" \
	&& cd /root/catkin_ws \
	&& rosdep init && rosdep update \
	&& rosdep install -r --from-paths src --ignore-src --rosdistro=melodic -y --skip-keys libfranka \
	&& /bin/bash -c "source /opt/ros/melodic/setup.bash; catkin_make clean" \
	&& /bin/bash -c "source /opt/ros/melodic/setup.bash; catkin_make --cmake-args -DCATKIN_ENABLE_TESTING=False -DCMAKE_BUILD_TYPE=Release" \
	&& /bin/bash -c "source /opt/ros/melodic/setup.bash; catkin_make install" 
	
RUN echo "source /home/Workspace/catkin_ws/devel/setup.bash" >> ~/.bashrc \
	&& /bin/bash -c "source ~/.bashrc"