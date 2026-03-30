---
name: cycle
description: Run the full GoodReason workflow cycle (Strategist -> Architect -> Implementer -> Evolution) on a task. Use when tackling complex engineering tasks that benefit from structured analysis, design, implementation, and verification.
---

# GoodReason Workflow Cycle

Execute the full four-phase GoodReason workflow on the following task: "$ARGUMENTS"

Follow this cycle strictly:

## Phase 1: Analysis (Strategist)
Use the **Strategist** agent to:
- Analyze the goal (alpha) in relation to the current codebase reality (chi)
- Verify facts — read relevant files before making claims
- Identify any alpha/chi interference (goal conflicts with reality)
- Produce concrete next steps

## Phase 2: Design (Architect)
Use the **Architect** agent with the Strategist's analysis to:
- Create a structural plan (pi => beta)
- Define explicit interfaces (exports/imports)
- Identify and resolve structural conflicts
- Produce a plan the Implementer can follow without guessing

## Phase 3: Implementation (Implementer)
Use the **Implementer** agent with the Architect's plan to:
- Complete the tau-checkpoint (plan exists, interfaces known, integration points clear, error handling defined)
- Write and integrate the code (phi x tau)
- Report any technical constraints discovered (phi => chi)

## Phase 4: Verification (Evolution)
Use the **Evolution** agent to:
- Run tests and verify the implementation (omega recursive)
- Check harmony with original purpose (omega ~ alpha)
- Identify any change pressure (delta-psi) for future iterations
- Report results and recommendations

After all phases, summarize the cycle results and any remaining delta-psi (change pressure) for the next iteration.
