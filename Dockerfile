FROM osrf/ros:humble-desktop

RUN apt-get update && apt-get install -y \
    git python3-pip tmux nano python3-colcon-common-extensions x11-apps\
    build-essential

RUN pip uninstall numpy==1.26.4
RUN pip install numpy==1.26.4
RUN pip install opencv-python pygame ultralytics pyserial

# Clone and build ZED Open Capture
WORKDIR /opt/share

RUN git clone https://github.com/stereolabs/zed-open-capture.git && \
    apt-get install -y libhidapi-dev libusb-1.0-0-dev libhidapi-libusb0 libhidapi-dev libopencv-dev libopencv-viz-dev && \
    cd zed-open-capture/udev && \
    cd .. && mkdir build && cd build && \
    cmake .. && \
    make -j$(nproc) && \
    make install && \
    ldconfig


# Source ROS 2 and the workspace environment on container startup
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
RUN echo "source /opt/share/ros2_ws/install/setup.bash" >> ~/.bashrc

# Set the working directory to the workspace
WORKDIR /opt/share/ros2_ws

RUN rm -rf var/lib/apt/lists/*

RUN echo "All done!"