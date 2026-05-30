# Gerotor Bubbler — Design Reasoning

Working notes for the belt-driven gerotor variant. Companion to
[design_constraints.md](design_constraints.md), which holds the shared constraints
(tonal-noise objective, Δp ≈ 4 kPa duty point, and the rationale for choosing
positive displacement). This file captures the reasoning specific to the gerotor path.

Status: concept settled at architecture level; implementation details still to be
worked out.

## Kinematic facts that drive the mechanism

In a gerotor the inner rotor (N teeth) and outer ring (N+1 teeth) rotate about **two
fixed, parallel axes** offset by the eccentricity `e`. Both turn the **same
direction**; speed ratio is `(N+1):N`.

Key consequence: there is **no orbiting part and no eccentric carrier**. Both rotors
are plain shafts on fixed parallel centers — like Roots, except the centers are very
close (offset = `e`, a few mm) and the ratio is `(N+1):N` instead of 1:1.

The "hard eccentric mount" reputation comes from *oil-pump-style* gerotors that fix
the inner rotor to the drive shaft and let the outer ring **float in a bore**. That
floating-ring arrangement is the fiddly one — and we are deliberately not building it
that way.

## Arrangement choice

### Arrangement 1 — outer ring floats in a bore (rejected)

Inner rotor on the driven shaft; outer ring spins freely in a circular pocket whose
axis is offset by `e`. One shaft.

- Pro: one shaft/bearing set, compact.
- Con: the outer ring is supported only by its OD sliding in a printed bore — a large,
  hard-to-print, leak-prone journal located **exactly at the sealing surface**. Bore
  runout *is* the tip clearance. This puts precision where a printer is weakest.
- **Rejected** — this is the arrangement the constraints doc rightly fears.

### Arrangement 2 — both rotors journaled on their own shafts (chosen)

Treat it like Roots: two parallel shafts on a bearing plate, centers offset by `e`,
each rotor pinned to its shaft, timed externally by a **plain toothed belt** at
`(N+1):N`. Neither rotor relies on its sealing surface for support.

- Precision lives in the **bearing-bore spacing on a printed end plate** (in-plane /
  XY — the printer's *good* axis), not in a sliding journal.
- Bearings are sourced precision parts (per the constraints doc).
- Eccentricity `e` is just the center distance — a number tuned by reprinting one plate.
- Both rotors co-rotate → **plain belt, no reversal gears.** This is the gerotor's
  genuine advantage over Roots and it removes the counter-rotation problem entirely.
- Cost: two shafts, and the belt must hold the `(N+1):N` phase to ~±1° (same
  non-contact budget as Roots).

**Decision: Arrangement 2.** It converts "hard eccentric floating-ring mount" into
"two journaled shafts at a slightly odd center distance, belt-timed."

## Fixed parameters

- **Inner N = 4, outer = 5** → **5:4 belt** (e.g. 25T inner-shaft : 20T outer-shaft,
  or any 5:4 such as 30:24).
- Events/rev = 5 → fundamental tone ~167 Hz @ 2000 RPM, ~125 Hz @ 1500 RPM.
  Comfortably in the low/broadband zone per the acoustic objective.
- **Eccentricity `e` baked into a cheap, reprintable bearing plate** (in-plane center
  distance).

## The catch with "reprint the plate" tuning

If `e` is defined by the plate but the rotor profiles are a fixed printed pair, then
reprinting the plate at a different center distance **desynchronizes the plate from
the rotors** — the conjugate geometry only seals at the `e` it was generated for.

**Rule: `e` (and N) are single-source-of-truth parameters that drive BOTH the rotor
profiles AND the plate center distance in the same `.scad`.** Reprinting to tune means
regenerating both the plate and the rotor pair from the new `e`, not just the plate.

Current-CAD note: in [gerotor.scad](gerotor.scad) the profile relationship is set via
`r1`/derived `r2`, but the second rotor is placed with a hand-typed
`translate([0,10,0])` — the eccentricity (10) is **not tied to the profile
generation.** That decoupling is exactly what will bite on reprint and is the first
real CAD task to fix.

## Bearing-plate concept (Arrangement 2, baked-in `e`)

- **One end plate carries both bearing bores**, centers exactly `e` apart. This plate
  *is* the precision part — printed flat in XY, so spacing is accurate and cheap to
  redo. This is what gets reprinted to tune `e`.
- Standard ball bearings pressed into the two bores.
- Two shafts: inner rotor + 25T pulley on one; outer rotor + 20T pulley on the other.
- **Mirror plate** on the far end for the second bearing of each shaft and the axial
  sealing face.
- Two plates + a wrapped housing shell form the chamber; belt and pulleys sit outboard
  of one plate.

Tuning loop: change `e` (or clearance offsets) → regenerate rotors + plate → reprint
those printed parts → reuse the same bearings, shafts, pulleys, belt. Fast iteration,
fits the rapid-prototyping goal.

## Hard parts still to engineer

1. **End-face (axial) sealing — the dominant leak path.** A gerotor seals on the
   radial tip line *and* both flat end faces. The end faces are a large annulus next
   to the chambers; the inner rotor's face moves relative to the housing. At 4 kPa it
   is tolerable but must be engineered:
   - Set the **axial gap by a sourced sleeve/spacer on each shaft + shims under the
     plates**, not by printed Z height (Z is the bad axis). Target ~0.1–0.2 mm.
   - Optional **labyrinth grooves** on the end plates to multiply resistance without
     tightening the gap.

2. **Belt phase indexing.** 5:4 is non-1:1, so there is exactly one correct mesh phase,
   set at assembly. Prefer a **rotor-direct index jig** (a pin through one plate that
   holds each rotor at its reference angle while the belt is tensioned) over relying on
   pulley timing marks. Design an explicit index feature into the model.

3. **Inner rotor axial location.** Locate each rotor against a shoulder/sleeve and a
   bearing so it cannot walk into an end plate. The inner rotor is small, so size its
   shaft/shoulder for the torque (≈ 33 W / ω).

4. **Pressure-side separating load.** Chamber pressure pushes the two centers apart,
   loading the bearings radially and tending to *increase* tip clearance on the load
   side. Modest at 4 kPa but real — bearings must take it, and it is another reason to
   journal the rotors (Arrangement 2) rather than float a ring that would deflect.

## Roots vs. gerotor, now that both are "two shafts + belt on a plate"

- **Gerotor advantage:** co-rotating → plain belt, **no reversal gears at all** (this
  removes the Roots concern about gear size dictating geometry).
- **Gerotor cost:** larger end-face sealing area; `(N+1):N` phase needs indexed assembly.
- **Roots advantage:** simpler 1:1 timing; smaller end-face area.
- **Roots cost:** the reversal problem → either gears (geometry-dictating) or the
  belt-feeds-one-shaft + sourced-timing-gears compromise (see
  [roots_design.md](roots_design.md)).

## Current working decision

**Belt-timed gerotor, N=4/outer-5, both rotors journaled on sourced bearings in a
reprintable end plate that defines `e`, axial gap set by sourced sleeve + shims, plain
5:4 belt, indexed assembly. `e` and N are single-source parameters driving both the
rotors and the plate.**

Next implementation steps (to discuss):
1. Tie `e` to both rotor generation and plate spacing in the `.scad`.
2. Verify the conjugate pair actually seals through a full rotation in animation.
