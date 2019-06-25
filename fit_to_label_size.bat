@echo off

SET gswin="c:\Program Files\gs\gs9.23\bin\gswin64.exe"
SET pdfreader="c:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe"
	
REM ###############	
REM ### fit to label size
REM ###############

REM /BeginPage{1 1 scale -43 -228 translate} - scale x, scale y, move x, move y

if not exist run4 mkdir run4
if not exist output mkdir output

gsar -s"/CropBox [0 0 594.72 140.28]" -r -f run3\merge.pdf run4\gsar.pdf
	
%gswin% ^
    -o "run0\output.pdf" ^
	-sDEVICE=pdfwrite ^
	-dDEVICEWIDTHPOINTS=425 ^
	-dDEVICEHEIGHTPOINTS=283 ^
	-dFIXEDMEDIA ^
	-c "<</BeginPage{0.75 1 scale -10 71.36 translate}>> setpagedevice" ^
    -f "run4\gsar.pdf"
	
%pdfreader% "run0\output.pdf"



