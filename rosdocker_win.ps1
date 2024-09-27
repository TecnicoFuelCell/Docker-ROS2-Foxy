# Prompt the user for image and container names
$image_name = Read-Host "Enter the name of your Docker image"
$container_name = Read-Host "Enter the name you want to give to the Docker container"


# Set the working directory to where the script is located
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
cd $scriptPath

# Create the directory structure in the same directory as the Dockerfile
$directory = "$scriptPath\share\catkin_ws\src"
if (-Not (Test-Path $directory)) {
    New-Item -ItemType Directory -Path $directory -Force
    Write-Host "Created directory: $directory"
} else {
    Write-Host "Directory already exists: $directory"
}

# Build the Docker image
Write-Host "Building the Docker image '$image_name'..."
docker build -t $image_name .

# Check if the Docker image was built successfully
if ($LASTEXITCODE -eq 0) {
    Write-Host "Docker image '$image_name' built successfully."
    
    # Run the Docker container with the specified names
    Write-Host "Running the Docker container '$container_name'..."
    docker run --name $container_name -e DISPLAY=host.docker.internal:0.0 -it -v "$scriptPath/share:/opt/share" $image_name
    
    # Check if the Docker container ran successfully
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Docker container '$container_name' started successfully."
    } else {
        Write-Host "Failed to start Docker container '$container_name'."
    }
} else {
    Write-Host "Failed to build Docker image '$image_name'."
}
