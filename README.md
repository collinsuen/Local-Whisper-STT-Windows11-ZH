Local GPU-Accelerated Chinese Speech-to-Text for Windows 11 (Whisper-based)

Windows 11 本地端中文語音轉文字系統，基於 Whisper，支援 NVIDIA GPU 加速，透過 CTRL + ALT + SPACE 快捷鍵一鍵轉寫。

## Quick start
1. Start the background Whisper server:
   app/start_whisper_server.bat
2. Run the hotkey script (AutoHotkey):
   app/whisper_main.ahk
Hotkey:
Ctrl + Alt + Space
Press once to start recording, press again to stop and transcribe.
## Requirements
- Windows 11
- Python 3.10
- AutoHotkey v1.1 (Unicode)
Download AutoHotkey v1.1 (Unicode): https://www.autohotkey.com/
