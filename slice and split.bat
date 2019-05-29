@echo off

SET gswin="c:\Program Files\gs\gs9.23\bin\gswin64.exe"
SET pdfreader="c:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe"
SET source=%1

REM ###############
REM ### notes
REM ###############

REM /CropBox [0 0 514 197] - left, bottom, right, top
REM /BeginPage{1 1 scale -43 -228 translate} - scale x, scale y, move x, move y
REM MediaBox [0 0 594.72 841.68] - A4 size is 594.72x841.68 pkt (72 pkt is 1 cal); 
REM		Label 10x15 cm is 283x425 pkt
REM		Label 57x200 mm is 161.57x566.92 pkt

REM ###############
REM ### folders
REM ###############

echo ###### FILE PROCESSING: %source%
if not exist run0 mkdir run0
del run0\*.pdf >nul 2>&1
copy /V /Y %source% run0\source.pdf

REM ###############
REM ### slice
REM ###############

echo ### SLICE
if not exist run1 mkdir run1
del run1\*.pdf >nul 2>&1

REM 1
%gswin% ^
    -o "run1\1.pdf" ^
    -sDEVICE=pdfwrite ^
    -c "[/CropBox [0 0 595.44 419.76]" ^
    -c " /PAGES pdfmark" ^
	-c "<</BeginPage{1 1 scale 0 0 translate}>> setpagedevice" ^
    -f run0\source.pdf

REM 2
%gswin% ^
    -o "run1\2.pdf" ^
    -sDEVICE=pdfwrite ^
    -c "[/CropBox [0 0 595.44 419.76]" ^
    -c " /PAGES pdfmark" ^
	-c "<</BeginPage{1 1 scale 585 0 translate}>> setpagedevice" ^
    -f run0\source.pdf
	
REM %pdfreader% "run1\1.pdf" "run1\2.pdf"
REM exit /B

REM ###############	
REM ### split - removes content from outside of the CropBox	!!!
REM ###############

echo ### SPLIT
if not exist run2 mkdir run2
del run2\*.pdf run2\merge.lst >nul 2>&1

REM 1
%gswin% ^
	-sDEVICE=pdfwrite ^
	-dSAFER ^
	-o run2\%%.4d.1.pdf ^
	-f run1\1.pdf
	
REM 2
%gswin% ^
	-sDEVICE=pdfwrite ^
	-dSAFER ^
	-o run2\%%.4d.2.pdf ^
	-f run1\2.pdf
	
echo ### Caution !!! - before merge, manualy sort files in run2 folder (by rename files).




