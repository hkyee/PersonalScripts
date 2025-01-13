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
    total_files=$(find . -type f | wc -l)
    current_file=0
    echo "Generating MD5 checksums for all files..."
    
    find . -type f | while read file; do
        # Increment current file count
        current_file=$((current_file + 1))
        # Calculate progress percentage
        progress=$(( (current_file * 100) / total_files ))
        
        # Update the progress
        echo -ne "Progress: $progress%   \r"  # Print progress on the same line
        
        # Generate MD5 checksum for the current file and append to the output file
        md5sum "$file" >> md5sums.txt
    done
    # Print "Done" when the process is finished
    echo -e "\nDone!"
else
    # If anything other than 'y', quit the script
    echo "Quitting..."
    exit 0
fi
