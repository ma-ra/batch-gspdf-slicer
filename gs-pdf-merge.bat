REM merge

del run3\*.pdf

"c:\Program Files\gs\gs9.23\bin\gswin64.exe" ^
    -o run3\merge.pdf ^
	-sDEVICE=pdfwrite ^
	-f @run2\merge.lst


