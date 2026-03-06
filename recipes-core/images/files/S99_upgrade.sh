#!/bin/sh

echo "Starting upgrade..."

# Get the latest release tag
LATEST_TAG=$(wget -qO- https://api.github.com/repos/LarsGrootkarzijn/buildroot-simpleaudio/releases/latest | grep '"tag_name":' | cut -d '"' -f 4) || { echo "Failed to fetch the latest release tag."; exit 1; }

# Construct the download URL
DOWNLOAD_URL="https://github.com/LarsGrootkarzijn/buildroot-simpleaudio/releases/download/${LATEST_TAG}/roomplayer.img.gz"

# Download the file
if ! wget $DOWNLOAD_URL; then
  echo "Error downloading the image file."
  exit 1
fi

zcat roomplayer.img.gz > /dev/mmcblk0

sync
reboot
