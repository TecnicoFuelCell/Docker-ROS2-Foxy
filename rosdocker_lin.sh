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

# Check if the Docker image was built successfully
if [ $? -eq 0 ]; then
    echo "Docker image '$image_name' built successfully."

    # Run the Docker container with the specified names
    echo "Running the Docker container '$container_name'..."
    
    docker run --name "$container_name" \
    --privileged \
    --device=/dev/video0:/dev/video0 \
    -it -v "$scriptPath/share:/opt/share" \
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
