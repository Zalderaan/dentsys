@echo off
setlocal

:: Set the XAMPP path
set XAMPP_PATH=C:\xampp

:: Check if XAMPP is installed
if not exist "%XAMPP_PATH%\mysql\bin\mysql.exe" (
    echo XAMPP is not installed or the path is incorrect.
    exit /b 1
)

:: set mysql path
set MYSQL_PATH=C:/xampp/mysql/bin/mysql

:: set db credentials
set DB_USER=root
set DB_NAME=dentsys

:: path to mysql file (production path, include as file in the installer)
set SQL_FILE=./dentsys.sql

:: start mysql service
net start mysql
if %ERRORLEVEL% NEQ 0 (
    echo "Failed to start mysql service"
    exit /b %ERRORLEVEL%
)

:: Create db if it doesn't exist
"%MYSQL_PATH%" -u %DB_USER% -e "CREATE DATABASE IF NOT EXISTS %DB_NAME%;"

if %ERRORLEVEL% NEQ 0 (
    echo "Failed to create database"
    exit /b %ERRORLEVEL%
) else (
    echo "Database created successfully"
)

if %ERRORLEVEL% NEQ 0 (
    echo "Failed to start mysql service"
    exit /b %ERRORLEVEL%
)

:: Run the MySQL import command
"%MYSQL_PATH%" -u %DB_USER% %DB_NAME% < %SQL_FILE%

if %ERRORLEVEL% NEQ 0 (
    echo "Failed to import database"
    exit /b %ERRORLEVEL%
) else (
    echo "Database imported successfully"
)

:: Stop mysql service
net stop mysql
endlocal
pause