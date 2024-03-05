# Video-to-Gif-Batch
 
### NOTE: You need to have FFMPEG installed, so it can run from command line

### For Gifski version you also need to have Gifski executable by command line
To get FFMPEG [https://ffmpeg.org/download.html](https://ffmpeg.org/download.html)

To get Gifski: [https://github.com/ImageOptim/gifski](https://github.com/ImageOptim/gifski)
 
 
 ## How to use?
 
 little batch programm that uses FFMPEG to create gifs from video snippets
 
 * 1 Drag files onto batch
 
 * 2 Choose whether to just process at is, scale individual, to scale all at same resolution or convert a gif into webp
 
 * 3 Files (and temp folders/files) get created in the same folder they were dragged from


## What the batch files do?

FFMPEG version: Directly takes video frames and converts them into a Gif

Gifski version: Uses FFMPEG to put every frame from a video into a temp folder as PNG files. Gifski then combines these single frames into a Gif.
