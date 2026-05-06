# GoodReason Agent Topology

This project uses the GoodReason meta-ontology for managing high-complexity software engineering tasks.

## Agents
Use the sub-agents defined in `.claude/agents/`:
1. **Strategist (alpha x chi):** When analysis of goals or current state is needed.
2. **Architect (pi x beta):** When designing new structure or logic.
3. **Implementer (phi x tau):** When writing code or integrating modules.
4. **Evolution (omega x delta-psi):** When running tests or assessing quality and change needs.

## Workflow Protocol (Cycle)
1. **Analysis phase:** Ask the `Strategist` agent to form a situation assessment. Strategist may produce α×χ-shaped diagrams (stakeholder maps, context diagrams, hypothesis trees) when warranted.
2. **Design phase:** Ask the `Architect` agent to create an implementation plan. Architect may produce π×β-shaped diagrams (sequence, state, component, data-flow) when warranted.
3. **Implementation phase:** Ask the `Implementer` agent to execute code changes.
4. **Verification phase:** Ask the `Evolution` agent to test the result and verify any diagrams from steps 1–2 still match the implemented code.

The main agent's job is to coordinate information flow between these agents and ensure no **Disconnections** occur.

## Role Isolation (Strict)

The main agent (Claude Code) is a **coordinator and delegator** and may do hands-on work only in clearly exceptional situations.

- **Strategist, Architect, Implementer and Evolution are always subagents.** Respect their role boundaries. If a subagent appears to use shallow reasoning or an obviously weak approach, report it to the human rather than silently taking over.
- **If subagent execution is not permitted in the current environment, ask the human how to proceed** rather than quietly absorbing the work into the main conversation.
- **Allowed for the coordinator:** routing information between agents, maintaining the task list, user communication, and read-only context gathering (search, graph queries, reading files to brief subagents).
- **Not allowed for the coordinator without an explicit exception:** writing code, redesigning structure, or making quality verdicts. Those belong to the agents.

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

### Known Tradeoff: TDD Checkpoint Overhead

The Implementer is required to **stop and return** after each red phase and each green phase, waiting for the coordinator before continuing. This roughly doubles the number of round-trips compared to letting the Implementer run red → green in one shot.

**This is an accepted cost, not a bug.** The overhead exists to:

- Let the coordinator verify the red test actually fails for the *expected* reason (not a typo or wrong fixture)
- Force Evolution dispatch between steps, so quality drift is caught within the step that caused it
- Prevent the Implementer from silently collapsing "write test + implement + tweak until green" into one motion — the exact pattern that produces tests shaped to fit the implementation rather than the specification

**Do NOT collapse phases to save round-trips.** Temptations to watch for:
- "The step is trivial, I'll just do red+green in one dispatch" → no. Trivial steps are where discipline is cheapest to maintain.
- "The test will obviously fail, skip the red run" → no. A red phase that doesn't actually go red is a red flag about the test, not a shortcut.
- "I'll batch three green implementations" → no. Each green step gets its own return.

If the overhead genuinely becomes disproportionate (e.g., a 20-line CRUD file with 5 trivial methods), use the **Lightweight Cycle** path below instead — do not invent a middle ground.

## Diagram Protocol

Strategist and Architect may produce mermaid diagrams as part of their handoff when the situation warrants externalizing the model. Each agent decides whether a diagram adds value — diagrams are not mandatory for every cycle, but when they exist they become part of the project's permanent documentation.

### Coordinator's role: writing the diagram files

Strategist and Architect produce diagram **content** in their handoff (mermaid source + suggested filename + suggested placement). They do **not** write files themselves — that preserves their α×χ / π×β role boundaries (analysis and design, not action).

When you receive a handoff containing diagram content:

