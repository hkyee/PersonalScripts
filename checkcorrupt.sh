#!/bin/zsh

# Check if both md5sum.txt files are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <source_md5sum.txt> <destination_md5sum.txt>"
    exit 1
fi

# Assign variables for source and destination md5sum.txt files
source_md5="$1"
destination_md5="$2"

# Ensure both files exist
if [ ! -f "$source_md5" ]; then
    echo "Error: Source file '$source_md5' not found!"
    exit 1
fi

if [ ! -f "$destination_md5" ]; then
    echo "Error: Destination file '$destination_md5' not found!"
    exit 1
fi

# Sort both files and store in temporary sorted files
sort "$source_md5" > /tmp/source_sorted.txt
sort "$destination_md5" > /tmp/destination_sorted.txt

echo "\nComparing files..."

# Check for files present only in the source
echo "\n❌ Files present only in the source:"
comm -23 /tmp/source_sorted.txt /tmp/destination_sorted.txt | while read -r line; do
    hash=$(echo "$line" | awk '{print $1}')
    file=$(echo "$line" | awk '{print $2}')
    echo "  - $file (checksum: $hash)"
done

# Check for files present only in the destination
echo "\n❌ Files present only in the destination:"
comm -13 /tmp/source_sorted.txt /tmp/destination_sorted.txt | while read -r line; do
    hash=$(echo "$line" | awk '{print $1}')
    file=$(echo "$line" | awk '{print $2}')
    echo "  - $file (checksum: $hash)"
done

# Clean up temporary files
rm /tmp/source_sorted.txt /tmp/destination_sorted.txt

echo "\nComparison complete!"
