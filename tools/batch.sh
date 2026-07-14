#!/bin/bash
# Generate all remaining illustrations, 3 at a time.
set -u
G="/Users/kikkupico/Projects/paxos-illustrated/i1/tools/gen.sh"
LOG="/Users/kikkupico/Projects/paxos-illustrated/i1/tools/batch.log"
: > "$LOG"

run() { "$G" "$1" "$2" "$3" >> "$LOG" 2>&1; }

# --- batch 1 ---
run manuscript "4:3" "An archaeologist's tent interior. A weathered archaeologist with round spectacles and a sun hat gently brushes dust off a crumbling ancient parchment manuscript covered in faded Greek letters and strange tables; scattered pottery shards, an oil lamp, digging tools. A caption box aesthetic, sense of wonder and discovery. The manuscript glows faintly golden." &
run island "21:9" "Ultra-wide panoramic establishing shot of the thriving mercantile island of Paxos: a bustling harbor crowded with merchant ships loading amphorae and olives, a lively agora with market stalls and traders haggling, white marble buildings climbing the hillside, and at the very top the columned Parliament Chamber gleaming in the sun. Bustling prosperity, tiny busy figures everywhere." &
run wanderers "16:9" "Interior of the marble parliament Chamber of Paxos, mid-session. Some legislators sit on stone benches holding thick leather ledgers, but many are casually strolling OUT of the great bronze doors chatting, one waves goodbye heading to a banquet with a wine cup, another enters yawning; several benches sit empty. A frustrated speaker gestures at the half-empty room. Humorous tone." &
wait

# --- batch 2 ---
run ledger "4:3" "Dramatic close-up: an elegant woman legislator's hands writing in a massive open leather-bound ledger with a reed pen and a pot of glossy black indelible ink. On the parchment page, clearly legible in neat lettering: '155: The olive tax is 3 drachmas per ton'. Beside the ledger an olive branch and a small stack of drachma coins. Warm lamplight." &
run conflict "16:9" "Two-panel comic strip in one image, thin gutter between panels. LEFT PANEL: a group of legislators in a marble chamber proudly passing a decree, a stone tablet reading '37: Painting on temple walls is forbidden', then leaving through a door toward a banquet table. RIGHT PANEL: a completely different group of legislators entering the now-empty chamber moments later, obliviously cheering their own contradictory tablet reading '37: Freedom of artistic expression!'. Comic irony, a small shocked owl watches from a column." &
run equipment "4:3" "Museum-exhibit style comic panel: the equipment of a Paxon legislator laid out neatly on a marble table like labeled artifacts: a sturdy leather-bound LEDGER of finest parchment, a reed PEN, a pot of INDELIBLE INK, a brass-and-glass HOURGLASS timer, and a flimsy SLIP OF PAPER. Each item has a small elegant caption label. Clean composition, soft museum lighting." &
wait

# --- batch 3 ---
run messenger "4:3" "A cheerful Paxon messenger in winged sandals sprinting at full speed through a marble colonnade clutching a sealed scroll, motion lines and dust clouds behind him. In a small inset circle panel in the corner, the same messenger lounges forgetfully on the deck of a merchant ship sailing away over the horizon, the scroll still tucked in his belt, undelivered. Humorous." &
run synod "16:9" "A solemn ceremonial Synod inside a torch-lit ancient temple: priests in white and gold robes gathered around a central brazier to choose a single sacred decree, an ornate empty stone tablet waiting. But comically, several priests are quietly slipping out the side doors mid-ceremony while the high priest isn't looking. Dramatic torchlight, incense smoke." &
run nextballot "16:9" "A determined priest stands at a marble desk in the Chamber, having just written several copies of a scroll labeled with a large number '14'; a squad of messengers in winged sandals fan out from him in all directions across the chamber and out the doors, each carrying an identical scroll, speed lines everywhere. Composition like a hub with radiating spokes. Energetic." &
wait

# --- batch 4 ---
run lastvote "4:3" "An old priest sits on a bench flipping to the BACK pages of his enormous ledger, where scribbled notes are visible; he squints at them, remembering. With his other hand he hands a waiting messenger a small scroll sealed with wax. A faint thought bubble above him shows a tiny scene of himself voting in an earlier ballot. Contemplative but comic." &
run voting "16:9" "Inside the Chamber, a ballot in progress: three priests each solemnly drop a bronze token into their own voting urn while writing a note in the back of their ledgers; messengers dash from each of them back toward a central priest who tallies scrolls at a marble desk, a checklist visible with three check marks. Suspenseful comic energy." &
run success "16:9" "Triumphant celebration in the Chamber: the presiding priest holds up a stone tablet reading 'THE DECREE IS PASSED!', messengers stream out through the doors carrying copies of a scroll to everyone, legislators everywhere joyfully write the same line into their ledgers, wine cups raised, olive wreath confetti. Golden celebratory light." &
wait

# --- batch 5 ---
run president "4:3" "A deeply tanned legislator with a travel bag and a souvenir amphora returns from a six-month vacation, stepping off a ship, and is immediately crowned with a laurel wreath and declared PRESIDENT by ceremonial guards, to his utter shock. Behind them, an aide wheels over a towering teetering stack of six months of decree scrolls for him to copy. His face is horrified. Very funny." &
run cheese "4:3" "Chaos at the cheese market of Paxos: two rival cheese inspectors in official sashes simultaneously stamp the SAME giant wheel of cheese, one stamping a green 'FIT' seal and the other a red 'UNFIT' seal, glaring at each other; a merchant between them tears his hair out; confused shoppers hold contradictory receipts. A sundial in the background. Slapstick comedy." &
run goats "4:3" "A comic scene at a dusty crossroads: a proud farmer presents a herd of BLACK goats to a skeptical merchant who crosses his arms and shakes his head; between them a legislator shrugs helplessly holding his ledger open, its last page conspicuously blank with a dotted outline where decree 77 should be. One black goat chews the merchant's coin purse. Humorous." &
wait

# --- batch 6 ---
run fall "16:9" "Dark dramatic panel, storm clouds over Paxos: in the foreground a horrified scribe holds a botched stone tablet decree; behind him the Parliament chamber stands silent and empty, cobwebbed. On a hill, a stern general in a crested bronze helmet and red cape watches with crossed arms as soldiers with spears march past. Lightning, dramatic shadows, the end of an era. Ominous mood." &
run statemachine "16:9" "Split-screen comic panel divided by a torn-parchment seam down the middle. LEFT HALF: the ancient marble Chamber of Paxos, three legislators writing identical entries into ledgers, a messenger running with a scroll. RIGHT HALF: the exact same composition mirrored as a modern server room, three computer servers with glowing screens showing identical database tables, a network cable carrying a glowing packet. Matching poses left-to-right, visual rhyme, clever transition details across the seam." &
run hourglass "4:3" "Close-up dramatic panel: a large brass-and-glass hourglass on a marble ledge, sand streaming; through the glass bulb, warped and refracted, we see the Chamber behind with a majority of priests seated and the great doors barred shut with a wooden beam. A caption-box mood of a countdown. Tense but hopeful golden light." &
wait

echo "ALL DONE" >> "$LOG"
