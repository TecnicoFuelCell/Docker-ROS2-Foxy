# Docker ROS2 Humble

Dockerfile to run ROS2 Humble with CUDA capabilities for computer vision. This can/will be updated according to new needs of the TFC team. At the moment it is able to run YOLO with a ZED camera. 
We recommend the use of a docker extension, such as the one on VSCode, for further container handling.

*Warning: The latest upload (2024/11/17) does not have testing for Windows yet*

## Pre-requisites
* [Install Docker Setup](https://www.docker.com/products/docker-desktop/) -> just press next and install on the Docker installation
* [If you are using Windows, install WSL2](https://learn.microsoft.com/uk-ua/windows/wsl/install) 
* For windows, [install xLaunch (VcXsrv) for GUI interface availability](https://sourceforge.net/projects/vcxsrv/)
* CUDA Toolkit version [12.1](https://developer.nvidia.com/cuda-12-1-0-download-archive) or [12.4](https://developer.nvidia.com/cuda-12-4-0-download-archive) (12.4 is recommended)
* For linux, run the following lines:
```
sudo apt update
sudo apt install x11-xserver-utils
xhost +local:docker
```

## Script Procedure
* If you are using Windows, run the win script
* If you are using Linux, run the lin script

## No Script Procedure
* Download the docker file
* On the directory where the docker file is, open a terminal (not a wsl one) and write:
```
docker build -t <name_you_want_to_give_to_the_image> .
```
* Open xLaunch and select the display number as 0 and proceed with the pre-selected things
* Create on the same directory as the Dockerfile a directory /share/catkin_ws/src
* Create the container as follows:

### If you are using Windows (to be tested, so, not yet updated):
```
docker run --name <name_you_want_to_give_to_the_container> -e DISPLAY=host.docker.internal:0.0 -it -v ${PWD}/share:/opt/share <name_of_your_image>
```

### If you are using Linux:
```
docker run --name <name_you_want_to_give_to_the_container> --privileged --gpus all -v /dev:/dev -it -v "<your_ros2_ws_path>:/opt/share/ros2_ws" -env="DISPLAY" --env="QT_X11_NO_MITSHM=1" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" <name_of_your_image>
```