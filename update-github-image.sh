#!/bin/bash
set -x

export PATH="/usr/local/bin:$PATH" # Add /usr/local/bin
export DISPLAY=:0

# Define variables for each cam
REPO_PATH="/Users/pz/Library/Mobile Documents/com~apple~CloudDocs/Development/Github site/pzink.github.io/"
IMAGE_PATH="./surfcam-image.jpg"
IMAGE2_PATH="./ocean-image.jpg"
COMMIT_MESSAGE="Automated image update"
BRANCH_NAME="main" # Or your target branch

# Navigate to the repository
cd "$REPO_PATH"

imagesnap -d USB -w 1 surfcam-image.jpg 
mv surfcam-image.jpg images/surfcam-image.jpg


#Crop images
cd images
sips surfcam-image.jpg -o surfcam-image.jpg --cropOffset 150 0 -c 300 1280
sips ocean-image.jpg -o ocean-image.jpg --cropOffset 900 0 -c 1600 4416
cd ..

# Ensure the remote uses SSH (replace with your actual repo)
git remote set-url origin git@github.com:pzink/pzink.github.io.git

# Set Git user name and email
git config user.name "pz"
git config user.email "peterazink@gmail.com"

git pull --rebase

# Copy or move the new image into the repository
git add "images/ocean-image.jpg"
git add "images/surfcam-image.jpg"

# Commit the changes
git commit -m "$COMMIT_MESSAGE"

# Push to the remote repository
git push -f origin "$BRANCH_NAME"