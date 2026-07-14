#!/bin/bash
# Generate one image with Nano Banana Pro (gemini-3-pro-image-preview)
# usage: gen.sh <outname> <aspect_ratio> <prompt>
set -u
OUT="$1"; AR="$2"; PROMPT="$3"
DIR="/Users/kikkupico/Projects/paxos-illustrated/i1/images"
SCRATCH="/private/tmp/claude-501/-Users-kikkupico-Projects-paxos-illustrated-i1/bc454237-da32-4780-8170-9cdfa2229a55/scratchpad"
mkdir -p "$SCRATCH"

STYLE="Vintage 1970s comic book illustration style: bold black ink outlines, visible halftone dot shading, slightly aged newsprint paper texture, flat vibrant Mediterranean palette (aegean blue, terracotta red, olive green, marble white, sand, gold accents). Setting: the ancient Greek island of Paxos, classical era. Characters wear chitons, himations, sandals; laurel wreaths. Dramatic comic-panel composition, clean and readable. No modern objects unless specified."

REQ="$SCRATCH/req_$OUT.json"
jq -n --arg p "$STYLE $PROMPT" --arg ar "$AR" '{
  contents: [{parts: [{text: $p}]}],
  generationConfig: {
    responseModalities: ["TEXT","IMAGE"],
    imageConfig: {aspectRatio: $ar}
  }
}' > "$REQ"

for attempt in 1 2 3; do
  RESP="$SCRATCH/resp_$OUT.json"
  curl -sS -X POST \
    "https://generativelanguage.googleapis.com/v1beta/models/gemini-3-pro-image-preview:generateContent" \
    -H "x-goog-api-key: $GEMINI_API_KEY" \
    -H "Content-Type: application/json" \
    -d @"$REQ" -o "$RESP" --max-time 300
  B64=$(jq -r '[.candidates[0].content.parts[]? | select(.inlineData) | .inlineData.data][0] // empty' "$RESP" 2>/dev/null)
  if [ -n "$B64" ]; then
    echo "$B64" | base64 -d > "$DIR/$OUT.png"
    echo "OK $OUT ($(du -h "$DIR/$OUT.png" | cut -f1))"
    exit 0
  fi
  echo "attempt $attempt failed for $OUT: $(jq -c '.error // {finish: .candidates[0].finishReason} // .' "$RESP" 2>/dev/null | head -c 300)"
  sleep 15
done
echo "FAILED $OUT"
exit 1
