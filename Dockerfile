FROM registry.hsr.io/public_sim/tmc_wrs_docker:latest

USER developer

ENV CC /usr/bin/gcc
ENV CXX /usr/bin/g++

RUN rosdep update
RUN echo "source /usr/share/gazebo/setup.sh" >> ~/.bashrc
RUN echo "source /opt/wrs/setup.sh" >> ~/.bashrc
RUN echo 'export ROS_IP=`hostname -i`' >> ~/.bashrc
RUN echo 'export GAZEBO_IP_WHITE_LIST="127.0.0.1"' >> ~/.bashrc
