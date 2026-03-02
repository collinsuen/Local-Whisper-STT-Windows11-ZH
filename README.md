Local GPU-Accelerated Speech-to-Text for Windows 11 (Whisper-based)

Local, offline speech-to-text tool for Windows 11.
Supports Mandarin Chinese and Min Nan (Taiwanese).
Runs fully on your own machine. No cloud. No API key.

This is a semi-portable project package.
Dependencies must be installed once before use.

Download

Latest version:
https://github.com/collinsuen/Local-Whisper-STT-Windows11-ZH/releases/latest

Overview

This project allows you to:

• Press a global hotkey
• Record audio
• Transcribe using local Whisper (GPU accelerated)
• Automatically paste the text into the active window

Hotkey
Ctrl + Alt + Space
Press once to start recording
Press again to stop and transcribe

System Requirements

Windows 11
NVIDIA driver installed
CUDA runtime installed
Python 3.10
AutoHotkey v1.1 (Unicode)

Installation Guide

Step 1. Install Python 3.10

Download:
https://www.python.org/downloads/windows/

Download Python 3.10.x (Windows installer 64-bit)

Install to:
C:\Program Files\Python310

Step 2. Install FFmpeg

Download:
https://www.gyan.dev/ffmpeg/builds/

Download ffmpeg-release-essentials.zip

Extract ffmpeg.exe to:
C:\whispercpp\ffmpeg\ffmpeg.exe

Step 3. Install Whisper (GPU support)

Open Command Prompt:

Press Windows key
Type cmd
Press Enter

Run the following commands:

pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

pip install -U openai-whisper
pip install websocket-server websocket-client

Check GPU availability:

python -c "import torch; print(torch.cuda.is_available())"

If it prints True, GPU is working.
If it prints False, Whisper will run on CPU.

Step 4. Whisper Model

This project uses Whisper Medium.

You do not need to manually download the model.

On first run:

Double click start_whisper_server.bat
Wait for model download (internet required once)
Subsequent runs will be faster

Step 5. Install AutoHotkey v1.1

Download:
https://www.autohotkey.com/

Install AutoHotkey v1.1 (Unicode)
Do not install v2

Running the Project

Download the latest ZIP from Releases

Unzip the file

Run 00_Install_and_Setup.bat

Double click start_whisper_server.bat

Double click whisper_main.ahk

Press Ctrl + Alt + Space to start using

How It Works

start_whisper_server.bat runs Whisper server
whisper_main.ahk registers the global hotkey
Audio is recorded and sent to local Whisper
Transcribed text is pasted into the active window
Raw output is saved to:
C:\whispercpp\tmp\out.txt

Windows Security Notice

Windows may show a warning when running .bat files downloaded from GitHub.
This is expected for unsigned scripts.
Click Run to proceed.

---

## Windows security prompt

When running `.bat` files downloaded from GitHub, Windows may show a security warning about an unknown publisher.  
This is expected for unsigned scripts.  
Click **Run** to proceed.
