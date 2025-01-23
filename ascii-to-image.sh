#!/bin/bash

# This script creates an image with ASCII art text using FFmpeg.

# Set variables at the beginning of the script
TEXT="$1"                           # Text to be drawn on the image, passed as the first argument
OUTPUT="ascii_image.jpg"            # Name of the output image file
BACKGROUND_COLOR="blue"             # Background color of the image
WIDTH="800"                         # Width of the image
HEIGHT="600"                        # Height of the image
FONT_FILE="/usr/share/fonts/truetype/dejavu/DejaVuSansMono-Bold.ttf"  # Path to the font file
FONT_COLOR="white"                  # Color of the text
FONT_SIZE="12"                      # Size of the font
X_POSITION="(w-text_w)/2"           # X position of the text
Y_POSITION="(h-text_h)/2"           # Y position of the text


# X & Y Positioning options:
# Top left: x=0:y=0 (with 10 pixel padding x=10:y=10)
# Top center: x=(w-text_w)/2:y=0 (with 10 px padding x=(w-text_w)/2:y=10)
# Top right: x=w-tw:y=0 (with 10 px padding: x=w-tw-10:y=10)
# Centered: x=(w-text_w)/2:y=(h-text_h)/2
# Bottom left: x=0:y=h-th (with 10 px padding: x=10:y=h-th-10)
# Bottom center: x=(w-text_w)/2:y=h-th (with 10 px padding: x=(w-text_w)/2:y=h-th-10)
# Bottom right: x=w-tw:y=h-th (with 10 px padding: x=w-tw-10:y=h-th-10)

# ---------------------------- Main Script ----------------------------------- #

# Check if text argument is provided
if [ -z "$TEXT" ]; then
    echo "Usage: $0 'Your text here'"
    exit 1
fi

# Create a temporary text file with the provided text
echo "$TEXT" > /tmp/ascii_art.txt

# Check if the temporary text file was created
if [ ! -f /tmp/ascii_art.txt ]; then
    echo "Error: Failed to create temporary text file."
    exit 1
fi

# Create a solid color background image using FFmpeg
ffmpeg -f lavfi -i color=$BACKGROUND_COLOR:$WIDTH"x"$HEIGHT blue_background.jpg

# Check if the background image was created
if [ ! -f blue_background.jpg ]; then
    echo "Error: Failed to create background image."
    rm /tmp/ascii_art.txt  # Clean up if we made it this far
    exit 1
fi

# Draw text on the background image
ffmpeg -i blue_background.jpg -vf "drawtext=textfile='/tmp/ascii_art.txt':fontfile='$FONT_FILE':fontcolor=$FONT_COLOR:fontsize=$FONT_SIZE:x=$X_POSITION:y=$Y_POSITION" $OUTPUT

# Check if the final image was created
if [ ! -f $OUTPUT ]; then
    echo "Error: Failed to create the final image."
    rm /tmp/ascii_art.txt blue_background.jpg  # Clean up if we made it this far
    exit 1
fi

# Clean up temporary files
rm /tmp/ascii_art.txt blue_background.jpg

echo "The image '$OUTPUT' has been successfully created."