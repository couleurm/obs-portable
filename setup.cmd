@echo off
echo Downloading OBS [47.7MB]
::powershell Invoke-WebRequest "https://github.com/couleurm/obs-portable/archive/refs/heads/main.zip" -OutFile "$env:homedrive$env:homepath\AppData\Local\Temp\OBS-portable.zip"
echo Download Done! Unzipping..
::powershell Expand-Archive -Path "C:$env:homepath\AppData\Local\Temp\OBS-portable.zip" -D "$env:homedrive$env:homepath\Documents"
echo Download Done! Launching the OBS profile maker..
timeout 2 >nul
cls
"%HOMEDRIVE%%HOMEPATH%\Documents\OBS-portable-main\obs profile maker.bat"