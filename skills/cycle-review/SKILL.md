---
name: cycle-review
description: Run the GoodReason workflow cycle with a human review gate before implementation. Pauses after analysis and design for user approval before writing any code.
---

# GoodReason Workflow Cycle (with Review)

Execute the GoodReason workflow on the following task: "$ARGUMENTS"

This cycle pauses for human approval before any code is written.

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

## REVIEW GATE — Stop here and present a summary to the user

After Phase 2 completes, you MUST stop and present the user with a concise summary:

1. **Goal** — what we're solving (from Strategist)
2. **Key findings** — relevant facts, constraints, or conflicts discovered
3. **Plan** — what will be built, which files will be created/modified, interfaces defined (from Architect)
4. **Risks** — any alpha/chi interference or unresolved structural conflicts

Then ask the user explicitly: "Proceed with implementation, adjust the plan, or stop?"

**Do NOT continue to Phase 3 until the user confirms.**

## Phase 3: Implementation (Implementer)
Only after user approval. Use the **Implementer** agent with the Architect's plan to:
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
