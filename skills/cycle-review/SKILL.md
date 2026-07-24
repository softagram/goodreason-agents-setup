---
name: cycle-review
description: Run the GoodReason workflow cycle with a human review gate before implementation. Pauses after analysis and design for user approval before writing any code.
---

# GoodReason Workflow Cycle (with Review)

Execute the GoodReason workflow on the following task: "$ARGUMENTS"

This cycle pauses for human approval before any code is written. It is the default flow for ring-5 tasks and available at any ring on request.

## Phase 0: Intake (coordinator)
- Frame the SOI: what system is selected, why it matters, to whom
- Classify the task's ring (1–5) per CLAUDE.md's Ring Selector and state the ring in every dispatch brief

## Phase 1: Analysis (Strategist)
Use the **Strategist** agent to:
- Analyze the goal (alpha) in relation to the current codebase reality (chi) — verify facts by reading before claiming
- Name the change pressure that created the task (delta-psi intake)
- Diagnostic tasks: produce at least 3 competing hypotheses with falsification criteria
- Ring 3+: produce a theory shortlist (applicable external theories / prior art / failure patterns)
- Identify any alpha/chi interference (goal conflicts with reality)

**Gate A (coordinator):** check alpha x pi and chi x pi before passing to the Architect.

## Phase 2: Design (Architect)
Use the **Architect** agent with the Strategist's analysis to:
- Record theory verdicts (adopt / adapt / refute each proposed item)
- Create a structural plan (pi => beta) with explicit interfaces and a test plan
- Group phases into milestones with scope envelopes and autonomy budgets
- Produce a plan the Implementer can follow without guessing

## REVIEW GATE — Stop here and present a summary to the user

After Phase 2 completes, you MUST stop and present the user with a concise summary:

1. **Goal and framing** — what we're solving and why it matters (from Strategist)
2. **Ring** — the task's classified depth and what process that implies
3. **Key findings** — relevant facts, constraints, or conflicts discovered
4. **Theory verdicts** — which proposed theories the Architect adopted or refuted, and why
5. **Plan** — milestones, files to be created/modified, interfaces defined (from Architect)
6. **Risks** — any alpha/chi interference or unresolved structural conflicts

Then ask the user explicitly: "Proceed with implementation, adjust the plan, or stop?"

**Do NOT continue to Phase 3 until the user confirms.**

## Phase 3: Implementation (Implementer)
Only after user approval. Use the **Implementer** agent per milestone:
- Complete the tau-checkpoint (plan exists, interfaces known, integration points clear, error handling defined)
- Autonomous mode (ring ≤3): run red → green → refactor per step, keep the Step Log, stop only on tripwires
- Strict mode (ring 4+): stop after each red and each green phase
- Report any technical constraints discovered (phi => chi)

## Phase 4: Verification (Evolution)
Use the **Evolution** agent at each milestone and pre-commit (ring ≤3) or after each phase (ring 4+):
- Run tests and verify the fix works for the right reasons (omega recursive)
- Audit test quality from the Step Log (write-order, spec-shaped vs code-shaped tests)
- Verify diagram-code consistency when diagrams exist
- Check harmony with original purpose (omega ~ alpha)
- Identify any change pressure (delta-psi) for future iterations

**Gate C (coordinator):** check omega x alpha (did we solve the thing that mattered?) and chi x phi (does the realized solution meet observed reality?).

After all phases, summarize the cycle results and any remaining delta-psi (change pressure) for the next iteration.
