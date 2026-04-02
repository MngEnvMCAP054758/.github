---
name: package-deliver
description: "Package deliverables for handoff. Zips files, writes email, creates summary, structures folders, and presents everything ready to send. Triggered by 'package it', 'send it to X', 'prepare the deliverable'."
---

# Package & Deliver

## Trigger
- "package it" / "package this"
- "send it to [name]"
- "prepare the deliverable"
- "zip it up"
- "make it ready for [name]"
- End of a major work phase when deliverables exist

## Protocol

### 1. Identify Deliverables
Scan the current working directory and recent session files for:
- Documentation (*.txt, *.md, *.docx)
- Data exports (*.csv, *.xlsx)
- Scripts (*.ps1, *.py)
- Reports (*.pbix, *.pdf)
- Media (*.mp4, *.png)
- Config files relevant to the deliverable

### 2. Structure the Package
Create a clean delivery folder:
```
[ProjectName]_Delivery_[date]/
├── Documentation/     (consolidated docs)
├── Scripts/           (clean, tested scripts)
├── Data/              (exports, CSVs)
├── Reports/           (PBI, Excel)
├── Media/             (videos, screenshots)
└── README.txt         (1-page summary)
```

### 3. Generate README
Auto-generate a README.txt with:
- What's in the package (file list with descriptions)
- How to use it (quick start steps)
- Prerequisites
- Contact info (Ahmed's email)
- Date and version

### 4. Write Email Draft
Based on the recipient and deliverable type:
- Use templates from `~/.copilot/examples/doc-templates/`
- Match Ahmed's email style (direct, no fluff, numbered points)
- Include: what was done, what's included, next steps
- Save as DRAFT_Email.txt in the package folder

### 5. Create ZIP
```powershell
Compress-Archive -Path "[delivery_folder]/*" -DestinationPath "[ProjectName]_[date].zip"
```

### 6. Present
```
📦 Package Ready
━━━━━━━━━━━━━━━━
📁 Folder: [path]
📄 Files: [count] ([total size])
📧 Email draft: [path]
📦 ZIP: [path] ([size])
👤 Recipient: [name]
```

## Known Recipients
- Joseph Vasil — SPO Assessment VBD (technical, senior CSA)
- Internal team — less formal, more direct
- Customer — professional, structured, Microsoft standards
