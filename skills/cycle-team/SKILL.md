---
name: cycle-team
description: Run the GoodReason cycle with the four agents as a persistent named team that communicates via SendMessage. Use for complex engineering tasks where agents benefit from retaining context across phases and asking each other direct clarifying questions, instead of being re-spawned fresh each phase.
---

# GoodReason Workflow Cycle — Team Mode

Execute the GoodReason workflow on the following task: "$ARGUMENTS"

**Team mode** keeps the four agents alive as named teammates for the whole cycle. They retain context across phases and can ask each other direct clarifying questions via `SendMessage` — instead of being re-spawned fresh each phase as the standard cycle does. You (the main agent) are the **coordinator**, addressable as `team-lead`. You still own phase transitions, the gates, and all user communication.

## What is identical to `/goodreason:cycle`

The four phases and their substance — Strategist (α×χ), Architect (π×β), Implementer (φ×τ), Evolution (ω×Δψ) — plus the **hypothesis gate**, **TDD checkpoints**, **Evolution-as-separate-verifier**, the **diagram protocol**, and the **handoff contract** are UNCHANGED. Team mode changes only the *delivery mechanism*: persistent teammates + peer messaging. When in doubt about a phase's content, follow the standard cycle.

## Setup

1. **Create the team:** `TeamCreate(team_name: "gr-cycle", description: "<short task summary>")`. If `gr-cycle` already exists this session, pick a unique suffix.
2. **Spawn all four agents as named background teammates** (`run_in_background: true`), so they all exist and can DM each other for the whole cycle. Use these exact `name`s and matching `subagent_type`s: `Strategist`, `Architect`, `Implementer`, `Evolution`.
3. **Onboarding prompt** for each (adapt the role line):

   > You are **\<Role\>** in team `gr-cycle` working on this task: \<task\>. Your teammates are Strategist, Architect, Implementer, Evolution; the coordinator is `team-lead`. Do NOT start working yet — wait for a DM from `team-lead` telling you to begin your phase. When you finish a phase, report your result and full handoff to `team-lead` via SendMessage (your plain-text output is not visible to the team). During or after your phase you MAY DM a teammate by name for a clarifying question, but stay strictly within your role boundary. Going idle between turns is normal — you will be woken by DMs.

   Spawn `Strategist` first and confirm it registered before spawning the rest, to avoid a startup race.

> **Why name teammates explicitly:** spawned teammates are addressed by the `name` you give them. Always tell each agent the names of the others in the onboarding prompt — do not rely on them discovering the roster from the team config file.

## Phase 1 — Analysis (Strategist)

DM `Strategist`: "Begin Phase 1 on \<task\>. Produce the α×χ situation assessment per your role; verify facts against the codebase before claiming them. **For diagnostic tasks, return competing hypotheses, not a single explanation.** Report your result + handoff to `team-lead` when done."

- Receive Strategist's result (delivered to you as a turn).
- **Hypothesis gate (diagnostic tasks):** if Strategist returns a single explanation, DM it back: "Provide competing hypotheses per protocol." Do not proceed until satisfied.

## Phase 2 — Design (Architect)

DM `Architect`: "Begin Phase 2. Strategist's analysis is available — you may DM `Strategist` directly to clarify anything. Produce the π×β plan with explicit interfaces. **For diagnostic tasks, Phase 0 of your plan must be a diagnostic experiment** before any fix. Report your plan + handoff to `team-lead`."

- Architect may DM Strategist; you will see peer-DM summaries in idle notifications — that visibility is informational, no action needed.
- Receive the plan. Break it into single-phase units; one Implementer engagement per unit.

## Phase 3 — Implementation (Implementer), TDD-phased

Engage `Implementer` **one step at a time**. The persistence advantage: you re-engage the *same* Implementer by DM, so it keeps its place without re-explanation — but this makes it tempting to let it run ahead. Do not.

- **Diagnostic tasks — Phase 0 first:** DM Implementer to run the diagnostic experiment, report the **raw result** to `team-lead`, and STOP. You (coordinator) read the result and decide: confirmed → proceed to fix; refuted → return to Strategist; unexpected → reassess. Do NOT let Implementer go Phase 0 → Phase 1 on its own.
- **Red:** DM "Write the red test documenting \<behavior\>. Run it. Report the red result to `team-lead`. Do NOT proceed to green." Verify the test fails for the *expected* reason before continuing.
- **Green:** DM "Proceed to green for this step." Then verify.
- **Refactor:** separate step, separate DM.
- Implementer may DM `Architect` for design clarification.
- Never let Implementer collapse red→green→refactor into one motion. One return per step.

## Phase 4 — Verification (Evolution), after each Implementer step

After each step, DM `Evolution`: "Assess the change just made: \<summary\>. Run the tests. Verify it fulfills the original goal (ω~α) and works for the *right reason*. If any `.mmd` diagrams relate to this change, check them against the code. Report verdict (proceed / halt / return to earlier agent) to `team-lead`, and flag `omega-diagram-mismatch: escalate to <role>` if a diagram contradicts the code."

- Evolution may DM `Strategist` (to check against the original goal) or `Architect`/`Implementer`.
- Act on Evolution's verdict before the next step. If it says halt/return, go back before proceeding.

## Diagram protocol

Same as the standard cycle: Strategist/Architect produce mermaid **content** in their handoff (they do not write files). **You (coordinator) write the `.mmd` files**, preserving the `%% Author:` header, into the project's diagram directory. Evolution checks consistency; on a flagged mismatch, follow the conflict-resolution escalation (re-dispatch the original author role).

## Teardown (always)

When the cycle completes or is aborted:

1. Shut down each teammate: `SendMessage(to: "<name>", message: {type: "shutdown_request", reason: "cycle complete"})` for `Strategist`, `Architect`, `Implementer`, `Evolution`.
2. Wait for the shutdown confirmations.
3. `TeamDelete()` to remove the team and its task list.

Leaving idle teammates alive wastes resources — never skip teardown.

## Summary

After teardown, summarize the cycle results, any remaining Δψ (change pressure) for the next iteration, and the paths of any `.mmd` diagrams written.
