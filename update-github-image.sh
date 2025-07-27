#!/bin/bash
set -x

#take photo
imagesnap -d BRIO -w 1 surfcam-image.jpg
imagesnap -d USB -w 1 ocean-image.jpg

# Define variables for each cam
REPO_PATH="/Users/pz/Library/Mobile Documents/com~apple~CloudDocs/Development/pzink.pithub.io Site/pzink.github.io/"
IMAGE_PATH="/Users/pz/Library/Mobile Documents/com~apple~CloudDocs/Development/pzink.pithub.io Site/pzink.github.io/surfcam-image.jpg"
IMAGE2_PATH="/Users/pz/Library/Mobile Documents/com~apple~CloudDocs/Development/pzink.pithub.io Site/pzink.github.io/ocean-image.jpg"
COMMIT_MESSAGE="Automated image update"
BRANCH_NAME="main" # Or your target branch

# Ensure the remote uses SSH (replace with your actual repo)
git remote set-url origin git@github.com:pzink/pzink.github.io.git

# Navigate to the repository
cd "$REPO_PATH"

# Set Git user name and email
git config user.name "pz"
git config user.email "peterazink@gmail.com"

# Copy or move the new image into the repository
cp "$IMAGE_PATH" "./surfcam-image.jpg" # Example: Copy to an 'images' folder
cp "$IMAGE2_PATH" "./ocean-image.jpg" # Example: Copy to an 'images' folder

# Add the image file to staging
git add "./surfcam-image.jpg"
git add "./ocean-image.jpg"

# Commit the changes
git commit -m "$COMMIT_MESSAGE"

# Push to the remote repository
git push origin "$BRANCH_NAME"