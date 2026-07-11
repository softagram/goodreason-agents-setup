---
name: cycle
description: Run the full GoodReason workflow cycle (Strategist -> Architect -> Implementer -> Evolution) on a task. Use when tackling complex engineering tasks that benefit from structured analysis, design, implementation, and verification.
---

# GoodReason Workflow Cycle

Execute the full four-phase GoodReason workflow on the following task: "$ARGUMENTS"

Follow this cycle strictly:

## Phase 0: Intake (coordinator)
- State SOI → MOI: what system is selected, why it matters, to whom
- Classify the task's ring (1–5) per CLAUDE.md's Ring Selector and state the ring in every dispatch brief
- Ring 1–2 → lightweight path (Strategist+Architect combined into one dispatch; Evolution still mandatory)

## Phase 1: Analysis (Strategist)
Use the **Strategist** agent to:
- Analyze the goal (alpha) in relation to the current codebase reality (chi) — verify facts by reading before claiming
- Name the change pressure that created the task (delta-psi intake)
- Diagnostic tasks: produce at least 3 competing hypotheses with falsification criteria
- Ring 3+: produce a theory shortlist (applicable external theories / prior art / failure patterns, tagged for alpha-relevance and chi-consistency)
- Identify any alpha/chi interference (goal conflicts with reality)

**Gate A (coordinator):** check alpha x pi (does the proposed theory serve the MOI?) and chi x pi (do the facts support it?) before passing to the Architect.

## Phase 2: Design (Architect)
Use the **Architect** agent with the Strategist's analysis to:
- Record theory verdicts (adopt / adapt / refute each proposed item)
- Create a structural plan (pi => beta) with explicit interfaces and a test plan
- Group phases into milestones with scope envelopes and autonomy budgets; include Phase 0 as a diagnostic experiment when hypotheses exist
- Produce a plan the Implementer can follow without guessing

**Gate B (coordinator):** check delta-psi x beta (does the structure survive the pressure?) and phi x tau (are integration points concrete?) before dispatching the Implementer.

## Phase 3: Implementation (Implementer)
Use the **Implementer** agent per milestone:
- Complete the tau-checkpoint (plan exists, interfaces known, integration points clear, error handling defined)
- Autonomous mode (ring ≤3): run red → green → refactor per step, keep the Step Log, stop only on tripwires
- Strict mode (ring 4+): stop after each red and each green phase
- Phase 0 always returns to the coordinator for the hypothesis verdict
- Report any technical constraints discovered (phi => chi)

## Phase 4: Verification (Evolution)
Use the **Evolution** agent at each milestone and pre-commit (ring ≤3) or after each phase (ring 4+):
- Run tests and verify the fix works for the right reasons (omega recursive)
- Audit test quality from the Step Log (write-order, spec-shaped vs code-shaped tests)
- Verify diagram-code consistency when diagrams exist
- Check harmony with original purpose (omega ~ alpha)
- Identify any change pressure (delta-psi) for future iterations

**Gate C (coordinator):** check omega x alpha — did we solve the thing that mattered, not merely pass tests?

After all phases, summarize the cycle results and any remaining delta-psi (change pressure) for the next iteration.
