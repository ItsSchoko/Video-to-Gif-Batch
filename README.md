# Video-to-Gif-Batch
 
### NOTE: You need to have FFMPEG installed, so it can run from command line

### For Gifski version you also need to have Gifski executable by command line
To get Gifski: [https://github.com/ImageOptim/gifski](https://github.com/ImageOptim/gifski)
 
 
 ## How to use?
 
 little batch programm that uses FFMPEG to create gifs from video snippets
 
 * 1 Drag files onto batch
 
 * 2 Choose whether to just process at is, scale individual, or to scale all with same resolution
 
 * 3 Files get created in the same folder they where dragged from


## What the batch files do?

FFMPEG version: Directly takes videos frames and converts them into a Gif

Giski version: Uses FFMPEG to put every frame from a video into a tempfolder as PNG files. Gifski then combines thoses simgle frames into a Gif.
