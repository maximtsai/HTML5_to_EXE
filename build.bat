@echo off
setlocal

echo ============================================
echo   Phaser 3 Game to Windows EXE Builder
echo ============================================
echo(

REM Check that game/index.html exists
if not exist "game\index.html" (
    echo ERROR: No index.html found in the game/ folder.
    echo        Drop your Phaser 3 game files into the game/ folder first.
    pause
    exit /b 1
)

REM Copy custom icon if provided
if exist "ico\icon.ico" (
    echo [1/3] Copying custom icon from ico\icon.ico...
    if not exist "src-tauri\icons" mkdir "src-tauri\icons"
    copy /Y "ico\icon.ico" "src-tauri\icons\icon.ico" >nul
    echo       Icon applied.
) else (
    echo [1/3] No custom icon found in ico\icon.ico, using default icon.
)

REM Install npm dependencies if needed
if not exist "node_modules" (
    echo [2/3] Installing dependencies - first time only...
    call npm install
    if errorlevel 1 (
        echo ERROR: npm install failed.
        pause
        exit /b 1
    )
) else (
    echo [2/3] Dependencies already installed.
)

REM Build the EXE
echo [3/3] Building Windows EXE - this may take a few minutes on first build...
call npx tauri build
if errorlevel 1 (
    echo(
    echo ERROR: Build failed. Check the output above for details.
    pause
    exit /b 1
)

echo(
echo ============================================
echo   BUILD COMPLETE!
echo ============================================
echo(
echo   Portable EXE:
echo   src-tauri\target\release\SpellWheel.exe
echo(
echo   NSIS Installer:
dir /b "src-tauri\target\release\bundle\nsis\*.exe" 2>nul
echo(
pause
