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
| 5 — Volume IV | ✅ Done | `f93dac6` |
| 6 — Volume VI | ✅ Done | `bb9add1` |
| 7 — Volume VII | ✅ Done, not committed | — |
| 8–9 — Volumes VIII–IX | Not started | — |

**How batch 7 finished.** The Gemini API project was still hitting its monthly spending cap (same 429 as
batch 5) when this batch started, so the whole batch was made human-in-the-loop via the Gemini web app, one
fresh chat per attempt, exactly as batch 6 established. Acceptance rate was lower than batch 6's tally-mark
fix suggested it would be — five of the eight panels needed at least one retry, for two distinct new failure
patterns beyond the known writing/panel-border ones:

- **Unwanted extra characters at odd scale.** `v7-02` attempt 1 added legible signposts and a roster covered
  in sentence-like glyphs (the base prompt's own "crossing a name off a roster" line invited it, same failure
  class as always). Attempt 2's corrective fixed the writing but the model then split the image into a
  two-panel comic strip with a hard gutter — an inset-panel failure appearing where it hadn't been provoked
  before (no "beat" language in the prompt this time). Attempt 3 fixed the gutter but produced disproportionate
  floating figures: the model had inserted the volume's two named inquisitors into a scene whose text never
  called for them, seemingly triggered by their presence in the reference image, and getting their scale right
  in a night street scene broke the composition. Attempt 4 (past the normal 3-try cap, continued with explicit
  sign-off since it was a proportions fix, not a new creative attempt) simply told the model the inquisitors
  were absent from this scene — problem gone. **Lesson: if a reference image's characters aren't named in the
  scene text, consider excluding them explicitly up front** rather than waiting for a proportions failure.
- **"Two things side by side" reads as an instruction to split the panel.** Both `v7-02`'s day/night indoor-
  outdoor beat and `v7-08`'s "race between two libraries side by side" pushed the model toward a literal
  split-screen composition even when the corrective explicitly said "one single continuous scene, no dividing
  line" — `v7-08` attempt 1 avoided a hard gutter but still drew two disconnected library rooms and dropped the
  mirrored second scribe the caption's comparison depends on. Attempt 2, which explicitly asked for "one single
  continuous OPEN scene ... both libraries visible together in one unbroken space" and named the mirrored
  scribe's five actions twice (once per side), got a genuinely unified scene, though even then the right-hand
  side ended up as keepers-checking-scrolls rather than a literal action-for-action mirror — accepted anyway
  since the caption's point (guarded is only slightly slower) still reads clearly.
- Preemptive correctives carried over from batch 6 (blank tablets/scrolls, single tally mark or plain wax-seal
  impression instead of numbers or letters) worked on the first attempt every time they were used — `v7-01`,
  `v7-03`, `v7-04`, `v7-05`, `v7-06`, `v7-07` all cost only 1 attempt. The two panels above were the only ones
  needing rework, and both were compositional (extra characters, false split), not the writing failure the
  correctives target.

All 8 Volume VII panels are accepted, compressed and placed in `volume-7.html`; the status banner is removed
and the Volume VII card on `index.html` matches Volumes I–VI's "★ Available" pattern. §7 checks pass (all
`v7-*` ids gone from the pending grep, no volume-7 images missing) and the full page was checked panel-by-panel
in a browser. Not yet committed.

