# Copyright 2020 Abudori Lab.
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.


#!/bin/bash
# Reference sites
# https://github.com/ros2/ros2_documentation/tree/dashing
# https://github.com/ROBOTIS-GIT/emanual
# https://github.com/ros-planning/navigation.ros.org
# http://gazebosim.org/tutorials?tut=install_ubuntu&cat=install
# https://github.com/ros2/rosbag2
# https://github.com/cartographer-project/cartographer

# ROS2_dashing
install_ROS2_dashing(){
    echo "Installing ROS2 dashing..."
    locale # check for UTF-8

    sudo apt update && sudo apt install locales
    sudo locale-gen en_US en_US.UTF-8
    sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
    export LANG=en_US.UTF-8

    locale  # verify settings

    # first authorize our GPG key with apt 
    sudo apt update && sudo apt install curl gnupg2 lsb-release
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

    # add the repository to your sources list
    sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'

    sudo apt update

    sudo apt install -y ros-dashing-desktop

    source /opt/ros/dashing/setup.bash

    #Install development tools and  ROS tools
    sudo apt update && sudo apt install -y \
    build-essential \
    cmake \
    git \
    libbullet-dev \
    python3-argcomplete \
    python3-colcon-common-extensions \
    python3-flake8 \
    python3-pip \
    python3-pytest-cov \
    python3-rosdep \
    python3-setuptools \
    python3-vcstool \
    wget
    # install some pip packages needed for testing
    python3 -m pip install -U \
    argcomplete \
    flake8-blind-except \
    flake8-builtins \
    flake8-class-newline \
    flake8-comprehensions \
    flake8-deprecated \
    flake8-docstrings \
    flake8-import-order \
    flake8-quotes \
    pytest-repeat \
    pytest-rerunfailures \
    pytest
    # install Fast-RTPS dependencies
    sudo apt install --no-install-recommends -y \
    libasio-dev \
    libtinyxml2-dev
    # install Cyclone DDS dependencies
    sudo apt install --no-install-recommends -y \
    libcunit1-dev

    #path setting
    echo "source /opt/ros/dashing/setup.bash" >> ~/.bashrc
}

# Install Cartographer
install_Cartographer(){
    echo "Installing Google Cartographer..."
    sudo apt update && sudo apt install -y \
    google-mock \
    libceres-dev \
    liblua5.3-dev \
    libboost-dev \
    libboost-iostreams-dev \
    libprotobuf-dev \
    protobuf-compiler \
    libcairo2-dev \
    libpcl-dev \
    python3-sphinx

    sudo apt install ros-dashing-cartographer
    sudo apt install ros-dashing-cartographer-ros
}

#Install gazebo
install_gazebo(){
    echo "Installing Gazebo..."
    curl -sSL http://get.gazebosim.org | sh
    sudo apt install libgazebo9-dev
    sudo apt install ros-dashing-gazebo-*
    export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:/opt/ros/dashing/share/turtlebot3_gazebo/models
}

#Install Navigation2
install_Navigation2(){
    echo "Installing Navigation2..."
    sudo apt install ros-dashing-navigation2
    sudo apt install ros-dashing-nav2-bringup
}

#Install Turtlebot3
install_Turtlebot3(){
    echo "Installing Turtlebot3..."
    sudo apt install ros-dashing-turtlebot3*
}

#Install ros2bag
install_ro2bag(){
    echo "Installing ros2bag..."
    apt-get install ros-dashing-rosbag2-storage-default-plugins ros-dashing-ros2bag
    sudo apt-get install ros-dashing-ros2bag ros-dashing-rosbag2-transport
}

#Install RPLidar


#main
install_ROS2_dashing
install_Cartographer
install_gazebo
install_Navigation2
install_Turtlebot3
install_ro2bag