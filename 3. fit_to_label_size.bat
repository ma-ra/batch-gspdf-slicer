@echo off

SET gswin="c:\Program Files\gs\gs9.23\bin\gswin64.exe"
SET pdfreader="c:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe"
	
REM ###############	
REM ### fit to label size
REM ###############

if not exist run4 mkdir run4
if not exist output mkdir output
del run4\*.pdf

REM gsar -s"/CropBox [0 0 594.72 140.28]" -r -f run3\merge.pdf run4\gsar.pdf
	
REM %gswin% ^
REM    -o "run0\output.pdf" ^
REM	-sDEVICE=pdfwrite ^
REM	-dDEVICEWIDTHPOINTS=566.92 ^
REM	-dDEVICEHEIGHTPOINTS=161.57 ^
REM	-dFIXEDMEDIA ^
REM	-c "<</BeginPage{0.965 1 scale 0 10.64 translate}>> setpagedevice" ^
REM    -f "run4\gsar.pdf"
	
REM %pdfreader% "run0\output.pdf"



