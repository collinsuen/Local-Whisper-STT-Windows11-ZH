@echo off
setlocal EnableExtensions EnableDelayedExpansion

rem Stop whisper_server.py launched via pythonw.exe (Windows 11)

for /f "usebackq delims=" %%P in (`
  powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$p = Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'pythonw.exe' -and $_.CommandLine -match 'whisper_server\.py' }; if ($p) { $p.ProcessId }"
`) do (
  taskkill /PID %%P /F >nul 2>&1
)

exit /b 0
