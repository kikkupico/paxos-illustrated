#!/usr/bin/env python3
"""Generate one panel from IMAGE_PROMPTS.md with the Gemini API.

usage: GEMINI_API_KEY=... python3 tools/gen_panel.py <panel-id> <attempt> [corrective sentence]
  panel-id    e.g. v4-05
  attempt     label for the output file, e.g. 3
  corrective  optional sentence appended to the prompt (attempts 2-3 only)
env:
  REFS        comma-separated reference files in images/ (default: island.png)

Writes out/<file-stem>_a<attempt>.png (next to the repo root) for review; copy the accepted one to
images/<file-stem>.png. Exits 2 on quota / spend-cap errors. Needs: pip install google-genai pillow
"""
import base64, io, os, re, sys
from pathlib import Path
from PIL import Image
from google import genai

REPO = Path(__file__).resolve().parent.parent
OUT = REPO / "out"
MODEL = "gemini-3-pro-image"
REFS = [REPO / "images" / f for f in os.environ.get("REFS", "island.png").split(",")]
# Without this note the model tends to edit the reference instead of drawing a new scene,
# especially when the reference has the same aspect ratio as the panel being generated.
REF_NOTE = ("The attached image is a reference for drawing style and for how recurring characters look ONLY. "
            "Do not copy or edit its composition, landscape, viewpoint or scene: draw an entirely new picture of the scene described above.")

pid, attempt = sys.argv[1], sys.argv[2]
extra = sys.argv[3] if len(sys.argv) > 3 else ""

md = (REPO / "IMAGE_PROMPTS.md").read_text()
m = re.search(r"#### `" + re.escape(pid) + r"` — (\S+)\n(.*?)```text\n(.*?)\n```", md, re.S)
stem, table, prompt = m.group(1), m.group(2), m.group(3).strip()
ratio = re.search(r"\| Aspect ratio \| \*\*(\d+:\d+)\*\*", table).group(1)
if extra:
    prompt = prompt + " " + extra

def png_part(p):
    im = Image.open(p).convert("RGB")
    im.thumbnail((1024, 1024))
    buf = io.BytesIO()
    im.save(buf, "PNG")
    return {"type": "image", "data": base64.b64encode(buf.getvalue()).decode(), "mime_type": "image/png"}

client = genai.Client()
try:
    it = client.interactions.create(
        model=MODEL,
        input=[{"type": "text", "text": prompt}] + [png_part(r) for r in REFS] + [{"type": "text", "text": REF_NOTE}],
        # The API only accepts image/jpeg here; the result is converted to PNG below.
        response_format={"type": "image", "mime_type": "image/jpeg", "aspect_ratio": ratio, "image_size": "2K"},
    )
except Exception as e:
    msg = str(e)
    print("ERROR:", msg[:2000])
    sys.exit(2 if ("RESOURCE_EXHAUSTED" in msg or "429" in msg) else 1)

if not it.output_image:
    print("NO IMAGE; text:", it.output_text)
    sys.exit(1)
OUT.mkdir(exist_ok=True)
dest = OUT / f"{stem}_a{attempt}.png"
Image.open(io.BytesIO(base64.b64decode(it.output_image.data))).save(dest, "PNG")
w, h = Image.open(dest).size
print(f"{dest}  {w}x{h}  ratio={ratio}  model={MODEL}")
