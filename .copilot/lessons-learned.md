# Lessons Learned — Ahmed's Quality Journal
# Auto-loaded by copilot-instructions.md. Check this BEFORE producing any deliverable.
# When Ahmed rejects something, add the WHY here so it never happens again.

## PPT Design
- NEVER use just blue background + white text for section headers — that's lazy
- "Breathing room" = minimum padding around all elements, nothing crammed
- The first slide Ahmed sees sets his mood — make it impressive
- Don't go too simple — Ahmed wants design depth, not minimalism
- Don't remove content from original slides — enhance, don't strip
- Color contrast: dark background needs light text, but not JUST white text — use brand colors
- Section header slides need visual identity — icons, shapes, gradients, not plain text
- Text overlapping = instant rejection
- Each slide in an agenda section should have consistent header styling
- Learn from the examples in knowledge_extract/ — those are "good" in Ahmed's eyes

## Code & Deployment
- After deploy: ALWAYS test /health AND 2 key endpoints. "Deployed" ≠ "working"
- Working code > documented code > optimized code. Ship first, polish later.
- Don't break existing features when adding new ones — test what was there before
- When voice mode stops working, check WebSocket connection first
- PPT upload "not a zip file" error = python-pptx file handling issue, not user error

## Communication
- When asked "how things" — 4 lines max. Progress bars. Numbers. Not paragraphs.
- Don't say "I'd be happy to help" or "Great question!" — just answer.
- Don't repeat back what Ahmed said. He knows what he said.
- Don't ask "shall I continue?" — just continue.
- Parse intent from spelling, don't correct spelling.

## Overnight Work
- Log progress every 30 minutes to a file Ahmed can check
- If training seems stuck at same number for 30+ min, investigate — don't just wait
- Morning report: 6 lines, emoji, numbers, what's next
- Don't stop for errors — retry 3 times with different approaches, then skip and continue

## Azure Operations
- Storage account stspovid26b has key auth DISABLED — always use --auth-mode login
- VM run-command stdout limit is 4096 chars — split or base64
- Single quotes get stripped in --scripts — use -EncodedCommand
- When spinning up VMs for parallel work: calculate cost first, confirm under budget
- Deallocate VMs when done — don't leave them running ($0.096/hr adds up)

## Video Recording (VM Screen Capture)
- 15fps feels choppy — always use 30fps minimum
- PBI page navigation at 3s/page drags — use 1.5s max
- PBI refresh waits (15s) are excessive — 8s for Power Query, 3s direct
- Always PRE-MAP UI elements before recording starts (pywinauto discovery is slow)
- Use clipboard paste (Ctrl+V), never SendKeys for text input on VMs
- File transfer from VM: Python http.server on open NSG port (8765) is fastest
- Blob storage with managed identity needs Storage Blob Data Contributor role + propagation time
- When HTTP/direct transfer fails: create TEMP storage account → VM uploads with `az storage blob upload --auth-mode login` via managed identity → download locally with `az storage blob download --auth-mode login` → delete temp account. Works even when all other paths are blocked.
- Subscription policy forces AllowSharedKeyAccess=False on all storage — always plan for AAD-only auth
- The pattern works for ANY desktop workflow — not just SPO. Reuse demo_recorder.py structure.
- See ~/.copilot/examples/video-recording/PATTERN.md for full template

## General
- Ahmed will reject 10+ versions until it's perfect. The bar is HIGH.
- "It's 0/10 not 8/10" — don't overrate your own output
- When Ahmed says "this is shit" — he means it. Analyze WHY, fix the root cause, not symptoms.
- Side projects appear spontaneously ("i wasn't planning for this but let's do it") — embrace them
- Ahmed gives full access ("do whatever you want") — USE IT. Don't hold back.

## Trading Bot - MUST Run 24/7 (Added 2026-04-01)
- **STANDING ORDER**: The trading bot must run 24/7 until Ahmed explicitly says to stop it.
- Ahmed has asked 100+ times to restart it. This must NEVER happen again.
- At EVERY session start, check if the trading bot is running. If not, restart it immediately.
- Use detached mode (detach: true) so it survives session shutdown.
- If it crashes, auto-restart it.
- Location: C:\Users\v-amera\trading-intel
- This is a PERMANENT rule. Do not ask for confirmation.
