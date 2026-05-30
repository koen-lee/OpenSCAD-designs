# Quiet Bubbler Pump Design Constraints

This folder explores two positive-displacement concepts for a quiet air pump: a Roots blower and a gerotor pump.

## Primary constraints

- Printable on an Ender 3 build volume (bed size is not a hard limit; we can go larger).
- Fairly tolerant to dimensional errors, with at least 0.5 mm practical clearance budget where needed.
- Airflow target: **500 L/min — hard requirement.**
- Working pressure: **~4 kPa** (see duty point below). 8 kPa is a stall/safety ceiling, not the operating target.
- Acoustic priority: favor non-contacting rotor operation, and see the noise objective below — the real enemy is **tonal** noise, not loudness.

## Acoustic objective: minimize tonal noise, not loudness

The driving requirement is acoustic, and specifically **tonal**: the concern is the
high-pitched whine of a high-RPM centrifugal blower, not broadband noise (bubble
gurgle at bath levels is acceptable). This matches the psychoacoustics — tonal noise
in the ~1–3 kHz band carries a large annoyance penalty even at equal SPL.

**Design rule for all approaches: keep the dominant noise sources below ~500 Hz and
broadband, not tonal.**

This reframes the project: we are not building a pump optimized for pressure or
efficiency, but a **low-tonal-frequency air mover.** RPM, lobe count, Δp, and drive
train are each judged first by what they do to the dominant tone.

## Duty point

- **Flow: 500 L/min (8.33 L/s) — hard requirement.**
- **Diffuser: coarse perforated holes** → low diffuser backpressure (<1 kPa).
- **Real Δp ≈ 4 kPa**, not 8 kPa:
  - Static head (water depth): ~3 kPa
  - Tubing (1.5 m × 25 mm ID @ 500 L/min): ~0.5 kPa
  - Coarse diffuser: ~0.5 kPa
- **8 kPa is ~2× the real need.** For a clearance-sealed printed pump that is harmful,
  not generous: leakage scales with √Δp, so designing for 8 kPa makes the hardest part
  of the problem (sealing) ~40% worse than necessary. Treat Δp as a parameter; operate
  at ~4–5 kPa; 8 kPa is a ceiling only.

### Tube pressure-drop check (why 4 kPa is plenty of headroom)

Air through 25 mm ID, 1.5 m, at 500 L/min (8.33e-3 m³/s):

- Velocity `V = Q/A = 8.33e-3 / (π·0.0125²) ≈ 17 m/s`
- `Re = ρVD/µ = 1.2·17·0.025 / 1.8e-5 ≈ 28,000` (turbulent)
- Blasius `f ≈ 0.316/Re^0.25 ≈ 0.024`
- Darcy `Δp = f·(L/D)·½ρV² = 0.024·60·(½·1.2·17²) ≈ 250 Pa`

Straight tube ≈ 0.25 kPa; doubled for fittings/bends/manifold → ~0.5 kPa. The
nominal headroom in the original 8 kPa was ~8× the actual tube loss.

## Why positive displacement, despite the duty point

A coarse-hole mat at 500 L/min is a **high-flow, low-pressure** duty — the natural fit
is a centrifugal/regenerative blower, not a PD pump. PD is chosen anyway for one
reason: **low tonal frequency.** The tonal source of a PD rotor is the pumping-event
frequency, `RPM × events_per_rev`:

| Machine | events/rev | @ 3000 RPM | @ 1500 RPM |
|---|---|---|---|
| Gerotor (5 outer lobes) | 5 | 250 Hz | 125 Hz |
| Roots (3-lobe) | ~6 | 300 Hz | 150 Hz |
| Centrifugal (7 blades, 10k RPM) | 7 | — | **1167 Hz** + harmonics to 3–4 kHz |

Low-RPM PD moves the fundamental tone down by ~5–10× vs. a centrifugal, out of the
ear's most sensitive band. This is the core justification for the PD path and applies
to both the Roots and gerotor variants.

## Derived implications from the airflow target

- 500 L/min is 8.33 L/s.
- At the ~4 kPa working point, ideal fluid power is about 33 W: $P = \Delta p \times Q = 4000 \times 0.00833 \approx 33\,\text{W}$ (≈67 W at the 8 kPa ceiling).
- Real shaft power will be higher once leakage, compression losses, bearing losses, belt losses, and motor efficiency are included.
- Because this is a printed prototype, internal leakage and dimensional variation are expected to be significant. The design should therefore prioritize easy scaling and rapid iteration over tight nominal efficiency.

## Manufacturing and assembly constraints

- Printed parts should remain functional with printer variation, shrinkage, and mild ovality.
- Rotor timing should avoid rotor-to-rotor rubbing if quiet running is the goal.
- Parts that require precision beyond normal printed quality should preferably be standard sourced components.
- Assembly should not require difficult alignment steps that are hard to repeat during prototyping.

## Option contrast

### Roots blower

Pros:

- Geometry and packaging are comparatively straightforward.
- Rotor support and shaft layout are easier to understand and assemble.
- The concept is well suited to positive displacement air pumping.
- The existing `roots_bubbler.scad` concept already models a generous clearance approach.

Cons:

- It needs synchronization gears to keep the rotors non-contacting.
- Quiet synchronization gears likely need better precision than printed gears can provide.
- If gears are sourced externally, the available gear sizes dictate center distance, shaft spacing, and therefore the overall blower dimensions.
- This reduces freedom to resize the pump body independently during prototyping.

Practical consequence:

- The Roots path is mechanically simpler, but its packaging is constrained by the precision gear train needed to keep it quiet.

### Gerotor with external synchronization

Pros:

- External synchronization can be done with belt drives.
- Both rotors run in the same direction, which suits a shared belt-drive approach.
- The same pulley ratio can likely be reused across multiple pump sizes.
- That makes scaling and prototyping simpler because the synchronization method does not have to be redesigned for each geometry.
- Belt isolation may also help with noise compared with meshing printed gears.

Cons:

- The eccentric inner rotor mount makes the mechanism and assembly harder.
- Shaft support, bearing placement, and sealing are less straightforward than for the Roots layout.
- The printed geometry is more sensitive to eccentricity errors and rotor runout.
- Leakage and local interference risk may be harder to control while still keeping the design tolerant to 0.5 mm errors.

Practical consequence:

- The gerotor path offers more prototyping freedom and potentially quieter external timing, but it pushes complexity into the eccentric rotor support and assembly.

## Current working conclusion

For a printed prototype that must stay quiet, both options should avoid rotor contact.

- The Roots concept is simpler in the pump body but depends on precision external gears.
- The gerotor concept is more flexible in scaling because one belt-drive idea can span multiple sizes.
- The main technical risk for the gerotor is not timing, but the eccentric rotor mount and the resulting assembly accuracy.

> Detailed reasoning for the belt-driven Roots variant (noise framing, Δp, sizing,
> lobe/twist, and belt counter-rotation) lives in [roots_design.md](roots_design.md).

## Open questions to resolve next

- What leakage level is acceptable before efficiency becomes unusable?
- How sensitive are the options to tolerances?
- Gerotor: what is the impact of a 3-lobe vs 4 or 5-lobe internal rotor re continuous airflow/pulsing? A small helical twist is already in CAD (for both gerotor and roots variants).
- What's the expected rotor rpm given the size constraints?
