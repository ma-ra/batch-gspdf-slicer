REM merge

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


