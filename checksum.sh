#!/bin/zsh
# Prompt user for confirmation

# Check if the script is run as root (with sudo)
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run with sudo."
    exit 1
fi


echo "Create Checksum (MD5) for all files in this directory? (y/n)"
read response

# Check if user entered 'y' or 'Y'
if [[ "$response" =~ ^[Yy]$ ]]; then
    # If 'y' or 'Y', create MD5 checksums for all files in the current directory
    echo "Generating MD5 checksums for all files..."
    find . -type f -exec md5sum {} + > md5sums.txt
else
    # If anything other than 'y', quit the script
    echo "Quitting..."
    exit 0
fi

