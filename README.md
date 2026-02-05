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
- NVIDIA driver and CUDA runtime installed
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

---

## Step 3. Install Python Whisper (GPU support)

This project uses Python Whisper with NVIDIA GPU acceleration.

### How to run the commands (for beginners)

1 Press **Windows key**
2 Type **cmd**
3 Press **Enter**
4 You will see a **black window** (Command Prompt)
5 Click inside the black window
6 Copy the commands below
7 Paste into the black window (right click to paste)
8 Press **Enter**
9 Wait until it finishes (it may take several minutes)

### Commands to run (copy all)

pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118  
pip install -U openai-whisper  
pip install websocket-server websocket-client  

### Check if GPU is working (copy and run)

python -c "import torch; print(torch.cuda.is_available())"

If it prints **True**, GPU CUDA is working correctly.  
If it prints **False**, GPU is not available and Whisper will run on CPU (very slow).  
In that case, check your NVIDIA driver / CUDA setup.

---

## Step 4. Whisper model (Medium only)

This project uses the **Whisper Medium** model only.

You do NOT need to manually download any model files.

The first time you start the server, Whisper will automatically download the Medium model.  
This requires an internet connection only once.

### What you will do

1 Double click `start_whisper_server.bat` for the first time  
2 Wait (first run can take longer because it downloads the model)  
3 Next time you start it, it will be faster (model is cached)

---

## Step 5. Install AutoHotkey v1.1 (Unicode)

Download:  
https://www.autohotkey.com/

On the download page:

- Select **AutoHotkey v1.1 (Unicode)**
- Do NOT install **AutoHotkey v2** (not compatible with this project)

Install with default settings.

---

## How it works

- `start_whisper_server.bat` runs the Whisper server in background  
- `whisper_main.ahk` registers the global hotkey  
- Press the hotkey to record audio and transcribe  
- The transcription is pasted into the active window via clipboard  
- Raw output is saved to:  
  `C:\whispercpp\tmp\out.txt`

---

## Windows security prompt

When running `.bat` files downloaded from GitHub, Windows may show a security warning about an unknown publisher.  
This is expected for unsigned scripts.  
Click **Run** to proceed.
