@echo off
setlocal enabledelayedexpansion

:: Check for a wifi connection
ping 8.8.8.8 -n 1 > nul
if errorlevel 1 (
    echo You are not connected to the Internet. Please check your connection.
    pause
    exit /b
)

:: Create a temporary file to store the downloaded file
set "tempFile=%TEMP%\random_key.txt"

:: Download the file for keygen using the curl thing
curl -o "%tempFile%" -s "https://raw.githubusercontent.com/technixyt/VMware17-KeyGen/main/files/keys-untested.txt"

:: Check for successful download
if not exist "%tempFile%" (
    echo Failed to download the file. Please contact the owner.
    pause
    exit /b
)

:: Count lines in the file
set /a lineCount=0
for /f %%a in ('type "%tempFile%" ^| find /c /v ""') do set lineCount=%%a

:: Generate a random number between 1 and the number of lines
set /a "randomLine=!random! %% !lineCount! + 1"

:: Get the chosen line and copy it to clipboard
set "count=0"
for /f "usebackq delims=" %%a in ("%tempFile%") do (
    set /a "count+=1"
    if !count! equ %randomLine% (
        set "chosenLine=%%a"
        echo The key is: !chosenLine!
        echo !chosenLine! | clip
        echo Product key copied to clipboard and displayed above.
        pause
        exit /b
    )
)
:: done this on stream :)
