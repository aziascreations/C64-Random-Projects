@echo off

set PATH=%path%;%cd%\bin\dasm;%cd%\bin\vice

del /q _tmp.prg
petcat -w2 -o _tmp.prg %1
x64sc _tmp.prg
