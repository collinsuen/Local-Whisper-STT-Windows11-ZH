# Local GPU-Accelerated Speech-to-Text for Windows 11 (Whisper-based)

Local, offline speech-to-text tool for Windows 11.  
Supports Mandarin Chinese and Min Nan (commonly known as Taiwanese).  
Runs fully on your own machine. No cloud, no API key.

Important:
This project is NOT a one-click portable app.
You must install required dependencies before running.

Hotkey:  
Ctrl + Alt + Space  
Press once to start recording, press again to stop and transcribe.

---

## Quick Start (Overview)

1 Download the ZIP file from the Releases page  
2 Unzip the file  
3 Run 00_Install_and_Setup.bat to prepare folders and place files  
4 Follow the setup steps below to install required dependencies  
5 Double click whisper_main.ahk to start  
6 Press the hotkey ( Ctrl + Alt + Space  ) to record and transcribe

Note:
00_Install_and_Setup.bat only prepares folders and places files.
It does NOT install any dependencies.

---

## System Requirements

- Windows 11  
- NVIDIA GPU with CUDA support  
- Python 3.10  
- AutoHotkey v1.1 (Unicode)

---

## Step 1. Install Python 3.10

Download:  
https://www.python.org/downloads/windows/

- Download Python 3.10.x (Windows installer 64-bit)  
- Install to:  
  C:\Program Files\Python310  

---

## Step 2. Install FFmpeg

Download:  
https://www.gyan.dev/ffmpeg/builds/

- Download ffmpeg-release-essentials.zip  
- Extract ffmpeg.exe to:  

C:\whispercpp\ffmpeg\ffmpeg.exe  

---

## Step 3. Install whisper.cpp (GPU build)

Download:  
https://github.com/ggml-org/whisper.cpp/releases  

- Download: whisper-cublas-11.8.0-bin-x64.zip  
- This project requires the CUDA GPU build  

---

## Step 4. Whisper model (Medium only)

This project uses the Whisper Medium model only.

You do NOT need to manually download any model files.
The model will be downloaded automatically when the server starts for the first time.

Requirement:
Your NVIDIA GPU (e.g. 4060 or above) must have sufficient memory to run the Medium model.
Note:
The model is downloaded on first run and requires an internet connection once.

---

### 5. AutoHotkey v1.1 (Unicode)

Download:
https://www.autohotkey.com/

On the download page:
- Select AutoHotkey v1.1 (Unicode)
- Do NOT install AutoHotkey v2 (not compatible with this project)

Install with default settings.

---

## How it works

- start_whisper_server.bat runs the Whisper server in background  
- whisper_main.ahk registers the global hotkey  
- Press hotkey to record audio and transcribe  
- Result is pasted into the active window via clipboard  
- Raw output is saved to:  

C:\whispercpp\tmp\out.txt  

---

## Windows security prompt

When running .bat files downloaded from GitHub, Windows may show a security warning about an unknown publisher.  
This is expected for unsigned scripts.  
Click Run to proceed.
