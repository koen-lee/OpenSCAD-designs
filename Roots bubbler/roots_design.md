# Roots Bubbler — Design Reasoning

Working notes for the belt-driven, low-noise Roots blower variant. Companion to
[design_constraints.md](design_constraints.md), which holds the shared constraints
and the Roots-vs-gerotor contrast. This file captures the reasoning that is specific
to the Roots path.

The shared objective (tonal-noise framing), the duty point (Δp ≈ 4 kPa, the tube
check), and the rationale for choosing positive displacement at this duty all live in
[design_constraints.md](design_constraints.md), since they apply to every variant.
This file picks up from there with the Roots-specific consequences.

## Sizing: big and slow

Bed size is not a limiting constraint, so trade size for low RPM.

- Target ≤ ~3000 RPM (ideally 1500–2500) to keep tone ~125–300 Hz and tip speed low.
- Delivered volume needed @ 3000 RPM: `500 L/min ÷ 3000 = 167 cm³/rev`.
- At ~60% volumetric efficiency (realistic for printed clearances even at 4 kPa):
  **~280 cm³/rev swept.**
- Roots swept volume ≈ `4·R²·L` (order-of-magnitude). For 280 cm³ at L = 120 mm →
  `R² ≈ 5.8 cm²` → R ≈ 24 mm → **~Ø100–120 mm over the pair, ~120 mm tall.**
- Tip speed Ø110 @ 3000 RPM: `π·0.11·50 ≈ 17 m/s` — acceptable for quiet.

**Lower Δp lets us hold this RPM down** (leakage is RPM-independent; if Δp is high we
must spin faster to compensate, which raises the tone). Δp and noise are coupled
through RPM.

## Lobe count and helical twist

More events/rev both **smooths pulsation** and **raises the tone** for a given RPM.
For low pitch we want few lobes, but few lobes pulse more — a genuine tension.

**Resolution: use helical twist for smoothness, low lobe count for low pitch.**
A twist spanning roughly one lobe pitch gives continuous chamber hand-off (smooth
flow) without raising the fundamental frequency. This lets a 3-lobe Roots run slow
and still deliver continuous airflow.

- Current CAD twist (`gerotor.scad`: `twist = nB*3 = 9°`) is far too small for this.
- Target on the order of half a lobe pitch as a printable/sealing compromise
  (full pitch for 3-lobe = 120°; heavy helix adds axial thrust and harder-to-print,
  leak-prone seams). Tune against a flow-meter.

## Counter-rotation with a belt drive

A plain toothed belt makes two pulleys co-rotate, but **Roots rotors must
counter-rotate.** (Gerotor got the belt "for free" because both its rotors co-rotate.)
Exactly one direction reversal must be introduced, and it must hold tight phasing:
for 3-lobe rotors at ~1 mm tip clearance the timing budget is roughly **±1°** before
risk of contact.

Options considered:

- **Crossed/figure-8 toothed belt** — teeth can't mesh at the crossover; a crossed
  flat/round belt slips and loses timing. **Rejected.**
- **Serpentine + back-side idler reversal** — the reversed pulley ends up driven by
  the flat back of the belt (friction, non-positive) → loses timing. **Rejected.**
- **Belt times both shafts + separate gears just reverse** — redundant kinematic loop
  (belt says co-rotate, gears say counter-rotate); over-constrained, fights itself.
  **Rejected.**
- **Two motors, electronic phasing (virtual line shaft)** — elegant, no belt/gear
  reversal problem, but all precision moves into encoders + control loop; holding ±1°
  through load transients is risky for a strict non-contact guarantee. **Future
  variant, not first prototype.**

### Chosen: gears time the rotors, belt only delivers power

- **One 1:1 gear pair between the two rotors** does both reversal and timing — the
  classic Roots timing-gear arrangement. This is what holds the ±1° non-contact.
- **The belt drives only ONE rotor shaft from the motor.** The second rotor is driven
  through the gear pair. No timing-loop conflict, because the belt touches only one of
  the two timed shafts.
- **Source the 1:1 pair as standard metal gears** (e.g. MOD 1 spur pair). This honors
  the constraint that precision parts should be sourced, not printed, and removes the
  "precision printed gears" objection outright.
- The belt still isolates the motor (the loudest, highest-RPM link), which is the
  noise win we wanted.

**Critical detail:** the timing gears must be **anti-backlash / lightly preloaded**.
Backlash *is* timing error, and timing error is rotor contact. Use a tight-mesh pair,
a spring preload, or a split (scissor) gear. This single detail makes or breaks the
non-contact promise.

**Tonal caveat:** with the motor belted off, the timing-gear mesh becomes the highest
remaining tonal source. Mesh frequency = `RPM × teeth` — e.g. 20T @ 1500 RPM = 500 Hz,
@ 2000 RPM = 670 Hz (borderline). Metal gears in light grease at low load are quiet,
but this mesh should be measured. Favor the low end of the RPM range.

### Secondary tonal sources to watch (once rotor tone is ~150 Hz)

- **Timing belt tooth-mesh** — can sing in the kHz range. Use a larger pulley / HTD
  profile to drop mesh frequency, or a quiet belt.
- **Motor** — prefer a BLDC running at low RPM with good control; avoid a high-RPM
  motor geared down (the motor itself whines).
- **Port/cavity resonance** — sharp port edges produce tonal hiss. Use generous,
  rounded, helically-swept ports to keep it broadband.

## Current working decision

**Build: large, slow, belt-fed Roots — ~2000 RPM, ~4 kPa, 3-lobe, strong helix,
sourced 1:1 metal timing gears (reversal + timing), motor belted to one rotor shaft.**

Remaining open tradeoff: how low to push RPM vs. how large/awkward the printed rotor
becomes. Since the bed allows it, push toward the slow end until the part gets
unwieldy to print or the gear-mesh tone becomes the limiting noise source.
