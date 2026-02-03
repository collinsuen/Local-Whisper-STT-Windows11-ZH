@echo off
setlocal EnableExtensions

set "PY=C:\Program Files\Python310\python.exe"
set "TMP=C:\whispercpp\tmp"
set "LOG=%TMP%\client.log"

taskkill /f /im ffmpeg.exe >nul 2>&1

if not exist "%TMP%\rec.wav" exit /b 2

cd /d "%TMP%"

del /q "%TMP%\out.txt" >nul 2>&1
del /q "%LOG%" >nul 2>&1

"%PY%" "%TMP%\gpu_test_client.py" 1>>"%LOG%" 2>>&1
set "RC=%errorlevel%"

rem 轉寫成功才補標點
if "%RC%"=="0" (
  "%PY%" "%TMP%\punct_zh_light.py" 1>>"%LOG%" 2>>&1
)

exit /b %RC%



