REM /CropBox [0 0 514 197] - left, bottom, right, top
REM /BeginPage{1 1 scale -43 -228 translate} - scale x, scale y, move x, move y

REM MediaBox [0 0 595 842] - 842x595 pkt is A4 size; 72 pkt is 1 cal; Label 10x15 cm is 283x425 pkt

REM slice
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
	
REM split - removes content from outside of the CropBox	!!!
del run2\*.pdf run2\merge.lst

REM 1
"c:\Program Files\gs\gs9.23\bin\gswin64.exe" ^
	-sDEVICE=pdfwrite ^
	-dSAFER ^
	-o run2\%%.4d.1.pdf ^
	-f run1\1.pdf
	
REM 2
"c:\Program Files\gs\gs9.23\bin\gswin64.exe" ^
	-sDEVICE=pdfwrite ^
	-dSAFER ^
	-o run2\%%.4d.2.pdf ^
	-f run1\2.pdf
	
REM 3
"c:\Program Files\gs\gs9.23\bin\gswin64.exe" ^
	-sDEVICE=pdfwrite ^
	-dSAFER ^
	-o run2\%%.4d.3.pdf ^
	-f run1\3.pdf
	
REM 4
"c:\Program Files\gs\gs9.23\bin\gswin64.exe" ^
	-sDEVICE=pdfwrite ^
	-dSAFER ^
	-o run2\%%.4d.4.pdf ^
	-f run1\4.pdf

for %%s in (run2\*.pdf) do ECHO %%s >> run2\merge.lst

REM merge

del run3\*.pdf

"c:\Program Files\gs\gs9.23\bin\gswin64.exe" ^
    -o run3\merge.pdf ^
	-sDEVICE=pdfwrite ^
	-f @run2\merge.lst
	
REM fit to label size

del run4\*.pdf

gsar -s"/CropBox [0 0 514.0 197.0]" -r -f run3\merge.pdf run4\gsar.pdf
	
"c:\Program Files\gs\gs9.23\bin\gswin64.exe" ^
    -o "output.pdf" ^
	-sDEVICE=pdfwrite ^
	-dDEVICEWIDTHPOINTS=425 ^
	-dDEVICEHEIGHTPOINTS=283 ^
	-dFIXEDMEDIA ^
	-c "<</BeginPage{0.83 1 scale -1 43 translate}>> setpagedevice" ^
    -f "run4\gsar.pdf"
	
"c:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe" output.pdf



