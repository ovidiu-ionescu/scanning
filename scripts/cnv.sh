#!/bin/bash
# set -x
# Transforms the input tiff files into monochrome searchable pdfs
# tiff files are initially scanned in color, otherwise we can't
# eliminate the creases made when the paper was folded

for f in ~/ScannerOutput/ONVZ/Input/*.tif
do
    basename=$(basename -- "$f")
    extension="${basename##*.}"
    filename="${basename%.*}"
    echo $basename
    echo $filename
    echo $extension

    tmpname=${filename}_temp.${extension}
    
    mv $f .
    convert $basename +dither -monochrome -compress Group4 ${tmpname} 
    tesseract ${tmpname} $filename --oem 1 -l nld --dpi 300 pdf
    mv $basename ~/ScannerOutput/ONVZ/Input/Processed/

    mv ${filename}.pdf ~/ScannerOutput/ONVZ/Output/
    rm ${tmpname}
done

exit 0

# for removing everything else but the black, I found these extra parameters for convert:
#  -fill white -fuzz 50% +opaque "#000000"
# tried with different values for fuzz between 10 and 60 and results were not good


