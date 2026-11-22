@echo off
setlocal
cd /d "%~dp0"
echo.
echo ===== Step 1/3: preparing Python environment =====
if not exist venv ( python -m venv venv )
call venv\Scripts\activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt pyinstaller
if errorlevel 1 goto :fail

echo.
echo ===== Step 2/3: building the app (PyInstaller) =====
python -m PyInstaller --noconfirm --clean --windowed --name ForexJournal ^
  --icon assets\icon.ico --add-data "assets;assets" ^
  --exclude-module tkinter --exclude-module unittest main.py
if errorlevel 1 goto :fail
echo App built:  dist\ForexJournal\ForexJournal.exe

echo.
echo ===== Step 3/3: building the Setup installer (Inno Setup) =====
set "ISCC=%ProgramFiles(x86)%\Inno Setup 6\ISCC.exe"
if not exist "%ISCC%" set "ISCC=%ProgramFiles%\Inno Setup 6\ISCC.exe"
if not exist "%ISCC%" set "ISCC=%LocalAppData%\Programs\Inno Setup 6\ISCC.exe"
if exist "%ISCC%" (
    "%ISCC%" installer.iss
    if errorlevel 1 goto :fail
    echo.
    echo DONE!  Your installer:  installer_output\ForexJournal_Setup.exe
) else (
    echo.
    echo Inno Setup was not found. Install it from https://jrsoftware.org/isdl.php
    echo then run this file again.
    echo Portable app is ready in: dist\ForexJournal
)
pause
exit /b 0

:fail
echo.
echo *** Something went wrong. Read the messages above. ***
pause
exit /b 1