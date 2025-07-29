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

echo $PATH

#take photo
/usr/local/bin/imagesnap -d BRIO -w 0 surfcam-image.jpg 2>&1 >> ./imagesnap_cron.log
/usr/local/bin/imagesnap -d USB -w 0 ocean-image.jpg

sips ocean-image.jpg -o ocean-image.jpg --cropOffset 250 0 -c 350 1280

# Ensure the remote uses SSH (replace with your actual repo)
git remote set-url origin git@github.com:pzink/pzink.github.io.git

# Set Git user name and email
git config user.name "pz"
git config user.email "peterazink@gmail.com"

# Copy or move the new image into the repository
cp "$IMAGE_PATH" "images/surfcam-image.jpg" 
cp "$IMAGE2_PATH" "images/ocean-image.jpg"

# Add the image file to staging
git add "./surfcam-image.jpg"
git add "./ocean-image.jpg"

# remove images
rm "./surfcam-image.jpg" 
rm "./ocean-image.jpg"

# Commit the changes
git commit -m "$COMMIT_MESSAGE"

# Push to the remote repository
git push origin "$BRANCH_NAME"