**How batch 5 finished.** The Gemini API project hit its monthly spending cap (HTTP 429, "exceeded its
monthly spending cap") with 6 of 8 panels placed. `v4-01`…`v4-04`, `v4-06`, `v4-07` were made earlier with
`tools/gen_panel.py`; the last two (`v4-05`, `v4-08`), and `v6-01`, were instead generated by driving the
Gemini consumer web app through browser automation. **This was later found to likely violate Gemini's
consumer Terms of Service** (automated/programmatic use of the free web app, as opposed to the paid API,
which is built for this) and was stopped. Do not repeat it — see the note at the end of this section. All 8
Volume IV panels are accepted, compressed and placed in `volume-4.html`, the status banner is removed, and
the Volume IV card on `index.html` matches Volume III/V's "★ Available" pattern. Still to do: run §7 and
the full browser check one more time, then commit.

- `v4-05` vol4_growing_hourglass — **all 3 attempts used.** Attempt 1: a disembodied hand turned the
  hourglass. Attempt 2: a modern fountain pen and gridded map on the desk. Attempt 3 (reference
  `vol4_navigators.png`, corrective sentence: *"The seated delegate himself turns over the tallest
  hourglass, and the bare wooden desk holds nothing but the hourglasses: no pens, maps or books."*) fixed
  both earlier problems but came back 16:9 instead of the requested 4:3 (the web app ignores aspect-ratio
  instructions in the prompt) and was centre-cropped to 4:3. The crop left a small carved-inscription-style
  frieze (illegible glyphs, but clearly meant as lettering) on the background wall — a flagged failure mode.
  Accepted anyway per explicit user sign-off rather than spending a 4th attempt.
- `v4-08` vol4_passable_season — **2 of 3 attempts used.** Attempt 1 contained an inset sub-panel. Attempt 2
  (reference `vol4_two_seas.png`, corrective sentence: *"Draw it as one single continuous scene with no
  inset panels, and the navigator himself stands beside the sundial."*) fixed the inset-panel problem but
  introduced a disembodied hand dropping the token into the urn. A same-thread follow-up ("one of the
  standing council members himself reaches forward with his own visible arm and sleeve...") fixed it; that
  regenerated image (still counted as attempt 2, since it's a same-thread correction of the same attempt)
  was accepted. Came back natively at ~16:9, no cropping needed.

**How batch 6 finished.** `v6-01` vol6_granary was first tried via the now-retired browser-automation method
(attempt 1 with `island_small.webp` as reference: a triptych of 3 framed sub-panels; same-thread corrective
follow-ups fixed the borders on two of three sides but never all three) — that failure led to the finding
above the automation was stopped for: **a fresh chat for every attempt**, not a same-thread follow-up, since
the web app seems to compound a flawed prior image as visual context for "regenerate" requests, which is
likely why the panel-border problem kept resurfacing across follow-ups. The rest of the batch (`v6-01`
redone, then `v6-02`…`v6-08`) was made with the human-in-the-loop process below: the agent gave the person
running it one prompt at a time (base prompt from `IMAGE_PROMPTS.md`, plus a reference-image note, plus
aspect ratio, plus — from `v6-03` on — a standing corrective sentence added pre-emptively: *"Each tablet's
face carries only a single plain tally mark or a lone simple pictogram — never rows of several different
symbols side by side that resemble written sentences."*), the person ran it by hand in a fresh Gemini chat
each time with `images/vol6_granary.png` attached as the reference, and pasted the result back.

- `v6-01` vol6_granary — accepted on the first fresh-chat attempt (no corrective needed): a single continuous
  scene, no panel borders, fixed the earlier triptych problem outright.
- `v6-02` vol6_viewstamp — accepted on attempt 1.
- `v6-03` vol6_buffer — **2 attempts.** Attempt 1 rendered the tablets with dense rows of varied glyphs that
  read as actual script/sentences (worse than a single pictogram) — a "legible writing" failure distinct
  from the panel-border one. Attempt 2, with the standing tally-mark/pictogram corrective added, fixed it;
  that sentence was then folded into every subsequent prompt in this batch pre-emptively.
- `v6-04` through `v6-08` — each accepted on attempt 1 with the standing corrective already included.
  Two scene descriptions were flagged in advance as risky wording and turned out fine anyway: `v6-05`'s
  "four-beat sequence arranged left to right" (worried it would invite another triptych; the model instead
  drew one continuous scene using the same steward figure repeated along it) and `v6-06`'s "PREPARE tablets"
  (worried the literal word would get stamped onto a tablet; it didn't — the model used a plain hand-print
  icon instead).

All 8 Volume VI panels are accepted, compressed and placed in `volume-6.html`, the status banner is removed,
and the Volume VI card on `index.html` matches Volumes I–V's "★ Available" pattern. §7 and the full browser
check both pass.

**What has worked (batches 2–5).** Since batch 2 most panels were made with `tools/gen_panel.py`
(Gemini `gemini-3-pro-image`, 2K) rather than a built-in tool:

- It parses the prompt and aspect ratio straight from `IMAGE_PROMPTS.md`, attaches the reference image(s),
  and adds a short note that the reference is for style and characters only. Without that note the model
  re-draws the reference instead of the new scene.
- **Wide (16:9) panels must not use a 16:9 reference** — the model still copies it. Use an accepted 4:3
  panel from the same volume (ideally one showing the recurring cast) as the reference instead.
- The API only returns JPEG; the script converts to PNG.
- Generating a volume's remaining panels in parallel is fine (one process per panel).
- Review at 800px, then zoom into tablets, scrolls, maps and signs at full resolution for tiny lettering.

**Do not drive the Gemini consumer web app with browser automation** as a fallback when the API is capped —
this was tried for `v4-05`, `v4-08` and `v6-01` and likely violates Gemini's consumer Terms of Service
(automated/programmatic use of the free web app). It was stopped mid-batch-6.

**Fallback while the API is capped: human-in-the-loop via the web app.** The agent hands the person running
it the exact prompt text for one image, built the same way `gen_panel.py` builds it — the entry's prompt
from `IMAGE_PROMPTS.md` as one paragraph, plus a sentence naming the attached reference(s) as a style/
character reference only (not to be redrawn), plus the required aspect ratio. **Always tell the person to
use a fresh chat for every single attempt**, never a same-thread follow-up — see the batch-6 finding above.
The person pastes that prompt into a new Gemini session by hand, attaches the reference image(s) themselves,
and pastes the resulting image back into the conversation. The agent then reviews it exactly as it would an
API-generated image (same checklist, same 3-attempt cap per image, same corrective-sentence rule), saves the
accepted one to `images/<stem>.png`, and runs `tools/compress.py <stem>`. This is how all of batch 6 (after
`v6-01`'s false start) was made, with a 100% fresh-chat-attempt-1 acceptance rate once the standing tally-
mark/pictogram corrective (see above) was folded into the prompt by default. Note the web app sometimes
ignores the requested aspect ratio for a 4:3 target and returns its ~16:9 default (2752×1536) — this
happened for the very first (pre-fix) `v4-05`/`v4-08` images but not for any of batch 6's 4:3 panels, which
all came back at the correct native ratio; if it happens, centre-crop the result to spec.

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
