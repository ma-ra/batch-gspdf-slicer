@echo off

SET gswin="c:\Program Files\gs\gs9.23\bin\gswin64.exe"
SET pdfreader="c:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe"
SET source=%1
SET output=%source:~0,-5%-gspdf.pdf"

REM ###############
REM ### merge
REM ###############

echo ### MERGE
if not exist run3 mkdir run3
del run3\*.pdf >nul 2>&1

for %%s in (run2\*.pdf) do ECHO %%s >> run2\merge.lst

%gswin% ^
    -o run3\merge.pdf ^
	-sDEVICE=pdfwrite ^
	-f @run2\merge.lst

%pdfreader% run3\merge.pdf	
exit 



