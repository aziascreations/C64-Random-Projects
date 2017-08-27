@echo off

set PATH=%path%;%cd%\bin\dasm;%cd%\bin\vice

if "%1"=="" (echo Unable to continue, no file given. && pause && exit /b)

for %%i in ("%1") do (
	call dasm %%~ni%%~xi -f1 -v0 -o%%~ni.prg
	call ruby c64-prg2bas.rb %%~ni.prg> %%~ni.bas
)

pause
exit /b

:: https://stackoverflow.com/questions/15567809/batch-extract-path-and-filename-from-a-variable
:: TODO: Check if %%~xi == .asm
