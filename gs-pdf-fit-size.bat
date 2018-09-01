REM merge

del run4\*.pdf

REM etykiety: 283 x 425

REM -c "[/CropBox [42 28 556 228]" ^
REM MediaBox [0 0 595 842]
REM left, bottom, right, top
REM scale x y


gsar -s"/CropBox [0 0 514.0 197.0]" -r -f run3\merge.pdf run4\gsar.pdf
	
"c:\Program Files\gs\gs9.23\bin\gswin64.exe" ^
    -o "output.pdf" ^
	-sDEVICE=pdfwrite ^
	-dDEVICEWIDTHPOINTS=425 ^
	-dDEVICEHEIGHTPOINTS=283 ^
	-dFIXEDMEDIA ^
	-c "<</BeginPage{0.83 1 scale -1 42.5 translate}>> setpagedevice" ^
    -f "run4\gsar.pdf"
	
"c:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe" output.pdf