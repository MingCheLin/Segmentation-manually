# Segmentation-manually
SEGMENT function provide a manually segment method in Matlab.It's working based on Matlab built-in function DRAWFREEHAND and CREATEMASK.


\[Mask] = segment(Image,\_\_\_) <br>
>show input image at left side. Enable user to segment on image manually and generate the mask as output.Input image data must with format X*Y*frame. Or if input image is RGB image, the format must be X\*Y\*RGB\*frame.

\[Mask,Edge] = segment(Image,\_\_\_) <br>
>not only output the segmentation area but also output the edge.
<br>
If not satiftied with previous segmentation, enter 'Y' or 'y' to redraw the segmentation.Otherwise, press enter to do the next frame.
<br>
optional input arguments including CM, RGB, SAVEPOINT and SAVE:<br>
>      CM :         double. Change the display colormap in image, default as gray(256) <br>
      RGB :        logical. If the input image is 3-dimensional(x\*y\*frame) it will <br>
                   default as False.Or it will be True and display image as RGB <br>
                   image. But if input image is RGB image and only have 1 frame <br>
                   please change RGB as True to prevent SEGMENT mistaken input <br>
                   image as 3 frames gray-scaled image. <br>
      SAVEPOINT :  double. Save segmentation as mat file with interval of <br>
                   SAVEPOINT, default as 0 means don't save. <br>
      SAVE :       logical. Save all output as mat file, default as False(not \n
                   save.)
