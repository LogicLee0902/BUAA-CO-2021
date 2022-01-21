@echo off&setlocal enabledelayedexpansion
for /r %%a in (src.txt) do (
for /f "skip=1 tokens=*" %%i in (%%a) do echo %%i>>new-%%~na.txt
move "new-%%~na.txt" "%%a")