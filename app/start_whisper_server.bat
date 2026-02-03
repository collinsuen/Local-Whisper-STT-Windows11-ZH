@echo off
setlocal EnableExtensions

set "PYW=C:\Program Files\Python310\pythonw.exe"
set "TMP=C:\whispercpp\tmp"
set "SERVER=%TMP%\whisper_server.py"
set "LOG=%TMP%\server.log"

if not exist "%TMP%" mkdir "%TMP%"

if not exist "%PYW%" exit /b 10
if not exist "%SERVER%" exit /b 11

rem 如果已經在跑 whisper_server.py 就直接退出，避免重複啟動
for /f "tokens=1" %%P in ('wmic process where "name='pythonw.exe' and commandline like '%%whisper_server.py%%'" get ProcessId ^| findstr /r "[0-9]"') do (
  exit /b 0
)

cd /d "%TMP%"

start "" "%PYW%" "%SERVER%" 1>>"%LOG%" 2>>&1

exit /b 0


