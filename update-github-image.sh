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

# take image with the web cam
imagesnap -d USB -w 1 surfcam-image.jpg 
mv surfcam-image.jpg images/surfcam-image.jpg

#Crop images
cd images
sips surfcam-image.jpg -o surfcam-image.jpg --cropOffset 150 0 -c 300 1280
sips ocean-image.jpg -o ocean-image.jpg --cropOffset 900 0 -c 1600 4416

# add date time stamp to images
let ps=$(identify -format '%w' surfcam-image.jpg)/20 # get width
datetime=$(identify -format "%[date:create]" surfcam-image.jpg)
$datetime=$(echo "$datetime" | gawk -F'[- :T+]' '{print $3"-"$2"-"$1 " " $4":"$5}' )
magick surfcam-image.jpg -fill black  -undercolor white -pointsize "$ps" -gravity southeast -annotate 0 "$datetime" surfcam-image.jpg

let ps=$(identify -format '%w' ocean-image.jpg)/20
datetime=$(identify -format "%[date:create]" ocean-image.jpg)
magick ocean-image.jpg -fill black  -undercolor white -pointsize "$ps" -gravity southeast -annotate 0 "$datetime" ocean-image.jpg

#return to main git dir
cd ..

# Ensure the remote uses SSH 
git remote set-url origin git@github.com:pzink/pzink.github.io.git

# Set Git user name and email
git config user.name "pz"
git config user.email "peterazink@gmail.com"

git pull --rebase

# Copy or move the new images into the repository
git add "images/ocean-image.jpg"
git add "images/surfcam-image.jpg"

# Commit the changes
git commit -m "$COMMIT_MESSAGE"

# Push to the remote repository
git push -f origin "$BRANCH_NAME"