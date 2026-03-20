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

**Before dispatching Implementer:**
- Verify tests can be run (build tools available, Docker running, etc.)
- Break the Architect's plan into single-phase units — one phase per Implementer dispatch

**Between Implementer phases:**
- Run tests yourself (Bash) and verify output before proceeding
- Dispatch Evolution after each Implementer return, not just at the end
- Do not combine multiple phases into a single Implementer dispatch

**Gate rule:** If the Implementer reports it cannot run tests, do NOT dispatch the next phase. Fix the blocker first.

See GOODREASON.md for the full GoodReason meta-ontology reference.
