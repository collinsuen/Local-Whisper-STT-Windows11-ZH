import json
import time
import sys
import websocket

URL = "ws://127.0.0.1:8765"
WAV = "rec.wav"
OUT = "out.txt"

def connect_with_retry(max_retry=40, wait_sec=0.5):
    last_err = None
    for _ in range(max_retry):
        try:
            return websocket.create_connection(URL, timeout=6)
        except Exception as e:
            last_err = e
            time.sleep(wait_sec)
    raise last_err

def main():
    try:
        ws = connect_with_retry()
    except Exception as e:
        print("CONNECT FAIL:", str(e))
        sys.exit(5)

    try:
        ws.send(json.dumps({"wav_path": WAV}))
        ret = ws.recv()
        data = json.loads(ret)

        if not data.get("ok"):
            print("SERVER ERROR:", data.get("error"))
            sys.exit(6)

        text = (data.get("text") or "").strip()
        with open(OUT, "w", encoding="utf-8") as f:
            f.write(text)

        sec = data.get("sec", None)
        if sec is not None:
            print("OK sec=", sec)

        sys.exit(0)
    finally:
        try:
            ws.close()
        except Exception:
            pass

if __name__ == "__main__":
    main()

