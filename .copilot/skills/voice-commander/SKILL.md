---
name: voice-commander
description: "Launch and manage Voice Commander — full voice control over Copilot CLI. Start with 'voice mode', manage with voice commands."
---

# Voice Commander

## Trigger
- "voice mode" / "start voice" / "turn on voice"
- "voice control"

## Launch
```powershell
cd C:\Users\v-amera\voice-commander
python voice_commander.py --always-on --region swedencentral --key $env:SPEECH_KEY
```

## Voice Commands Once Running
| Say This | Does This |
|----------|-----------|
| (any text) | Sends to active CLI session |
| "where are you" / "status" | Reports all session states + last output |
| "also do X" / "new session" | Spawns parallel CLI session |
| "switch to session" | Cycles between active sessions |
| "read that back" | Re-reads last output via TTS |
| "stop" / "cancel" | Sends Ctrl+C to active session |
| "quiet mode" | Disables TTS (voice input only) |
| "loud mode" | Re-enables TTS |
| "exit voice" | Shuts down Voice Commander |

## Prerequisites
- Azure Speech resource (key + region)
- `pip install azure-cognitiveservices-speech pyaudio`
- Microphone + speakers

## Modes
- `--always-on`: Always listening, no wake word needed
- Default: Say "Hey Copilot" to activate (30s timeout)
- `--quiet`: Voice input only, no spoken responses
