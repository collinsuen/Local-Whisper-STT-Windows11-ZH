#SingleInstance Force
#NoEnv
#MaxThreadsPerHotkey 1
SendMode Input
SetWorkingDir, C:\whispercpp\tmp
SetKeyDelay, 30, 30
SetControlDelay, 30
SetTitleMatchMode, 2

START_BAT := "C:\whispercpp\start_record.bat"
STOP_BAT  := "C:\whispercpp\stop_and_transcribe.bat"
OUT_TXT   := "C:\whispercpp\tmp\out.txt"
LOG_TXT   := "C:\whispercpp\tmp\client.log"

global g_state := 0
global LAST_TICK := 0
global LAST_TEXT := ""

TrimText(s) {
    return RegExReplace(s, "^\s+|\s+$")
}

WaitForFile(path, timeout_ms) {
    t0 := A_TickCount
    while (!FileExist(path) && (A_TickCount - t0 < timeout_ms)) {
        Sleep, 50
    }
    return FileExist(path)
}

ReadFileStable(path, retries) {
    Loop, %retries% {
        FileRead, t, %path%
        t := TrimText(t)
        if (t != "")
            return t
        Sleep, 80
    }
    return ""
}

ReadLogTail(path, maxChars) {
    if (!FileExist(path))
        return "(client.log not found)"
    FileRead, t, %path%
    if (StrLen(t) <= maxChars)
        return t
    return SubStr(t, StrLen(t) - maxChars + 1)
}

PasteOnce(text) {
    ClipSaved := ClipboardAll
    Clipboard := ""
    Sleep, 40
    Clipboard := text
    ClipWait, 2
    if (ErrorLevel) {
        Clipboard := ClipSaved
        return 0
    }

    Sleep, 80
    SendInput, ^v
    Sleep, 80

    Clipboard := ClipSaved
    return 1
}

^!Space::
    if (A_TickCount - LAST_TICK < 700)
        return
    LAST_TICK := A_TickCount

    if (g_state = 0)
    {
        FileDelete, %OUT_TXT%
        FileDelete, %LOG_TXT%
        Run, %ComSpec% /c ""%START_BAT%"", , Hide
        g_state := 1
        SoundBeep, 1200, 120
        return
    }

    g_state := 0
    SoundBeep, 800, 120

    RunWait, %ComSpec% /c ""%STOP_BAT%"", , Hide
    rc := ErrorLevel

    if (rc != 0)
    {
        logTail := ReadLogTail(LOG_TXT, 1500)
        MsgBox, 16, CLIENT FAIL, ExitCode=%rc%`n`n%logTail%
        return
    }

    if (!WaitForFile(OUT_TXT, 8000))
    {
        logTail := ReadLogTail(LOG_TXT, 1500)
        MsgBox, 16, FAIL, out.txt missing`n`n%logTail%
        return
    }

    text := ReadFileStable(OUT_TXT, 20)

    if (text = "")
    {
        logTail := ReadLogTail(LOG_TXT, 1500)
        MsgBox, 48, FAIL, out.txt empty`n`n%logTail%
        return
    }

    if (text = LAST_TEXT)
        return
    LAST_TEXT := text

    ok := PasteOnce(text)
    if (!ok) {
        MsgBox, 16, PASTE FAIL, Clipboard not ready or blocked
        return
    }
return
