@echo off

for %%s in (*.pdf) do gspdf-slicer.bat "%%s"
rmdir /S /Q run0 run1 run2 run3 run4


