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
REM MediaBox [0 0 595 842] - 842x595 pkt is A4 size; 72 pkt is 1 cal; Label 10x15 cm is 283x425 pkt

REM ###############
REM ### folders
REM ###############

if not exist run0 mkdir run0
del run0\*.pdf
if not exist output mkdir output
copy /V /Y %source% run0\source.pdf

REM ###############
REM ### slice
REM ###############

if not exist run1 mkdir run1
del run1\*.pdf

REM 1
%gswin% ^
    -o "run1\1.pdf" ^
    -sDEVICE=pdfwrite ^
    -c "[/CropBox [0 0 515 280]" ^
    -c " /PAGES pdfmark" ^
	-c "<</BeginPage{1 1 scale -10 -575 translate}>> setpagedevice" ^
    -f run0\source.pdf
	
REM 2
%gswin% ^
    -o "run1\2.pdf" ^
    -sDEVICE=pdfwrite ^
    -c "[/CropBox [0 0 515 280]" ^
    -c " /PAGES pdfmark" ^
	-c "<</BeginPage{1 1 scale -10 -295 translate}>> setpagedevice" ^
    -f run0\source.pdf

REM 3
%gswin% ^
    -o "run1\3.pdf" ^
    -sDEVICE=pdfwrite ^
    -c "[/CropBox [0 0 515 280]" ^
    -c " /PAGES pdfmark" ^
	-c "<</BeginPage{1 1 scale -10 -15 translate}>> setpagedevice" ^
    -f run0\source.pdf

REM ###############	
REM ### split - removes content from outside of the CropBox	!!!
REM ###############

if not exist run2 mkdir run2
del run2\*.pdf run2\merge.lst

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

for %%s in (run2\*.pdf) do ECHO %%s >> run2\merge.lst

REM ###############
REM ### merge
REM ###############

if not exist run3 mkdir run3
del run3\*.pdf

%gswin% ^
    -o run3\merge.pdf ^
	-sDEVICE=pdfwrite ^
	-f @run2\merge.lst

REM ###############	
REM ### fit to label size
REM ###############

if not exist run4 mkdir run4
del run4\*.pdf

gsar -s"/CropBox [0 0 515.0 280.0]" -r -f run3\merge.pdf run4\gsar.pdf
	
%gswin% ^
    -o "run0\output.pdf" ^
	-sDEVICE=pdfwrite ^
	-dDEVICEWIDTHPOINTS=425 ^
	-dDEVICEHEIGHTPOINTS=283 ^
	-dFIXEDMEDIA ^
	-c "<</BeginPage{0.82 1 scale 0 5 translate}>> setpagedevice" ^
    -f "run4\gsar.pdf"

copy /V /Y "run0\output.pdf" output\%output%	
REM %pdfreader% "run0\output.pdf"



