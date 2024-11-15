#!/bin/bash

# Prompt the user for image and container names
read -p "Enter the name of your Docker image: " image_name
read -p "Enter the name you want to give to the Docker container: " container_name

# Set the working directory to where the script is located
scriptPath="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create the directory structure in the same directory as the Dockerfile
directory="$scriptPath/share/ros2_ws/src"
if [ ! -d "$directory" ]; then
    mkdir -p "$directory"
    echo "Created directory: $directory"
else
    echo "Directory already exists: $directory"
fi

# Build the Docker image
echo "Building the Docker image '$image_name'..."
docker build -t "$image_name" .


# # List available video devices
# echo "Available video devices:"
# for device in /dev/video*; do
#     echo "$device"
# done

# # Prompt user to select a video device
# read -p "Enter the video device to map (e.g., /dev/video0): " video_device

# # Validate the selected device
# if [ -e "$video_device" ]; then
#     echo "Using video device: $video_device"
# else
#     echo "Invalid video device. Please check and rerun the script."
#     exit 1
# fi

# Check if the Docker image was built successfully
if [ $? -eq 0 ]; then
    echo "Docker image '$image_name' built successfully."

    # Run the Docker container with the specified names
    echo "Running the Docker container '$container_name'..."
    
    # --gpus all \
    # --runtime nvidia\

    docker run --name "$container_name" \
    --privileged \
    -v /dev:/dev\
    -it -v "$scriptPath/share:/opt/share" \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    "$image_name"



    # Check if the Docker container ran successfully
    if [ $? -eq 0 ]; then
        echo "Docker container '$container_name' started successfully."
    else
        echo "Failed to start Docker container '$container_name'."
    fi
else
    echo "Failed to build Docker image '$image_name'."
fi
