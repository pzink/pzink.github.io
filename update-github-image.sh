#!/bin/bash
#set -x

#take photo, save
#gphoto2 --capture-image-and-download --force-overwrite --folder=/Pictures --filename=surfcam-image.jpg 

# Define variables
REPO_PATH="/Users/pz/Library/Mobile Documents/com~apple~CloudDocs/Development/pzink.pithub.io Site/pzink.github.io/"
IMAGE_PATH="/Users/pz/Library/Mobile Documents/com~apple~CloudDocs/Development/Webcam-python/surfcam-image.jpg"
COMMIT_MESSAGE="Automated image update"
BRANCH_NAME="main" # Or your target branch

# Ensure the remote uses SSH (replace with your actual repo)
git remote set-url origin git@github.com:pzink/pzink.github.io.git

# Navigate to the repository
cd "$REPO_PATH"

# Set Git user name and email
git config user.name "pz"
git config user.email "surflikeyoda@gmail.com"

# Copy or move the new image into the repository
cp "$IMAGE_PATH" "./images/surfcam-image.jpg" # Example: Copy to an 'images' folder

# Add the image file to staging
git add "./images/surfcam-image.jpg"

# Commit the changes
git commit -m "$COMMIT_MESSAGE"

# Push to the remote repository
git push origin "$BRANCH_NAME"