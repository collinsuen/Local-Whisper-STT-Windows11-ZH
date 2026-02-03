# Local GPU-Accelerated Chinese Speech-to-Text for Windows 11 (Whisper-based)

This is a local Chinese speech-to-text system for Windows 11 based on Whisper.
It supports NVIDIA GPU acceleration and provides one-key transcription via a global hotkey.

Hotkey:
Ctrl + Alt + Space  
Press once to start recording, press again to stop and transcribe.

---

## Overview of required folder structure (IMPORTANT)

Before running the system, please create the following folder structure manually.

Create this base folder first:
C:\whispercpp

Then make sure the folders look like this:

C:\
 └─ whispercpp\
    ├─ start_whisper_server.bat
    ├─ stop_whisper_server.bat
    ├─ start_record.bat
    ├─ stop_and_transcribe.bat
    ├─ whisper_main.ahk
    ├─ ffmpeg\
    │  └─ ffmpeg.exe
    ├─ models\
    │  └─ ggml-small-q5_1.bin
    └─ tmp\
       ├─ whisper_server.py
       ├─ gpu_test_client.py
       ├─ punct_zh_light.py
       └─ (rec.wav, out.txt will be created automatically)

You must create these folders yourself.
Do NOT use any additional subfolders.

---

## Step 1. Download and prepare dependencies

### 1. Python 3.10

Download:
https://www.python.org/downloads/windows/

On the download page:
- Click "Download Python 3.10.x"
- Choose the Windows installer (64-bit)

During installation:
- Set the install path to:
  C:\Program Files\Python310
- Make sure python.exe and pythonw.exe exist in this folder after installation

---

### 2. FFmpeg (Windows)

Download from:
https://www.gyan.dev/ffmpeg/builds/

On the download page:
- Download "ffmpeg-release-essentials.zip"
- Do NOT download full or shared builds

After downloading:
1. Extract the zip file
2. Locate ffmpeg.exe
3. Create this folder if it does not exist:
   C:\whispercpp\ffmpeg
4. Place ffmpeg.exe at:
   C:\whispercpp\ffmpeg\ffmpeg.exe

---

### 3. Whisper engine (whisper.cpp, GPU version)

Download from:
https://github.com/ggml-org/whisper.cpp/releases

On the Releases page:
- Download:
  whisper-cublas-11.8.0-bin-x64.zip

Do NOT download:
- whisper-bin-*
- whisper-blas-*
- whisper-cublas-12.4.0-*
- Source code archives

This project requires the CUDA (cuBLAS) GPU build.

---

### 4. Whisper models

Download models from:
https://huggingface.co/ggerganov/whisper.cpp

On the model page:
- Scroll down to the "Files and versions" section
- Find the file named:
  ggml-small-q5_1.bin
- Click the download button next to this file

Do NOT download:
- Any file with ".en" in the name (English-only models)
- Larger models such as medium or large for first-time setup

Why ggml-small-q5_1.bin:
- Supports Chinese and other languages
- Smaller file size (faster download)
- Best balance of speed and accuracy for first-time users

After downloading:
1. Create this folder if it does not exist:
   C:\whispercpp\models
2. Place the downloaded file here:
   C:\whispercpp\models\ggml-small-q5_1.bin

---

### 5. AutoHotkey v1.1 (Unicode)

Download:
https://www.autohotkey.com/

Install AutoHotkey v1.1 (Unicode) using default settings.
No custom installation path is required.

After installation, you should be able to double-click:
C:\whispercpp\whisper_main.ahk

---

## Step 2. Place the application files

Make sure you have already created the folder structure described above.

Now download the release ZIP from GitHub.

Open the ZIP file and copy the files as follows:

Copy these files to:
C:\whispercpp\
- start_whisper_server.bat
- stop_whisper_server.bat
- start_record.bat
- stop_and_transcribe.bat
- whisper_main.ahk

Copy these files to:
C:\whispercpp\tmp\
- whisper_server.py
- gpu_test_client.py
- punct_zh_light.py

Do NOT extract the ZIP into a new subfolder.
Files must be placed exactly in the locations above.

---

## Step 3. Start the background Whisper server

Double-click:
C:\whispercpp\start_whisper_server.bat

The window may close immediately.
This is expected. The server runs in the background.

---

## Step 4. Start the hotkey script

Double-click:
C:\whispercpp\whisper_main.ahk

The script will stay running in the background.

---

## Step 5. Use speech-to-text

Press:
Ctrl + Alt + Space

- First press: start recording
- Second press: stop recording and transcribe

The transcription result will be saved to:
C:\whispercpp\tmp\out.txt

Note:

This system uses the clipboard to paste the transcription result.

Before pressing the hotkey:
- Place the text cursor where you want the text to appear.
- Do NOT copy or paste other content while recording.

For best results:
- Press the hotkey and wait about 1 second before speaking.
- After you finish speaking, wait about 1 second, then press the hotkey again.

The text will be pasted automatically after transcription.
If the cursor is in the wrong place, existing text may be overwritten.

---

## Windows security prompt

When running .bat files downloaded from GitHub, Windows may show a security warning about an unknown publisher.
This is expected for unsigned scripts.
Click "Run" to proceed.
