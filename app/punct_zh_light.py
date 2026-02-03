# -*- coding: utf-8 -*-
import re
from pathlib import Path

OUT = Path(r"C:\whispercpp\tmp\out.txt")

def add_punct_zh_light(text: str) -> str:
    t = text.strip()

    if not t:
        return t

    t = re.sub(r"\s+", " ", t)

    t = re.sub(r"([。！？!?])([^\s])", r"\1 \2", t)

    t = re.sub(r"(所以|因此|但是|可是|不過|然後|接著|另外|同時|其實|因為|如果|雖然|而且|例如|比方說)(?=[^\s，。！？!?])", r"\1，", t)

    t = re.sub(r"(我問你|你覺得|我覺得|你看|你懂嗎|對不對|好不好|可以嗎)(?=[^\s，。！？!?])", r"\1，", t)

    t = re.sub(r"[，,]{2,}", "，", t)
    t = re.sub(r"[。]{2,}", "。", t)
    t = re.sub(r"\s*，\s*", "，", t)
    t = re.sub(r"\s*。\s*", "。", t)

    if t[-1] not in "。！？!?":
        t += "。"

    return t

def main():
    if not OUT.exists():
        raise SystemExit(2)

    raw = OUT.read_text(encoding="utf-8", errors="ignore")
    cooked = add_punct_zh_light(raw)
    OUT.write_text(cooked, encoding="utf-8")

if __name__ == "__main__":
    main()
