# Scanning
Various scripts for a scanning flow

## Useful commands, would fit better in snippets

- OCR _pag1.tiff_ and turn it into a searchable PDF _mytext.pdf_
```
tesseract pag1.tiff mytext --oem 1 -l nld --dpi 300 pdf
```

- Turn a color file to monochrome and use fax compression
```
convert im-000.jpg +dither -monochrome -compress Group4 pag1.pdf
```
- Turn a color file into monochrome. Result format depends on output extension, in this case _.tif_
```
convert im-000.jpg +dither -monochrome -compress Group4 pag1.tif
```

- Extract just the text part from a PDF
```
gs -o ../ScannerOutput/onlytext.pdf -sDEVICE=pdfwrite -dFILTERIMAGE big.pdf
```
