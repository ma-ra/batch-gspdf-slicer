REM left, bottom, right, top

REM etykiety: 283 x 425

REM -c "[/CropBox [42 28 556 228]" ^
REM MediaBox [0 0 595 842]
REM left, bottom, right, top
REM scale x y

del run1\*.pdf

REM 1
"c:\Program Files\gs\gs9.23\bin\gswin64.exe" ^
    -o "run1\1.pdf" ^
    -sDEVICE=pdfwrite ^
    -c "[/CropBox [0 0 514 197]" ^
    -c " /PAGES pdfmark" ^
	-c "<</BeginPage{1 1 scale -43 -625 translate}>> setpagedevice" ^
    -f source.pdf

REM 2
"c:\Program Files\gs\gs9.23\bin\gswin64.exe" ^
    -o "run1\2.pdf" ^
    -sDEVICE=pdfwrite ^
	-c "[/CropBox [0 0 514 197]" ^
    -c " /PAGES pdfmark" ^
	-c "<</BeginPage{1 1 scale -43 -426 translate}>> setpagedevice" ^
    -f source.pdf
	
REM 3
"c:\Program Files\gs\gs9.23\bin\gswin64.exe" ^
    -o "run1\3.pdf" ^
    -sDEVICE=pdfwrite ^
	-c "[/CropBox [0 0 514 197]" ^
    -c " /PAGES pdfmark" ^
	-c "<</BeginPage{1 1 scale -43 -228 translate}>> setpagedevice" ^
    -f source.pdf
	
REM 4
"c:\Program Files\gs\gs9.23\bin\gswin64.exe" ^
    -o "run1\4.pdf" ^
    -sDEVICE=pdfwrite ^
	-c "[/CropBox [0 0 514 197]" ^
    -c " /PAGES pdfmark" ^
	-c "<</BeginPage{1 1 scale -43 -28 translate}>> setpagedevice" ^
    -f source.pdf



