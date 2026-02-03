@echo off
setlocal

set "FFMPEG=C:\whispercpp\ffmpeg\ffmpeg.exe"
set "TMP=C:\whispercpp\tmp"
set "MIC_NAME=Microphone (4- Shure MV7)"

taskkill /f /im ffmpeg.exe >nul 2>&1
del /f /q "%TMP%\rec.wav" >nul 2>&1

cd /d "%TMP%"

"%FFMPEG%" -y -f dshow -i audio="%MIC_NAME%" "%TMP%\rec.wav"


