@echo off

SET gswin="c:\Program Files\gs\gs9.23\bin\gswin64.exe"
SET pdfreader="c:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe"
SET source=%1
SET output=%source:~0,-5%-zebra.pdf"

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
    -c "[/CropBox [0 0 594.72 140.28]" ^
    -c " /PAGES pdfmark" ^
	-c "<</BeginPage{1 1 scale 0 -701.4 translate}>> setpagedevice" ^
    -f run0\source.pdf

REM 2
%gswin% ^
    -o "run1\2.pdf" ^
    -sDEVICE=pdfwrite ^
    -c "[/CropBox [0 0 594.72 140.28]" ^
    -c " /PAGES pdfmark" ^
	-c "<</BeginPage{1 1 scale 0 -561.12 translate}>> setpagedevice" ^
    -f run0\source.pdf
	
REM 3
%gswin% ^
    -o "run1\3.pdf" ^
    -sDEVICE=pdfwrite ^
    -c "[/CropBox [0 0 594.72 140.28]" ^
    -c " /PAGES pdfmark" ^
	-c "<</BeginPage{1 1 scale 0 -420.84 translate}>> setpagedevice" ^
    -f run0\source.pdf
	
REM 4
%gswin% ^
    -o "run1\4.pdf" ^
    -sDEVICE=pdfwrite ^
    -c "[/CropBox [0 0 594.72 140.28]" ^
    -c " /PAGES pdfmark" ^
	-c "<</BeginPage{1 1 scale 0 -280.56 translate}>> setpagedevice" ^
    -f run0\source.pdf
	
REM 5
%gswin% ^
    -o "run1\5.pdf" ^
    -sDEVICE=pdfwrite ^
    -c "[/CropBox [0 0 594.72 140.28]" ^
    -c " /PAGES pdfmark" ^
	-c "<</BeginPage{1 1 scale 0 -140.28 translate}>> setpagedevice" ^
    -f run0\source.pdf
	
REM 6
%gswin% ^
    -o "run1\6.pdf" ^
    -sDEVICE=pdfwrite ^
    -c "[/CropBox [0 0 594.72 140.28]" ^
    -c " /PAGES pdfmark" ^
	-c "<</BeginPage{1 1 scale 0 0 translate}>> setpagedevice" ^
    -f run0\source.pdf
	
REM %pdfreader% "run1\1.pdf" "run1\2.pdf" "run1\3.pdf" "run1\4.pdf" "run1\5.pdf" "run1\6.pdf"
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
	
REM 3
%gswin% ^
	-sDEVICE=pdfwrite ^
	-dSAFER ^
	-o run2\%%.4d.3.pdf ^
	-f run1\3.pdf
	
REM 4
%gswin% ^
	-sDEVICE=pdfwrite ^
	-dSAFER ^
	-o run2\%%.4d.4.pdf ^
	-f run1\4.pdf
	
REM 5
%gswin% ^
	-sDEVICE=pdfwrite ^
	-dSAFER ^
	-o run2\%%.4d.5.pdf ^
	-f run1\5.pdf
	
REM 4
%gswin% ^
	-sDEVICE=pdfwrite ^
	-dSAFER ^
	-o run2\%%.4d.6.pdf ^
	-f run1\6.pdf

for %%s in (run2\*.pdf) do ECHO %%s >> run2\merge.lst

REM ###############
REM ### merge
REM ###############

echo ### MERGE
if not exist run3 mkdir run3
del run3\*.pdf >nul 2>&1

%gswin% ^
    -o run3\merge.pdf ^
	-sDEVICE=pdfwrite ^
	-f @run2\merge.lst
	
REM ###############	
REM ### fit to label size
REM ###############

echo ### FIT TO LABEL SIZE
if not exist run4 mkdir run4
if not exist output mkdir output
if not exist removed mkdir removed
del run4\*.pdf >nul 2>&1

gsar -s"/CropBox [0 0 594.72 140.28]" -r -f run3\merge.pdf run4\gsar.pdf
	
%gswin% ^
    -o "run0\output.pdf" ^
	-sDEVICE=pdfwrite ^
	-dDEVICEWIDTHPOINTS=425 ^
	-dDEVICEHEIGHTPOINTS=283 ^
	-dFIXEDMEDIA ^
	-c "<</BeginPage{0.75 1 scale -10 71.36 translate}>> setpagedevice" ^
    -f "run4\gsar.pdf"

copy /V /Y "run0\output.pdf" output\%output%
move /Y %source% removed\	



