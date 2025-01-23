# ASCII Art Image Generator
This Bash script uses FFmpeg to create an image with ASCII art text. 
It allows for customization of the image's background color, size, text font, color, size, and positioning.

## Features
-  **Custom Text:** Pass any text as an argument to generate an image with that text in ASCII art.
-  **Custom Image Size:** Define the image's width and height.
-  **Background Color:** Choose any color for the image background.
-  **Font Customization:** Specify the font file, color, and size.
-  **Text Positioning:** Center the text or position it in any corner of the image with optional padding.
 
## Requirements
-  **FFmpeg:** Must be installed on your system to run this script. Install with:
```sh 
sudo apt-get install ffmpeg
```

-  **DejaVu Font:** The script uses DejaVuSansMono-Bold.ttf by default. Ensure you have this font installed:
```sh
sudo apt-get install fonts-dejavu
```
  
## Usage
To use this script, you can run it from the command line with:
```sh
./ascii_art_generator.sh  "Your text here"
```
  -  **Your  text  here:**  Replace  with  the  text  you  want  to  turn  into  an  ASCII  art  image.

## Example

```sh
./ascii_art_generator.sh "Hello, World!"
```
or with current time:
```sh
./ascii_art_generator.sh "$(date "+%Y-%m-%d %H:%M:%S")"
 ```

## Script Variables
You can customize the following variables at the start of the script:
- **OUTPUT:** Name of the output image file.
- **BACKGROUND_COLOR:** Color of the image background.
- **WIDTH & HEIGHT:** Dimensions of the output image in pixels.
- **FONT_FILE:** Path to the font file to use for the text.
- **FONT_COLOR:** Color of the text.
- **FONT_SIZE:** Size of the font in pixels.
- **X_POSITION & Y_POSITION:** Positioning of the text on the image. Use expressions like (w-text_w)/2 for centering.
 
## Text Positioning (ffmpeg drawtext)
You can adjust the X_POSITION and Y_POSITION variables to place your text in different parts of the image:
- **Top Left:** x=0:y=0 (with 10 pixel padding x=10:y=10)
- **Top Center:** x=(w-text_w)/2:y=0 (with 10 px padding x=(w-text_w)/2:y=10)
- **Top Right:** x=w-tw:y=0 (with 10 px padding x=w-tw-10:y=10)
- **Centered:** x=(w-text_w)/2:y=(h-text_h)/2
- **Bottom Left:** x=0:y=h-th (with 10 px padding x=10:y=h-th-10)
- **Bottom Center:** x=(w-text_w)/2:y=h-th (with 10 px padding x=(w-text_w)/2:y=h-th-10)
- **Bottom Right:** x=w-tw:y=h-th (with 10 px padding x=w-tw-10:y=h-th-10)

Where:
- **w and h** are the width and height of the image.
- ** text_w and text_h** are the width and height of the text.

## Notes
The script creates temporary files during execution which are cleaned up afterward.
If any step fails (like creating the background image or the final image), the script will exit with an error message and attempt to clean up the temporary files.