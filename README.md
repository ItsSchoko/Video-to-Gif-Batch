# Video-to-Gif-Batch
 
### NOTE: You need to have FFMPEG installed, so it can run from command line

### For Gifski version you also need to have Gifski executable by command line
To get FFMPEG [https://ffmpeg.org/download.html](https://ffmpeg.org/download.html)

To get Gifski: [https://github.com/ImageOptim/gifski](https://github.com/ImageOptim/gifski)
 
 
 ## How to use?
 
 little batch program that uses FFMPEG (and Gifski) to create gifs from video snippets
 
 * 1 Drag files onto batch
 
 * 2 Choose whether to just process at is, scale individual, to scale all at same resolution or convert a gif into webp
 
 * 3 Files get created in the same folder they were dragged from


## What the batch files do?

FFMPEG version: Uses FFMPEG and converts input video frames into a Gif

Gifski version: Takes each single frame and directly feeds it from FFMPEG into Gifski to create a GIF. **This version needs Gifski 1.32.0+**

