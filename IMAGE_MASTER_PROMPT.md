# Master Prompt — Generating the Artwork in Batches

Hand the prompt below to an image-generation agent working in this repository. It runs **nine batches**:
batch 1 redraws the nine covers, and batches 2–9 illustrate one chronicle volume each. The detailed,
per-image prompts live in `COVER_PROMPTS.md` (covers) and `IMAGE_PROMPTS.md` (panels); this file only
sets the order, the rules and the definition of done.

| Batch | Scope | Images | Prompts |
|---|---|---|---|
| 1 | Covers, Volumes I–IX | 9 | `COVER_PROMPTS.md` |
| 2 | Volume I panels `v1-01` … `v1-08` | 8 | `IMAGE_PROMPTS.md` §6, Volume I |
| 3 | Volume II panels `v2-01` … `v2-08` | 8 | `IMAGE_PROMPTS.md` §6, Volume II |
| 4 | Volume III panels `v3-01` … `v3-07` | 7 | `IMAGE_PROMPTS.md` §6, Volume III |
| 5 | Volume IV panels `v4-01` … `v4-08` | 8 | `IMAGE_PROMPTS.md` §6, Volume IV |
| 6 | Volume VI panels `v6-01` … `v6-08` | 8 | `IMAGE_PROMPTS.md` §6, Volume VI |
| 7 | Volume VII panels `v7-01` … `v7-08` | 8 | `IMAGE_PROMPTS.md` §6, Volume VII |
| 8 | Volume VIII panels `v8-01` … `v8-08` | 8 | `IMAGE_PROMPTS.md` §6, Volume VIII |
| 9 | Volume IX panels `v9-01` … `v9-09` | 9 | `IMAGE_PROMPTS.md` §6, Volume IX |
| | **Total** | **73** | |

Volume V's panels are already done and are not part of any batch; only its cover is touched (batch 1).

---

## Progress (last updated 2026-09-13)

| Batch | Status | Commit |
|---|---|---|
| 1 — Covers | ✅ Done | `ce9d73e` |
| 2 — Volume I | ✅ Done | `ce9d73e` |
| 3 — Volume II | ✅ Done | `3a4a38d` |
| 4 — Volume III | ✅ Done | `8cba675` |
| 5 — Volume IV | ⏸ **In progress — 6 of 8 placed, not committed** | — |
| 6–9 — Volumes VI–IX | Not started | — |

