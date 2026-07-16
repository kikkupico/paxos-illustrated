#!/usr/bin/env python3
"""Compress illustration PNGs to the web-ready <name>_small.webp files.

usage: compress.py [name ...]
  name  basename of a PNG in images/ (with or without .png);
        no arguments = process every PNG in images/.

Resizes to max 800px wide with Lanczos3 — the sharpness-preserving kernel,
right for these bold-ink-outline comic panels — and encodes WebP at
quality 82, method 6 (slowest/best), matching the existing files.
"""
import sys
from pathlib import Path

from PIL import Image

IMAGES = Path(__file__).resolve().parent.parent / "images"
MAX_WIDTH = 800
QUALITY = 82

def compress(png: Path) -> None:
    im = Image.open(png)
    w, h = im.size
    if w > MAX_WIDTH:
        im = im.resize((MAX_WIDTH, round(h * MAX_WIDTH / w)), Image.LANCZOS)
    out = png.with_name(png.stem + "_small.webp")
    im.save(out, "WEBP", quality=QUALITY, method=6)
    print(f"{out.name}  {im.size[0]}x{im.size[1]}  {out.stat().st_size // 1024} KB")

def main() -> None:
    names = sys.argv[1:]
    pngs = ([IMAGES / (n.removesuffix(".png") + ".png") for n in names]
            if names else sorted(IMAGES.glob("*.png")))
    missing = [p for p in pngs if not p.exists()]
    if missing:
        sys.exit("not found: " + ", ".join(str(p) for p in missing))
    for p in pngs:
        compress(p)

if __name__ == "__main__":
    main()
