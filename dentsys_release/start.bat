@echo off
title Starting Dentsys

:: Step 1: Check if XAMPP is installed
IF NOT EXIST "C:\xampp\xampp-control.exe" (
    echo [ERROR] XAMPP is not installed. Please install XAMPP and try again.
    pause
    exit /b
)

:: Start XAMPP
echo Starting XAMPP Control Panel...
start "" "C:\xampp\xampp-control.exe"
timeout /t 5 /nobreak >nul

:: Start mySQL
echo Starting MYSQL service...
start C:\xampp\mysql\bin\mysqld.exe
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Failed to start MySQL. Ensure XAMPP is installed and configured properly.
    pause
    exit /b
)

:: Start backend
echo Starting server...
start /B .\dentsys_release\dentsys-api.exe
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Failed to start server. Ensure the server is installed and configured properly.
    pause
    exit /b
)
timeout /t 3 /nobreak >nul

:: Start frontend
echo Starting frontend...
start .\dentsys_release\build\windows\x64\runner\Release\dentsys_client.exe
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Failed to start server. Ensure the server is installed and configured properly.
    pause
    exit /b
)
timeout /t 3 /nobreak >nul

:: Final Step: Inform User
echo Dentsys app is now running.
pause
exit