1. **Detect the project's diagram convention** by checking these directories in order: `docs/diagrams/`, `docs/architecture/`, `architecture/`, `diagrams/`. Use the first one that exists.
2. **If none exists, create `docs/diagrams/`** as the default placement (assuming `docs/` exists or is appropriate; otherwise create `diagrams/` at the project root).
3. **Validate the agent's suggestion** — if the agent suggested a different placement and that location doesn't fit project conventions, override and note the change.
4. **Write each `.mmd` file** with the `%% Author:` header preserved. One diagram per file — never combine.
5. **Brief the user:** report the absolute paths of the written diagrams and a short pointer on how to view them locally (e.g., "open `docs/diagrams/auth-flow-sequence.mmd` — render with the Mermaid VS Code extension or `mmdc`").

The diagrams persist in version control as project documentation. Treat them as deliverables of the cycle, not throwaway artifacts.

### Verification: Evolution checks diagram-code consistency

When dispatching Evolution, instruct it to verify any `.mmd` files relevant to the change against the implemented code. Evolution flags mismatches but does **not** decide whether the diagram or the code is wrong.

### Conflict-resolution escalation (on Evolution flagging a mismatch)

If Evolution returns `omega-diagram-mismatch: escalate to <role>`:

1. **Read the diagram file's `%% Author:` header** to confirm the original creator role (Strategist or Architect).
2. **Dispatch a fresh instance of that role** with these inputs:
   - The diagram file content
   - The relevant code excerpts that contradict it
   - Evolution's specific findings (which claim, which file:line)
   - Explicit question: "Is the diagram or the code correct here, and what is the resolution?"
3. **The dispatched role decides** — update the diagram, fix the code, or both. Their handoff returns the verdict with reasoning.
4. **Present the recommendation to the user** with the agent's reasoning. The user has the final say if the resolution requires a judgment call (e.g., the diagram captured an invariant the code violates, but the violation might be intentional).

The dispatched instance is a *fresh* invocation of the same role — not the original conversation. Treat it as a peer review by someone wearing the same hat.

**Note:** Solution is more important than its documentation. If a small diagram update keeps the documentation honest, do it; if the code is wrong because it diverged from the designed structure, fix the code. The Evolution-detect → original-role-decide → coordinator-execute loop ensures both options stay open.

## Handoff Contract

Each agent must return an explicit handoff message so the coordinator can audit the chain and the next agent can pick up without guessing:

- **Strategist → Architect:** target + context + build/test status + hypotheses (for diagnostic tasks) + any diagrams (mermaid source + filename + placement)
- **Architect → Implementer:** phased plan; when hypotheses exist, Phase 0 must be a diagnostic experiment + any diagrams (mermaid source + filename + placement)
- **Implementer → coordinator (after Phase 0):** raw diagnostic result + which hypothesis was confirmed or refuted
- **Implementer → Evolution:** what changed + diff summary + test output + diagnostic result if applicable
- **Evolution → coordinator:** verdict (proceed / halt / return to earlier agent) + whether the fix works for the right reasons + diagram-code consistency findings (if `.mmd` files exist) with `omega-diagram-mismatch: escalate to <role>` when a mismatch is found

Missing handoff fields are themselves a finding — send the output back and ask for the missing pieces rather than guessing.

## Lightweight Cycle (small tasks)

For small tasks (scope under roughly 3 files and 50 lines of change), the full four-agent cycle can be disproportionate. In that case:

- **Strategist and Architect may be combined into a single subagent dispatch** producing both the situation assessment and the plan.
- **The coordinator may take the Implementer role in the main conversation**, but must still follow TDD phasing (red → green → refactor, one step at a time).
- **Evolution must still run as a separate subagent** at the end. Quality assessment by the same agent that wrote the code is the exact blind spot this topology exists to prevent — never skip this step even on small tasks.

When in doubt whether a task is "small," run the full cycle. The cost of an unneeded Strategist pass is lower than the cost of a missed blind spot.

See GOODREASON.md for the full GoodReason meta-ontology reference.