**Where batch 5 stopped.** The Gemini API project hit its monthly spending cap (HTTP 429, "exceeded its
monthly spending cap"). Raise it at https://ai.studio/spend or wait for the monthly reset, then resume.

- Accepted, compressed and placed in `volume-4.html` (uncommitted): `v4-01` navigators, `v4-02` two_seas,
  `v4-03` rotating_lantern, `v4-04` mooring, `v4-06` split_assembly, `v4-07` drummers.
- Still pending (placeholders remain; banner and index card not yet updated):
  - `v4-05` vol4_growing_hourglass — **2 of 3 attempts used.** Attempt 1: a disembodied hand turned the
    hourglass. Attempt 2: a modern fountain pen and gridded map on the desk. Last attempt, with reference
    `vol4_navigators.png`, corrective sentence: *"The seated delegate himself turns over the tallest
    hourglass, and the bare wooden desk holds nothing but the hourglasses: no pens, maps or books."*
  - `v4-08` vol4_passable_season — **1 of 3 attempts used.** Attempt 1 contained an inset sub-panel. Next,
    with reference `vol4_two_seas.png` (4:3 — see below), corrective sentence: *"Draw it as one single
    continuous scene with no inset panels, and the navigator himself stands beside the sundial."*
- Once both are placed: remove the banner, update the Volume IV card, run §7 and the browser check, commit.

**Resume commands** (from the repo root; needs `pip install google-genai pillow` and `GEMINI_API_KEY`):

```bash
REFS=vol4_navigators.png python3 tools/gen_panel.py v4-05 3 "The seated delegate himself turns over the tallest hourglass, and the bare wooden desk holds nothing but the hourglasses: no pens, maps or books."
REFS=vol4_two_seas.png  python3 tools/gen_panel.py v4-08 2 "Draw it as one single continuous scene with no inset panels, and the navigator himself stands beside the sundial."
# review out/<stem>_aN.png, then: cp out/<stem>_aN.png images/<stem>.png && python3 tools/compress.py <stem>
```

**What has worked (batches 2–5).** Since batch 2 the panels were made with `tools/gen_panel.py`
(Gemini `gemini-3-pro-image`, 2K) rather than a built-in tool:

- It parses the prompt and aspect ratio straight from `IMAGE_PROMPTS.md`, attaches the reference image(s),
  and adds a short note that the reference is for style and characters only. Without that note the model
  re-draws the reference instead of the new scene.
- **Wide (16:9) panels must not use a 16:9 reference** — the model still copies it. Use an accepted 4:3
  panel from the same volume (ideally one showing the recurring cast) as the reference instead.
- The API only returns JPEG; the script converts to PNG.
- Generating a volume's remaining panels in parallel is fine (one process per panel).
- Review at 800px, then zoom into tablets, scrolls, maps and signs at full resolution for tiny lettering.

**Recurring failure modes to check for.** Prompts that mention writing, numbers or speech tend to produce
it: "stamped with a number", "numbered tag", "carved inscription", "labeled", "lists of names", quoted
speech (`"lit!"`), "snoring" (comic Z's). Also watch for: modern objects (glass hurricane lanterns,
fountain pens, world maps, bound books), sub-panels or inset boxes inside a panel, characters drawn at the
wrong scale, and details that contradict the caption (e.g. someone asleep when the caption says no one is).
A corrective sentence that names the unwanted thing ("no speech balloons") can make it worse — describe
the wanted alternative instead ("disagree only by gesture", "tally marks", "punched holes"). `IMAGE_PROMPTS.md`
v2-08 was reworded (with approval) to drop quoted speech.

---

## The prompt

````text
You are generating the artwork for "Paxos Illustrated", a static site in the current repository that retells
nine distributed-systems papers as allegorical comic chronicles. Work through the nine batches below in
order. First read the "Progress" section of IMAGE_MASTER_PROMPT.md: skip batches marked done and resume
the in-progress batch exactly where it stopped (attempt counts carry over), using tools/gen_panel.py and the
notes there. Read COVER_PROMPTS.md and IMAGE_PROMPTS.md in full before you start; they hold every per-image prompt,
file name, aspect ratio and placement instruction. Follow them exactly — do not rewrite the prompts, apart
from the small regeneration tweaks allowed under "Reviewing an image".

TOOLS
- Generate every image with your built-in image generation tool. For each image: pass the prompt text
  exactly as written in its entry (prompts are self-contained — add no style text of your own), attach the
  reference image(s) named in the batch steps below, and request the aspect ratio in the entry.
- Save each result as a PNG at images/<file-stem>.png, overwriting any existing file of that name. If the
  tool returns a different format or saves somewhere else, convert and move it:
  python3 -c "from PIL import Image; Image.open('<generated-file>').save('images/<file-stem>.png')"
- After an image is accepted, run: python3 tools/compress.py <file-stem>
  (writes images/<file-stem>_small.webp, which is what the pages load).
- If the image generation tool is unavailable, stop and say so.

REVIEWING AN IMAGE (do this for every image before accepting it)
Open the PNG and check it against its entry:
1. It shows the scene described, in the vintage 1970s comic style, and would sit comfortably next to
   Volume V's existing panels (e.g. images/island_small.webp, images/synod_small.webp).
2. No stray lettering. Panels contain no words, numbers, labels, signs or speech balloons at all. Covers
   contain only the lettering their prompt allows, spelled exactly.
3. Aspect ratio matches the entry (panels may be centre-cropped to it if nothing important is lost; covers
   are never cropped). No modern objects. No extra limbs, melted faces or garbled hands on the
   main figures.
4. For panels: it depicts what the caption on the page says.
If it fails, regenerate — at most 3 attempts per image. From the second attempt you may add one short
corrective sentence to the end of the prompt (e.g. "There is no writing on the scroll."). If it still fails
after 3 attempts, keep the best attempt as images/<file-stem>.png, do NOT place it in the page, and list it
in your report as needing attention.

BATCH 1 — COVERS (COVER_PROMPTS.md)
1. Volume V first: edit the existing images/cover.png using the "Prompt (edit)" in COVER_PROMPTS.md §3,
   attaching images/cover.png as the reference and writing the result back to file-stem "cover", 2:3.
   Only the masthead may change: a laurel wreath crown with a "P" inside it, the Roman numeral "V" below it,
   the "PAXOS COMICS" label unchanged below that. Compare it side by side with `git show HEAD:images/cover.png`;
   if anything outside the masthead changed noticeably, retry, then fall back to the full prompt in §3.
2. STOP after Volume V's cover and report back with its path. Every other image copies this masthead, so
   wait for approval before continuing, unless you were told up front to run unattended.
3. Then Volumes I–IV and VI–IX: file-stems cover_volume_1 … cover_volume_9 (no 5), 2:3, each with the
   new images/cover.png attached as the reference for the DESIGN only (frame, masthead, title and byline
   lettering). The picture must come from the prompt. Reject any cover that borrows the reference's
   picture (hilltop temple, sunny bay, striped sails, walkers on a winding path).
4. Check the nine covers side by side, two ways:
   - Design identical: same frame, masthead box (size, fill, wreath-and-P, numeral position, PAXOS COMICS
     label), same title and byline lettering; numerals I–IX correct.
   - Pictures varied: each matches its row in the "Variety across the set" table in COVER_PROMPTS.md, and no
     two covers share a viewpoint, time of day, weather, landscape, palette or stock element (coastline,
     sunset, ships, temple on a hill). Regenerate any outlier.
5. Compress all nine. No HTML changes are needed for covers.

BATCHES 2–9 — ONE VOLUME EACH (IMAGE_PROMPTS.md §6)
For the volume in this batch:
1. Read that volume's "Casting and setting" block in IMAGE_PROMPTS.md §5.
2. Generate the volume's first panel (vNN-01) with images/island_small.webp attached as a style reference.
   Review it carefully — it fixes how this volume's recurring characters look.
3. Generate the remaining panels of the volume, each with the accepted first panel attached as the
   reference (and also the earlier panel a character first appears in, if that is not the first panel), so
   the cast looks the same throughout the volume.
4. Compress every accepted panel.
5. Place each accepted panel in volume-N.html exactly as IMAGE_PROMPTS.md §2 describes: replace the
   "IMAGE PLACEHOLDER" comment and the whole <div class="img-placeholder">…</div> with
   <img src="images/<file-stem>_small.webp" alt="…">, using the placeholder's description as the alt text.
   Do not touch the <figure>, its classes, or the <figcaption>. Edit the HTML directly — there is no build step.
6. When every panel of the volume is placed (and only then):
   a. In volume-N.html, delete the whole <div class="status-banner">…</div> block
      ("The Chronicle Is Complete — Illustrations Pending").
   b. In index.html, on that volume's card, make it match the Volume V card:
      <span class="vol-badge-recension">Art Pending</span>
        → <span class="vol-badge-recension" style="color:var(--terra); font-weight:700">★ Available</span>
      <span class="action-label">Read the Chronicle</span>
        → <span class="action-label active">📖 Read Full Illustrated Comic</span>
      and give that card's <span class="action-arrow"> the attribute style="color:var(--terra)".
7. Run the checks in IMAGE_PROMPTS.md §7. The volume's IDs must be gone from the "pending" grep, and the
   missing-file check must print nothing.
8. Open volume-N.html in a browser (python3 -m http.server from the repo root; file:// may be blocked) and
   scroll through it: every panel shows, nothing is stretched or cropped oddly, captions match images.

RULES
- Do not modify volume-5.html, protocols.html, the chronicle text, captions, SVG diagrams, or any file not
  named above. Do not change prompts beyond the corrective sentence allowed above.
- Never delete an existing image you did not generate in this run. Old covers are in git.
- Do not commit or push unless the person running you asks you to.

REPORT (after each batch)
- Batch number and scope; for each image: file, attempts used, accepted / needs attention (and why).
- For batches 2–9: whether the banner and index card were updated, and the output of the §7 checks.
- Anything in a prompt that seemed wrong or impossible to draw.
Then continue to the next batch (or stop after batch 1, as instructed above).
````
