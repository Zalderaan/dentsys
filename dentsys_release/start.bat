@echo off

REM start the backend's exe in the background
start /B .\dentsys_release\dentsys-api.exe

REM start the frontend exe
start .\dentsys_release\build\windows\x64\runner\Release\dentsys_client.exe
