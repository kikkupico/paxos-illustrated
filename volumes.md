# Distributed Algorithms of Ancient Greece

*Nine volumes, fully illustrated*

---

## Volume I: The Disordered Sundials of the Aegean
**(Lamport, "Time, Clocks, and the Ordering of Events," 1978)**

Long before the Senate convened, the shepherds of the archipelago lived in temporal anarchy. Every islander owned a bronze sundial, but Aegean fog and mountain shadows meant no two agreed.

When Aristides claimed he sheared his goat before Leonidas branded his sheep, blood feuds erupted. A wandering scholar named Leslie arrived at the port, listened to both men, and delivered an unwelcome verdict:

> "Neither of you can be answered. You were on different islands and no skiff passed between you. There is no fact of the matter here that any assembly of mortals could recover."

What he offered instead was smaller and far more useful. He decreed the **Law of the Monotonic Bead**:

- Whenever a citizen acts — buys olives, shears a sheep — he flicks his abacus forward one bead.
- Whenever a messenger rows between islands, he carries a slate stamped with the sender's bead count.
- On receipt, the recipient pushes his abacus past the messenger's count before replying.

This yields the relation **happened-before**: if scroll A begat scroll B, then A's count is lower. The converse does *not* hold. A lower count may mean "earlier," or it may mean "unrelated, and the question is empty." The abacus can prove ancestry; it cannot detect concurrency.

For the feuding shepherds, Leslie prescribed a second, cruder remedy: where two events are unrelated, settle the order by the alphabetical rank of the islands. Arbitrary, but *identically* arbitrary on every island — and an agreed fiction serves a court better than an irrecoverable truth.

Leslie also spent half his scroll on the sundials he was accused of smashing, establishing how closely bronze clocks *can* be kept in step when the roads have a known length. He never claimed physical time was an illusion. He claimed it was expensive.

> *Marginal gloss, later hand (Fidge, Mattern, 1988): carry one bead per islander rather than one in total, and concurrency becomes visible — at the cost of an abacus that grows with the empire.*

---

## Volume II: The Generals Before the Walls
**(Pease, Shostak & Lamport, 1980; Lamport, Shostak & Pease, "The Byzantine Generals Problem," 1982)**

Commanders encircling a city must attack together or be destroyed piecemeal. They confer only by messenger — and some commanders are bribed, sending "attack" to the left flank and "retreat" to the right.

Three geometers established the price of treachery, and it is steep:

- **The 3f+1 Law.** Where messages are spoken and cannot be proven, loyal agreement requires more than three times the traitors: at least `3f+1` commanders to survive `f` liars. With three generals and one traitor, the two loyal men provably cannot agree. Honest commanders must out-number not merely the traitors but the traitors *plus* the loyal men the traitors have deceived.
- **The Reprieve of the Unforgeable Seal.** If every commander's seal cannot be counterfeited, a lie can be traced to its author and passed along as evidence. Signatures collapse the requirement to `f+2` commanders. Treachery is cheap to tolerate only when it leaves fingerprints.

This bound is the foundation of every fortified council in the later volumes. It was established here, three centuries before the citadel of Volume VII was built on top of it.

---

## Volume III: The Curse of the Sleeping Shepherd
**(Fischer, Lynch & Paterson, 1985)**

Flush with their abaci, the islanders gathered at Delphi to design a council that could vote on tariffs without ever locking up, even if rowboats sank in the surf.

Three austere priestesses descended from the cave with a burnt parchment and cast an eternal hex:

- **The Oracle's Curse.** If rowboats may take an arbitrary, unbounded number of days to cross, and if even *one* shepherd may faint into a coma indistinguishable from an extended siesta, then no deterministic rite can guarantee both that the council never contradicts itself and that it always reaches a verdict.
- **The Bivalent Trap.** The proof is constructive and merciless. At any moment the council hangs between "Aye" and "Nay," an adversary need only delay the single messenger whose arrival would tip it — and can do so again, and again, forever. No message is ever lost. Every messenger eventually arrives. The council simply never finishes.

Note the shape of the curse precisely, since later volumes are all built in its shadow: the assembly may keep **safety** unconditionally. It is **liveness** — the promise to eventually decide — that cannot also be guaranteed.

---

