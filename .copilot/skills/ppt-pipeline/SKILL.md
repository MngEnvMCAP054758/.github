---
name: ppt-pipeline
description: "End-to-end PPT analysis and enhancement pipeline. Upload, evaluate, enhance, render, compare, iterate until quality threshold is met."
---

# PPT Quality Pipeline

## Trigger
"fix this ppt", "improve slides", "enhance the presentation", or any PPT quality task.

## Pipeline Steps

### 1. Analysis
- Parse PPT structure: slide count, layouts, content types
- Identify: text density, image presence, color scheme, font usage
- Flag issues: overlapping text, missing visuals, inconsistent styling

### 2. Story Creation
- Read all slide content
- Build narrative arc: intro → problem → solution → details → next steps
- Each section should have a visual identity

### 3. Design Enhancement
- Apply Microsoft corporate design standards
- Ensure breathing room (padding around all elements)
- Add icons/visuals where slides are text-only
- Section headers: gradient/shape backgrounds, not plain color + text
- Consistent header styling across sections

### 4. Render & Verify
- Render each slide to PNG using python-pptx + Pillow or LibreOffice
- Visually inspect each PNG:
  - No text overlap?
  - Proper spacing?
  - Readable fonts?
  - Visual appeal?
- Use Azure AI Vision API for automated quality check if available

### 5. Compare Before/After
- Generate side-by-side comparison PNGs
- Verify enhancement actually improved the slide (not made it worse)
- If any slide is worse → revert to original and try different approach

### 6. Quality Gate
- Self-review: "Would Ahmed call this shit?"
- Check lessons-learned.md: past PPT rejections
- Check examples in ~/.copilot/examples/ppt-design/
- If ANY slide fails → redesign, don't deliver

### 7. Iterate
- Loop steps 3-6 until ALL slides pass quality gate
- Track iteration count — if > 5 iterations on one slide, try fundamentally different design approach

## Anti-Patterns
- ❌ Delivering slides with text overlap
- ❌ Blue background + white text only headers
- ❌ Removing content from original slides
- ❌ Making slides "too simple" — Ahmed wants depth
- ❌ Using generic stock photos instead of relevant icons
- ❌ Changing header colors to poor contrast combinations
