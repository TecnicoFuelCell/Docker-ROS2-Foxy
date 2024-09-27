FROM osrf/ros:foxy-desktop

RUN apt-get update && apt-get install -y git python3-pip tmux 
RUN rm -rf var/lib/apt/lists/*

RUN echo "All done!"