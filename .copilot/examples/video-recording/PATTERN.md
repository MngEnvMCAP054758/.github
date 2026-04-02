# VM Screen Recording Pattern (Proven — SPO Assessment)

## When to Use
Any time Ahmed needs a live demo video showing software running on an Azure VM.
Works for: PowerShell scripts, Power BI, desktop apps, browser-based tools, any GUI workflow.

## Architecture
```
Local Machine                    Azure VM (public IP)
─────────────                    ────────────────────
az vm run-command ──────────────► demo_recorder.py
                                   ├── FFmpeg (gdigrab) → screen capture
                                   ├── pywinauto → GUI automation
                                   └── Python http.server → file transfer
                                         │
Invoke-WebRequest ◄──────────────────────┘ (port 8765)
→ Downloads\*.mp4
```

## Stack (all on VM)
- **FFmpeg** — `gdigrab` input, `libx264` codec, `ultrafast` preset
- **pywinauto** (backend="uia") — window discovery, button clicks, keyboard input
- **Python http.server** — serve recordings for download on port 8765
- **az vm run-command invoke** — orchestrate everything remotely

## Key Settings (Learned)
- **30fps** minimum (15fps feels choppy — Ahmed rejected it)
- **PBI page navigation**: 1.5s per page (3s was too slow)
- **PBI refresh wait**: 8s with Power Query, 3s direct (was 15s/5s — too slow)
- **Script inter-step delays**: 0.5-1s (was 2-4s — draggy)
- **CRF 23** for good quality/size balance
- **pix_fmt yuv420p** for compatibility

## Demo Recorder Structure
```python
class DemoRecorder:
    def preflight(self):    # Verify FFmpeg, scripts, PBI open
    def premap(self):       # Map UI elements BEFORE recording (buttons, tabs)
    def rec_start(self):    # Start FFmpeg gdigrab
    def rec_stop(self):     # Send 'q' to FFmpeg stdin
    def run_scripts(self):  # Open PowerShell, paste+run each script
    def refresh_pbi(self):  # Click Refresh, handle Power Query Editor
    def browse_pages(self): # Click pre-mapped tab items
    def _paste_run(self):   # Clipboard + Ctrl+V + Enter (reliable input)
    def run(self):          # Full orchestration
```

## Critical Pattern: Pre-Map UI
Always discover UI element positions BEFORE starting the recording.
pywinauto element discovery is slow — doing it during recording causes pauses.
```python
# Phase 1: Pre-map (no recording)
for b in win.descendants(control_type="Button"):
    if b.window_text() == "Refresh" and height < 45:
        self.ui["refresh"] = (center_x, center_y)

# Phase 2: Record (just click pre-mapped coords)
pywinauto.mouse.click(coords=self.ui["refresh"])
```

## Critical Pattern: Clipboard Paste (not SendKeys)
Direct typing via SendKeys is unreliable on remote VMs. Always use clipboard:
```python
def _paste_run(self, win, text):
    clipboard_set(text)       # Win32 API directly
    win.type_keys("^v")       # Ctrl+V
    win.type_keys("{ENTER}")
```

## File Transfer Pattern
1. Start Python HTTP server on VM: `python -m http.server 8765`
2. NSG must allow inbound on port (8765 already open on spo VM)
3. Download locally: `Invoke-WebRequest http://<VM_IP>:8765/<file>`
4. Alternative: blob storage with managed identity (needs Storage Blob Data Contributor role)

## VM Details (SPO Assessment)
- VM: vm-spo-assess, RG: rg-spo-assessment, IP: 20.91.186.25
- User: azadmin
- FFmpeg: C:\sources\ffmpeg.exe
- Scripts: C:\sources\SPOStorageAssessment\Assessment\Scripts
- Recordings: C:\recordings\
- Agent: C:\mastr-video-agent\demo_recorder.py
- NSG open ports: 3389 (RDP), 8765 (agent/HTTP)

## Reuse Template
To create a new demo video for a different tool/workflow:
1. Copy demo_recorder.py structure
2. Replace `run_scripts()` with the new workflow steps
3. Replace `refresh_pbi()` / `browse_pages()` with relevant app automation
4. Keep the same FFmpeg settings (30fps, crf 23, gdigrab)
5. Keep the pre-map pattern for any GUI elements
6. Keep clipboard paste for text input
