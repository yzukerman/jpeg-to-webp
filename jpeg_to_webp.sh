#!/bin/bash

# Check for the correct number of arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <source_folder> <destination_folder>"
    exit 1
fi

SOURCE_FOLDER=$1
DESTINATION_FOLDER=$2

# Check if cwebp is installed
if ! command -v cwebp &> /dev/null; then
    echo "cwebp could not be found. Please install the webp tools."
    echo "On macOS, you can use Homebrew: brew install webp"
    echo "On Debian/Ubuntu, you can use apt: sudo apt-get install webp"
    exit 1
fi

# Create the destination folder if it doesn't exist
mkdir -p "$DESTINATION_FOLDER"

# Find all jpeg files and convert them
for img in "$SOURCE_FOLDER"/*.jpg "$SOURCE_FOLDER"/*.jpeg; do
    if [ -f "$img" ]; then
        filename=$(basename "$img")
        filename_no_ext="${filename%.*}"
        cwebp "$img" -o "$DESTINATION_FOLDER/$filename_no_ext.webp"
    fi
done

echo "Conversion complete."
