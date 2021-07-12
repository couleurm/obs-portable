@echo off
set OBSprofilespath=%homedrive%%homepath%\Documents\OBS-portable-main\OBS\config\obs-studio\basic\profiles
title OBS Profile Maker -couleur
echo Welcome to the OBS Profile Maker! Let's get started:
echo.
echo What do you want your profile to be named?
echo.
set /p profilename=">"
cls
echo How long do you want your replay buffer to go back (in seconds)?
echo.
set /p RecRBTime=">"
cls
echo How much ram do you want replay buffer to allocate (in MBs)
echo.
set /p RecRBSize=">"
cls
echo What FPS do you want to record in?
echo.
set /p FPSout=">"
cls
echo What CQ level?
echo.
echo Choose between 1 and 30, a good middleground is around 15
echo.
set /p cqlevel=">"
cls
echo What profile?
echo.
echo Choose between high, main or baseline
echo High is the most efficient but slower at a high FPS
echo Baseline will give you the best performance at a high FPS but way larger files
echo Main is a middleground between them
echo.
set /p profile=">"
cls
:chooseres
echo To set the resolution choose between 720p 1080p or custom
echo.
set /p res=">"
if '%res%' == '1080p' (goto :set1080p)
if '%res%' == '720p' goto :set720p
if '%res%' == '1080P' (goto :set1080p)
if '%res%' == '720P' goto :set720p
if '%res%' == 'CUSTOM' goto :setcustom
if '%res%' == 'cUSTOM' goto :setcustom
if '%res%' == 'Custom' goto :setcustom
if '%res%' == 'custom' goto :setcustom
echo %res% isn't valid, either choose 1080p or 720p
pause >nul
goto :chooseres 
:set1080p
set width=1920
set height=1080
goto :write
:set720p
set width=1280
set height=720
goto :write
:setcustom
echo Set the width
set /p width=">"
echo Set the height
set /p height=">"
goto :write
:write
cd %OBSprofilespath%
mkdir %profilename%
cd .\%profilename%
::basic.ini
echo [General]> basic.ini
echo Name=%profilename%>> basic.ini
echo. >> basic.ini
echo [Video]>> basic.ini
echo BaseCX=%width%>> basic.ini
echo BaseCY=%height%>> basic.ini
echo OutputCX=%width%>> basic.ini
echo OutputCY=%height%>> basic.ini
echo FPSType=2>> basic.ini
echo FPSNum=%FPSout%>> basic.ini
echo ScaleType=bilinear>> basic.ini
echo ColorSpace=709>> basic.ini
echo.>> basic.ini
echo [Output]>> basic.ini
echo Mode=Advanced>> basic.ini
echo.>> basic.ini
echo [AdvOut]>> basic.ini
echo TrackIndex=1>> basic.ini
echo RecType=Standard>> basic.ini
echo RecFilePath=%HOMEDRIVE%/Users/%Username%/Videos>> basic.ini
echo RecFormat=mp4>> basic.ini
echo RecEncoder=jim_nvenc>> basic.ini
echo RecTracks=1>> basic.ini
echo FLVTrack=1>> basic.ini
echo FFOutputToFile=true>> basic.ini
echo FFFormat=>> basic.ini
echo FFFormatMimeType=>> basic.ini
echo FFVEncoderId=0>> basic.ini
echo FFVEncoder=>> basic.ini
echo FFAEncoderId=0>> basic.ini
echo FFAEncoder=>> basic.ini
echo FFAudioMixes=1>> basic.ini
echo RecRB=true>> basic.ini
echo RecRBTime=%RecRBTime%>> basic.ini
echo RecRBSize=%RecRBSize%>> basic.ini
echo.>> basic.ini
echo [Hotkeys]>> basic.ini
echo ReplayBuffer={\n    "ReplayBuffer.Save": [\n        {\n            "key": "OBS_KEY_F4"\n        }\n    ]\n}>> basic.ini
echo OBSBasic.StartRecording={\n    "bindings": [\n        {\n            "key": "OBS_KEY_F8"\n        }\n    ]\n}>> basic.ini
echo OBSBasic.StopRecording={\n    "bindings": [\n        {\n            "key": "OBS_KEY_F8"\n        }\n    ]\n}>> basic.ini
echo OBSBasic.EnablePreview={\n    "bindings": [\n        {\n            "key": "OBS_KEY_F9"\n        }\n    ]\n}>> basic.ini
echo OBSBasic.DisablePreview={\n    "bindings": [\n        {\n            "key": "OBS_KEY_F9"\n        }\n    ]\n}>> basic.ini
echo OBSBasic.ResetStats={\n    "bindings": [\n        {\n            "key": "OBS_KEY_F12"\n        }\n    ]\n}>> basic.ini
echo.>> basic.ini
echo [SimpleOutput]>> basic.ini
echo RecRBPrefix=R>> basic.ini
::recordEncoder.json
echo {> recordEncoder.json
echo     "bf": 0,>> recordEncoder.json
echo     "cqp": %cqlevel%,>> recordEncoder.json
echo     "keyint_sec": 1,>> recordEncoder.json
echo     "preset": "hp",>> recordEncoder.json
echo     "profile": "%profile%",>> recordEncoder.json
echo     "psycho_aq": false,>> recordEncoder.json
echo     "rate_control": "CQP">> recordEncoder.json
echo }>> recordEncoder.json
::W+R shortcut
echo @echo off>%localappdata%\Microsoft\WindowsApps\PRB.bat
echo cd "%homedrive%%homepath%\Documents\obs-portable-main\bin\64bit">>%localappdata%\Microsoft\WindowsApps\PRB.bat
echo start "OBS" OBS64.exe -p --startreplaybuffer>>%localappdata%\Microsoft\WindowsApps\PRB.bat
echo exit>>%localappdata%\Microsoft\WindowsApps\PRB.bat
::Launching OBS
cd "%homedrive%%homepath%\Documents\obs-portable-main\bin\64bit"
start "OBS" OBS64.exe -p --profile %profilename% --startreplaybuffer
exit