## Volume IV: The Passable Season
**(Dwork, Lynch & Stockmeyer, "Consensus in the Presence of Partial Synchrony," 1988)**

The assembly wept for three years. Then a delegation of navigators pointed out that the priestesses had assumed a sea of *infinite* caprice — and the Aegean, whatever its moods, is not that.

They proposed the **Doctrine of the Eventual Calm**. The winter storms may be arbitrary in length and no one knows when they will end. But they *do* end, and thereafter a skiff crosses within some knowable span.

This is enough. A rite may be constructed that:

- **never** contradicts itself, storm or calm, and
- **eventually** reaches a verdict, once the calm arrives.

The curse is not defeated. It is out-waited. Every parliament in the volumes that follow assumes this doctrine silently, which is why they appear to achieve what Volume III forbade. They do not. They merely decline to promise progress during the storm.

---

## Volume V: The Part-time Parliament
**(Lamport, "The Part-Time Parliament," 1998; "Paxos Made Simple," 2001)**

On the isle of Paxos, civic life was a farce. Legislators were part-time merchants who wandered out of the chamber whenever a boar invaded the vineyard. Messengers were fond of retsina and routinely mislaid dispatches.

General Phineas proposed a rite of two rounds for passing a single decree:

**Phase 1 — The Promise.** A proposer shouts a ballot number across the agora: *"Promise to ignore all lesser ballots, and tell me every oath you have already sworn."* If a majority of legislators assent and report their oaths, he holds a quorum.

**Phase 2 — The Carve.** Here lies the whole difficulty:

> If the returned slates contain **any** prior oaths, the proposer must abandon his own ambition and propose the value of the oath bearing the **highest ballot number** among them. Not the first reported. Not the oldest. Not whichever seems most reasonable. The **highest-numbered**.
>
> Only if the majority reports *no* prior oath may he propose a decree of his own choosing.

Then: *"Carve decree #42 under this ballot!"* Once a majority chisels it, the law is immortal.

The safety argument rests on a single geometric fact: any two majorities of the same assembly must share at least one living legislator. That shared man remembers the earlier oath and reports it, so no later ballot can overlook a decree already accepted.

Mainland scholars rejected the account on the grounds that it involved togas. In 2001 the islanders dropped the masks and republished it in nine pages of plain speech — *ask a majority for permission, then tell them to write it down* — prefaced by the remark that the allegory had evidently been too subtle.

---

## Volume VI: The Ledger of Many Decrees
**(Oki & Liskov, "Viewstamped Replication," 1988; Multi-Paxos)**

Volume V passes *one* law. An empire needs a ledger.

Two innovations made the Synod governable:

- **The Standing Consul (Multi-Paxos).** Run one Synod per line of the ledger, and the chamber drowns in Phase 1. So elect a proposer who holds his ballot number across *all* future lines. He performs the Promise once on taking office, then carves line after line with a single round each. The two-phase rite becomes a one-phase rite for as long as his tenure holds — and Phase 1 becomes, in effect, the election.
- **Gaps in the Marble.** Because each line is an independent Synod, line 7 may be carved while line 5 is still contested. The ledger is permitted holes, and readers must wait for them to fill before reading past. This freedom is real, and it is the specific thing the monks of Volume IX will abolish.

A separate reform, drafted at the same time in the dry hand of a granary clerk rather than a storyteller, arrived at a primary-based constitution with formal succession of views. It was near-identical in substance and attracted no attention whatever — evidence that the togas, not the geometry, are what made the Paxos scrolls famous. It is also the closer ancestor of the monastery in Volume IX than anything on Paxos itself.

---

## Volume VII: The Citadel of Iron Quorums
**(Castro & Liskov, "Practical Byzantine Fault Tolerance," 1999)**

For five hundred years the `3f+1` Law of Volume II had been correct, celebrated, and unusable. Its rites demanded that every commander seal every message with an unforgeable signet, and the sealing wax cost more than the war.

Two inquisitors sailed into the harbour not with a new theorem but with a **budget**. Their citadel is the first Byzantine council a working city could actually afford:

