# Docker ROS2 Foxy

Simple Dockerfile to run ROS2 Foxy. This can/will be updated according to new needs of the TFC team.

## Pre-requisites
* [Install Docker Setup](https://www.docker.com/products/docker-desktop/) -> just press next and install on the Docker installation
* [If you are using Windows, install WSL2](https://learn.microsoft.com/uk-ua/windows/wsl/install) 
* For windows, [install xLaunch (VcXsrv) for GUI interface availability](https://sourceforge.net/projects/vcxsrv/)
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

### If you are using Windows:
```
docker run --name <name_you_want_to_give_to_the_container> -e DISPLAY=host.docker.internal:0.0 -it -v ${PWD}/share:/opt/share <name_of_your_image>
```

### If you are using Linux:
```
docker run --name <name_you_want_to_give_to_the_container> -e DISPLAY=host.docker.internal:0.0 -it -v $PWD/share:/opt/share <name_of_your_image>
```

## Additional information
For usefull info about docker commands, [check this](https://github.com/noshluk2/ros1_wiki/blob/main/docker/commands.md).

For a video tutorial of the basics, [check this video](https://www.youtube.com/watch?v=qWuudNxFGOQ&t=365s).
