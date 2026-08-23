@echo off
setlocal EnableExtensions EnableDelayedExpansion

rem ============================================================
rem mkshim.bat
rem
rem Usage:
rem   mkshim program
rem       Searches for program.exe in the current directory
rem       and its subdirectories.
rem
rem   mkshim program.exe
rem
rem   mkshim "C:\Some App\program.exe"
rem       An EXE can also be dragged onto mkshim.bat.
rem
rem   mkshim "C:\Some App\program.exe" alias
rem       Creates a shim named alias.
rem ============================================================

if "%~1"=="" (
    echo Usage:
    echo   mkshim program
    echo   mkshim program.exe
    echo   mkshim "C:\path\program.exe"
    echo   mkshim "C:\path\program.exe" shimname
    exit /b 1
)

set "ARG=%~1"
set "TARGET="
set "SHIMNAME=%~2"

rem If the first argument is an existing file, use it directly.
if exist "%ARG%" (
    for %%I in ("%ARG%") do set "TARGET=%%~fI"
) else (
    rem Otherwise treat it as a program name and search below CWD.
    set "SEARCH=%ARG%"
    if /I not "!SEARCH:~-4!"==".exe" set "SEARCH=!SEARCH!.exe"

    for /r "%CD%" %%I in ("!SEARCH!") do (
        if not defined TARGET if exist "%%~fI" set "TARGET=%%~fI"
    )
)

if not defined TARGET (
    echo ERROR: executable not found: %ARG%
    exit /b 2
)

if not defined SHIMNAME (
    for %%I in ("!TARGET!") do set "SHIMNAME=%%~nI"
)

echo Executable: "!TARGET!"
echo Shim name : "!SHIMNAME!"

where scoop >nul 2>&1
if errorlevel 1 (
    echo ERROR: Scoop was not found in PATH.
    exit /b 3
)

call scoop shim add "!SHIMNAME!" "!TARGET!"
if errorlevel 1 (
    echo ERROR: Scoop failed to create the shim.
    exit /b 4
)

echo Shim created: !SHIMNAME!
exit /b 0
