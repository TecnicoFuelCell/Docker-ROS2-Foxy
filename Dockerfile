FROM osrf/ros:humble-desktop

RUN apt-get update && apt-get install -y \
    git python3-pip tmux nano python3-colcon-common-extensions x11-apps\
    build-essential

RUN pip uninstall numpy==1.26.4
RUN pip install numpy==1.26.4
RUN pip install opencv-python pygame ultralytics pyserial

# Source ROS 2 and the workspace environment on container startup
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
RUN echo "source /opt/share/ros2_ws/install/setup.bash" >> ~/.bashrc

RUN rm -rf var/lib/apt/lists/*

RUN echo "All done!"