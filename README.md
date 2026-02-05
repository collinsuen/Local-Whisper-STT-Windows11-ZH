# Local GPU-Accelerated Speech-to-Text for Windows 11 (Whisper-based)

Local, offline speech-to-text tool for Windows 11.  
Supports Mandarin Chinese and Min Nan (commonly known as Taiwanese).  
Runs fully on your own machine. No cloud, no API key.

**Important:**  
This project is NOT a one-click portable app.  
You must install required dependencies before running.

**Hotkey:**  
Ctrl + Alt + Space  
Press once to start recording, press again to stop and transcribe.

---

## Quick Start (Overview)

1 Download the ZIP file from the Releases page  
2 Unzip the file  
3 Run `00_Install_and_Setup.bat` to prepare folders and place project files  
4 Follow the setup steps below to install required dependencies  
5 Double click `whisper_main.ahk` to start  
6 Press the hotkey (Ctrl + Alt + Space) to record and transcribe  

**Note:**  
`00_Install_and_Setup.bat` only prepares folders and places files.  
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
  `C:\Program Files\Python310`

---

## Step 2. Install FFmpeg

Download:  
https://www.gyan.dev/ffmpeg/builds/

- Download `ffmpeg-release-essentials.zip`  
- Extract `ffmpeg.exe` to:  
  `C:\whispercpp\ffmpeg\ffmpeg.exe`

---

## Step 3. Install Python Whisper (GPU support)

This project uses Python Whisper with NVIDIA GPU acceleration.

How to run the commands:

1 Press Windows key  
2 Type `cmd`  
3 Press Enter (a black window will open)  
4 Copy and paste the commands below into the black window  
5 Press Enter and wait until installation finishes  

Commands to run:

pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118  
pip install -U openai-whisper  
pip install websocket-server websocket-client  

Verify GPU is available (Windows):

python -c "import torch; print(torch.cuda.is_available())"

If it prints True, GPU CUDA is working correctly.

---

## Step 4. Whisper model (Medium only)

This project uses the Whisper Medium model only.

You do NOT need to manually download any model files.

The model will be downloaded automatically the first time the server starts:

- When you run `start_whisper_server.bat` for the first time
- Whisper will download the Medium model automatically
- The model will be cached locally for future runs

Requirement:
Your NVIDIA GPU must have sufficient memory to run the Medium model.

---

## Step 5. AutoHotkey v1.1 (Unicode)

Download:  
https://www.autohotkey.com/

On the download page:

- Select AutoHotkey v1.1 (Unicode)  
- Do NOT install AutoHotkey v2 (not compatible with this project)

Install with default settings.

---

## How it works

- `start_whisper_server.bat` runs the Whisper server in background  
- `whisper_main.ahk` registers the global hotkey  
- Press hotkey to record audio and transcribe  
- Result is pasted into the active window via clipboard  
- Raw output is saved to:  
  `C:\whispercpp\tmp\out.txt`

---

## Windows security prompt

When running `.bat` files downloaded from GitHub, Windows may show a security warning about an unknown publisher.  
This is expected for unsigned scripts.  
Click **Run** to proceed.
