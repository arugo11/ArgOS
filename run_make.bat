@echo off
setlocal

set "CURRENT_DIR=%CD%"
for %%I in ("%CURRENT_DIR%") do set "PARENT_DIR=%%~dpI"
for %%I in ("%PARENT_DIR:~0,-1%") do set "GRANDPARENT_DIR=%%~dpI"
set "RELATIVE_PATH=.\%CURRENT_DIR:*%GRANDPARENT_DIR%=%"

..\z_tools\make.exe %* 2>&1 | powershell -Command "$input | ForEach-Object { $_ -replace [regex]::Escape('%CD%'), '%RELATIVE_PATH%' }"

endlocal