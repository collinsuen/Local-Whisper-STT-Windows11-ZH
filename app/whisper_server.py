import sys
import os

# Block console launch via python.exe
# Allow background launch via pythonw.exe
if os.path.basename(sys.executable).lower() == "python.exe":
    raise SystemExit(0)

import json
import time
import traceback
import torch
import whisper
from websocket_server import WebsocketServer

HOST = "127.0.0.1"
PORT = 8765

MODEL_NAME = "medium"
LANG = "Chinese"
FORCE_DEVICE = "cuda"

def pick_device():
    if FORCE_DEVICE == "cuda":
        if torch.cuda.is_available():
            return "cuda"
        print("GPU NOT AVAILABLE")
        return "cpu"
    return "cpu"

DEVICE = pick_device()

print("SERVER START")
print(f"LISTEN: ws://{HOST}:{PORT}")
print(f"TORCH CUDA AVAILABLE: {torch.cuda.is_available()}")
if torch.cuda.is_available():
    print(f"GPU: {torch.cuda.get_device_name(0)}")
print(f"DEVICE SELECTED: {DEVICE}")
print(f"LOADING MODEL: {MODEL_NAME}")

t0 = time.time()
model = whisper.load_model(MODEL_NAME, device=DEVICE)
print(f"MODEL LOADED IN {time.time() - t0:.2f} sec")
print("READY")

def on_message(client, server, message):
    try:
        data = json.loads(message)
        wav_path = data.get("wav_path")
        if not wav_path:
            server.send_message(client, json.dumps({"ok": False, "error": "missing wav_path"}))
            return

        t1 = time.time()
        result = model.transcribe(wav_path, language=LANG, fp16=(DEVICE == "cuda"))
        text = (result.get("text") or "").strip()
        server.send_message(client, json.dumps({"ok": True, "text": text, "sec": round(time.time() - t1, 2)}))
    except Exception as e:
        print("ERROR:", str(e))
        print(traceback.format_exc())
        try:
            server.send_message(client, json.dumps({"ok": False, "error": str(e)}))
        except Exception:
            pass

server = WebsocketServer(host=HOST, port=PORT, loglevel=1)
server.set_fn_message_received(on_message)
server.run_forever()
