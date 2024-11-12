FROM osrf/ros:foxy-desktop

RUN apt-get update && apt-get install -y \
    git python3-pip tmux nano python3-colcon-common-extensions \
    build-essential
    
RUN pip install opencv-python

# Source ROS 2 and the workspace environment on container startup
RUN echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc
RUN echo "source /opt/share/ros2_ws/install/setup.bash" >> ~/.bashrc

RUN rm -rf var/lib/apt/lists/*

RUN echo "All done!"