- **Cheap seals in place of signets.** They replaced costly unforgeable signatures, on the common path, with shared-secret tallies that any two senators can verify between themselves. This alone is most of the speed. Signatures return only for the rare and expensive rite of deposing a leader.
- **The Three-Phase Gauntlet.** No citizen carves on a single leader's word. *Pre-Prepare* distributes the leader's proposal; *Prepare* establishes that a quorum heard the *identical* proposal for that slot and view; *Commit* establishes that a quorum has established that. Two rounds where Volume V needed one, because here the leader may itself be the liar.
- **Succession of Views.** The gauntlet secures honest decrees. It does not remove a traitorous leader who simply proposes nothing. The view-change rite — carefully constructed so a new leader cannot disavow what the old one committed — is the machinery that makes the citadel live rather than merely refuse to lie.

The inquisitors then did the thing no geometer had: they ran a working scriptorium on it, and reported it slower than an unguarded one by a margin a city would pay.

---

## Volume VIII: The Quarries of the Roman Guilds
**(Chandra, Griesemer & Redstone, "Paxos Made Live," 2007)**

Pragmatic Roman engineers arrived to build an industrial empire atop the pastoral algorithm, and found the mathematics pristine and the island collapsing:

- **The Crumbling Cliffs.** Decades of micro-decrees had filled every quarry. The Romans introduced **snapshots**: thousands of past ledgers crushed to gravel, replaced by one summary tablet — *"As of ballot 5,000, the island holds 200 sheep."*
- **Chipped Chisels.** Scribes struck a tablet, believed they had carved a letter, and the sandstone sheared away silently. The Romans mandated checksums in gold leaf on every slate, and a rule that a scribe who cannot vouch for his own archive must rejoin the assembly as a stranger.
- **Mad Kings.** Scribes recovering from heatstroke would run into the forum bellowing stale orders as though still Consul. The Romans issued signet rings bound to an hourglass — **master leases** — that turn to lead the instant the sand runs out.
- **The Untestable Rite.** Worse than any of these: a council that fails only under a precise interleaving of boars, storms and comas cannot be inspected by watching it work. The Romans built a machinery of deliberate sabotage and deterministic replay, and considered it the larger half of the project.

The engineers' verdict: *the Greek parable is ten paces of the journey. The remaining ninety are quarry management, stone sanitation, and mortar.*

---

## Volume IX: The Reformation of the Raft Monks
**(Ongaro & Ousterhout, "In Search of an Understandable Consensus Algorithm," 2014)**

Disillusioned by the ceremonies of Volume VI — the standing consul, the holes in the marble, the gymnastics needed to explain any of it to a novice — a band of apprentices sailed north and founded a minimalist monastery.

They kept the geometry and discarded the freedoms:

- **One Abbot per Reign.** Not "one Abbot." The monastery guarantees at most one Abbot per numbered **reign**, and a deposed Abbot on the far side of a storm may go on believing he rules for some time. He is harmless, because his reign number is stale and no monk with a higher number will transcribe from him. The reign number, not the man, is what carries authority.
- **The Obedient but Suspicious Scribe.** Monks do not blindly transcribe. Every dispatch from the Abbot names the *preceding* line and the reign that carved it. If a monk's scroll does not match at that line, he **refuses the dispatch**, and the Abbot must walk backward line by line until they find common ground. That refusal is precisely the mechanism that keeps every scroll in the monastery identical. A monastery of obedient scribes would diverge by the second storm.
- **No Gaps.** The Abbot writes sequentially into one unbroken scroll. Where Paxos permits line 7 before line 5, Raft forbids it. The cost is throughput; the gain is that a monk's scroll length alone certifies everything in it.
- **The Election Restriction.** No monk may be raised to Abbot unless his scroll is at least as current as a majority's. This is how the monastery avoids ever needing to un-carve a committed decree — it simply never elects a man who would have to.
- **The Heartbeat Bell and the Lots.** The Abbot rings at fixed intervals. If the bell goes silent, sand-glasses empty, an interregnum is declared, and monks draw lots with randomized egg-timers — so that two candidates rarely split the vote twice running.
- **Scraping the Ink.** A deposed Abbot whose scroll diverges has his erroneous lines razored away. The reigning Abbot never scrapes his own.

Over the harbour, a sign: *"Paxos was devised by divine geometers to torture mortal men. Raft was written for mortals who wish to understand their own laws."*
