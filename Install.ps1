 # Download

if (-not(Test-Path -Path $env:homedrive$env:homepath\AppData\Local\Temp\OBS-portable.zip -PathType Leaf)) {
     try {
         $null = Invoke-WebRequest -UseBasicParsing "https://github.com/couleurm/obs-portable/archive/refs/heads/main.zip" -OutFile "$env:homedrive$env:homepath\AppData\Local\Temp\OBS-portable.zip"
     }
     catch {
         throw $_.Exception.Message
     }
 }
 else {
     Write-Host "OBS has already been dowloaded, skipping download"
 }

 # Extraction

 if (-not(Test-Path -Path "$env:homedrive$env:homepath\Documents\obs-portable-main")) {
     try {
         $null = Expand-Archive -Path "C:$env:homepath\AppData\Local\Temp\OBS-portable.zip" -D "$env:homedrive$env:homepath\Documents"
     }
     catch {
         throw $_.Exception.Message
     }
 }
 else {
     Write-Host "OBS has already been extraced, skipping extraction"
 }

Start-Process "$env:homedrive$env:homepath\Documents\obs-portable-main\OBS profile maker.bat"
exit