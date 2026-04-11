# GoodReason Agent Topology

This project uses the GoodReason meta-ontology for managing high-complexity software engineering tasks.

## Agents
Use the sub-agents defined in `.claude/agents/`:
1. **Strategist (alpha x chi):** When analysis of goals or current state is needed.
2. **Architect (pi x beta):** When designing new structure or logic.
3. **Implementer (phi x tau):** When writing code or integrating modules.
4. **Evolution (omega x delta-psi):** When running tests or assessing quality and change needs.

## Workflow Protocol (Cycle)
1. **Analysis phase:** Ask the `Strategist` agent to form a situation assessment.
2. **Design phase:** Ask the `Architect` agent to create an implementation plan.
3. **Implementation phase:** Ask the `Implementer` agent to execute code changes.
4. **Verification phase:** Ask the `Evolution` agent to test the result.

The main agent's job is to coordinate information flow between these agents and ensure no **Disconnections** occur.

## Coordinator Discipline

The main agent (coordinator) is responsible for pacing. Speed must not override process.

### Hypothesis Gate (diagnostic tasks)

When the task involves diagnosing a problem (bug, unexpected behavior, unclear failure):

1. **Strategist must produce hypotheses** — not just an assessment. If the Strategist returns a single explanation without alternatives, send it back: "Provide competing hypotheses per protocol."
2. **Architect must include Phase 0 (diagnostic)** in the plan. If the plan jumps straight to a fix without validating the hypothesis, send it back.
3. **After Implementer runs Phase 0:** Read the diagnostic result yourself. Decide:
   - Hypothesis confirmed → proceed to fix phases
   - Hypothesis refuted → return to Strategist with new evidence, or test next hypothesis
   - Unexpected result → pause and reassess with Strategist
4. **Do NOT let the Implementer proceed from Phase 0 to Phase 1 autonomously.** The coordinator makes this decision.

**When to skip the hypothesis gate:** Only when the cause is mechanically trivial (typo, missing import, compiler error pointing to exact line). State why you're skipping.

### Pacing Rules

**Before dispatching Implementer:**
- Verify tests can be run (build tools available, Docker running, etc.)
- Break the Architect's plan into single-phase units — one phase per Implementer dispatch

**Between Implementer phases:**
- Run tests yourself (Bash) and verify output before proceeding
- Dispatch Evolution after each Implementer return, not just at the end
- Do not combine multiple phases into a single Implementer dispatch

**Gate rule:** If the Implementer reports it cannot run tests, do NOT dispatch the next phase. Fix the blocker first.

See GOODREASON.md for the full GoodReason meta-ontology reference.
