# GoodReason Agent Topology (v2)

This project uses the GoodReason meta-ontology for managing software engineering tasks. Process ceremony scales with the task's **ring** (interpretation depth) — see the Ring Selector below.

## Two Layers: Control Plane and Domain Binding

This document mixes two layers, and they age differently:

- **Control plane (domain-neutral):** the Ring Selector, verdict authority, the Disconnection Audit gates, the handoff contract, milestones with autonomy budgets, the Step Log, and Evolution as an independent verifier. These follow from the ontology and apply to any productive work — software, research, operations, writing.
- **Software binding (this repository's default):** TDD phasing, Gate 0 build/test pre-checks, probe tests, diff-based verification. These instantiate the control plane for software engineering.

To apply the topology to non-software work, keep the control plane and re-bind the software terms. The mapping is usually direct: red-before-green becomes *prediction before observation* (preregistration discipline), a probe test becomes a pilot experiment or a source check, "the build is green" becomes "the material is accessible and the method runs", and Evolution's "does the fix work for the right reasons" becomes an internal-validity check.

## Agents

Use the sub-agents defined in `.claude/agents/`:

1. **Strategist (alpha x chi):** When analysis of goals or current state is needed. Leads alpha and chi; owns the SOI framing (why it matters, to whom) and delta-psi intake; *proposes* theory (hypotheses; theory shortlist at ring 3+).
2. **Architect (pi x beta):** When designing logic or structure. Holds the pi verdict (adopts/adapts/refutes proposed theories); the phased plan is beta applied to the work itself.
3. **Implementer (phi x tau):** When shaping (phi) and realizing (tau) code.
4. **Evolution (omega x delta-psi):** When verifying quality and assessing change pressure. Never merged with the writer.

Every agent holds the full compass; the pairs above define **verdict authority**, not thinking limits. See GOODREASON.md → "Agent topologies: projecting the compass onto agents".

## Workflow Protocol (Cycle)

1. **Intake (coordinator):** Frame the SOI (what system, why it matters, to whom) and classify the ring.
2. **Analysis (Strategist):** Situation assessment + delta-psi intake + hypotheses (diagnostic) or theory shortlist (ring 3+). May produce alpha-x-chi diagrams.
3. **Design (Architect):** Theory verdicts + phased plan with milestones, scope envelopes and autonomy budgets. May produce pi-x-beta diagrams.
4. **Implementation (Implementer):** Milestone-sized dispatches with step autonomy (ring ≤3) or strict phasing (ring 4+).
5. **Verification (Evolution):** At milestone boundaries and pre-commit (ring ≤3) or after each phase (ring 4+); verifies any diagrams still match the implemented code.

The cycle is deliberately **Strategist-first**: whatever the task's strongest signal (an incident, an idea, an anomaly, external pressure), entry goes through the alpha-x-chi pass first. The ontology does not force an order — this binding does, as a safety property that is worth its token cost.

The main agent's job is to coordinate information flow, run the **Disconnection Audit** at each gate, and ensure no **Disconnections** occur.

## Ring Selector (proportional ceremony)

Classify the task at intake by the depth of interpretation the work demands. State the ring in every dispatch brief.

| Ring | Task profile (signals) | Process |
|------|------------------------|---------|
| **1–2** | Mechanical/trivial: cause known, roughly ≤3 files / ≤50 lines, easily reversible | Lightweight: Strategist and Architect combined into one dispatch (or coordinator-inline analysis); the coordinator may take the Implementer role in the main conversation but must follow TDD phasing; **Evolution always runs as a separate subagent before commit — never skipped** |
| **3** | Standard feature or bugfix: tension visible, bounded scope, moderate blast radius | Full four-agent cycle; milestone-sized Implementer dispatches with step autonomy; Evolution at milestones + pre-commit |
| **4** | Critical threshold: unclear cause, state/concurrency/integration boundaries involved, hard-to-reverse changes | Full cycle + hypothesis gate + Phase 0 + **strict mode** (per-phase stops); Evolution after each phase |
| **5** | Transformation: architectural change, migrations, cross-cutting rewrites | Ring 4 + human review gate (use the cycle-review flow) + diagrams required + elastic specialists (pi-researcher, adversarial omega-panel) |

- **Default when in doubt: ring 3.** The cost of one unneeded Strategist pass is lower than a missed blind spot.
- **Escalate one ring on delta-psi evidence:** 2+ phi-stuck activations within the task; an Evolution halt verdict; a second refuted hypothesis; scope growth beyond the plan envelope.
- **De-escalate** at most one ring, and only at a milestone boundary with a clean Evolution verdict.

## Role Isolation (Strict)

The main agent (Claude Code) is a **coordinator and delegator** and may do hands-on work only where the Ring Selector explicitly allows it (ring 1–2 implementation) or in clearly exceptional situations.

- **Strategist, Architect, Implementer and Evolution are always subagents.** Respect their role boundaries. If a subagent appears to use shallow reasoning or an obviously weak approach, report it to the human rather than silently taking over.
- **If subagent execution is not permitted in the current environment, ask the human how to proceed** rather than quietly absorbing the work into the main conversation.
- **Allowed for the coordinator:** routing information between agents, maintaining the task list, user communication, read-only context gathering (search, graph queries, reading files to brief subagents), running test suites to verify reported results, and ring classification.
- **Not allowed for the coordinator without an explicit exception:** writing code (outside ring 1–2), redesigning structure, or making quality verdicts. Those belong to the agents.

## Coordinator Discipline

The coordinator is responsible for pacing. Speed must not override process — but ceremony must not exceed the ring.

### Hypothesis Gate (diagnostic tasks)

When the task involves diagnosing a problem (bug, unexpected behavior, unclear failure):

1. **Strategist must produce hypotheses** — not just an assessment. If the Strategist returns a single explanation without alternatives, send it back: "Provide competing hypotheses per protocol."
2. **Architect must include Phase 0 (diagnostic)** in the plan. If the plan jumps straight to a fix without validating the hypothesis, send it back.
3. **After Implementer runs Phase 0:** Read the diagnostic result yourself. Decide:
   - Hypothesis confirmed → proceed to fix phases
   - Hypothesis refuted → return to Strategist with new evidence, or test next hypothesis
   - Unexpected result → pause and reassess with Strategist
4. **Do NOT let the Implementer proceed from Phase 0 to Phase 1 autonomously — at any ring.** The coordinator makes this decision.

**When to skip the hypothesis gate:** Only when the cause is mechanically trivial (typo, missing import, compiler error pointing to exact line). State why you're skipping.

### Disconnection Audit (at every gate)

At each control transfer, check the load-bearing pairs — one sentence of reasoning each. If a check fails, return the handoff to the owning agent, naming the pair. The gates deliberately cover the compass's opposition diameters — alpha–omega and chi–phi at Gate C, delta-psi–beta at Gate B — while the fourth diameter, pi–tau, runs as a standing channel (the Implementer's plan-wrong escalation and the diagram–code checks). See GOODREASON.md → "Agent topologies".

- **Gate A — Strategist → Architect:** *alpha x pi* — does the proposed theory/hypothesis set serve the SOI framing? *chi x pi* — do the verified facts actually support it?
- **Gate B — Architect → Implementer:** *delta-psi x beta* — will the planned structure survive the pressure that motivated the task? *phi x tau* — are integration points concrete enough to realize without guessing?
- **Gate C — Evolution → close:** *omega x alpha* — does the verdict trace back to the SOI framing? Did we solve the thing that mattered, not merely pass tests? *chi x phi* — does the realized solution meet observed reality (real inputs, real environment), not only the plan?

### Pacing Rules — ring ≤3 (autonomy with tripwires)

- **Dispatch the Implementer in milestone-sized units** as defined in the Architect's plan (not single micro-steps, not the whole plan).
- Within a dispatch, the Implementer runs red → green → refactor per step **without returning between steps**, maintaining a Step Log. It hard-stops only on tripwires: a phi-stuck trigger, budget exhaustion (default 3 attempts per step), an unexpected green, tests cannot run, scope envelope exceeded, or Phase 0 completion.
- **At each milestone:** run the test suite yourself (Bash) and verify the output matches the Implementer's report, then dispatch Evolution with the diff and the Step Log.
- **Checkpoints are reports, not gates.** Read the Step Log; intervene only when a tripwire fired or the log shows a violation (e.g., implementation written before its test).

### Pacing Rules — ring 4+ (strict mode)

- One phase per Implementer dispatch. The Implementer stops after each red phase and each green phase and awaits confirmation.
- Run tests yourself between phases and verify output before proceeding.
- Dispatch Evolution after each Implementer return, not just at the end.
- Do not combine multiple phases into a single Implementer dispatch.

**Gate rule (all rings):** If the Implementer reports it cannot run tests, do NOT dispatch further work. Fix the blocker first.

### Known Tradeoff: autonomy vs. per-step oversight

v1 required a synchronous stop after every red and every green phase — roughly three agent spawns per TDD step. v2 trades that oversight for throughput at ring ≤3 (one spawn per milestone plus exceptions). The safety the stops provided is preserved by other means:

- The **Step Log** preserves auditability: verbatim red/green evidence per step lets Evolution audit write-order and test quality after the fact.
- **Tripwires** stop the Implementer at exactly the moments the old protocol was designed to catch — anomalies, budget exhaustion, broken foundations.
- **Strict mode at ring 4+** keeps full per-phase pacing where mistakes are expensive.

Two gates earn their latency at every ring and must never be collapsed: **Phase 0 verdicts** (the coordinator decides, always) and **Evolution as a separate verifier** (even at ring 1–2). Quality assessment by the agent that wrote the code is the exact blind spot this topology exists to prevent.

## Elastic Specialists (spawn along independence boundaries)

The standing topology stays at four agents. Spawn additional agents only where independence, parallelism, or specialization earns the context cost. Specialists report to the anchor's lead agent and carry **no verdict authority**:

- **pi-researcher** (ring 4+, or on Strategist request): a parallel research dispatch into prior art, external theories, and known failure patterns; its findings feed the Strategist's theory shortlist.
- **Parallel probe-runners:** when phi-stuck hypotheses H1/H2/H3 have independent probes, run them concurrently instead of serially.
- **Adversarial omega-panel** (ring 5 / critical changes): 2–3 fresh Evolution instances instructed to *refute* the fix; a majority refutation is a halt verdict.

Never create standing one-anchor agents. Insight lives in the pairs, and pairs must be resolved inside a single context or carried as explicit handoff fields — a topology of eight anchor-silos dismembers the observer.

## Diagram Protocol

Strategist and Architect may produce mermaid diagrams as part of their handoff when the situation warrants externalizing the model. Each agent decides whether a diagram adds value — diagrams are not mandatory for every cycle, but when they exist they become part of the project's permanent documentation.

### Coordinator's role: writing the diagram files

Strategist and Architect produce diagram **content** in their handoff (mermaid source + suggested filename + suggested placement). They do **not** write files themselves — that preserves their alpha-x-chi / pi-x-beta role boundaries (analysis and design, not realization).

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

- **Strategist → Architect:** SOI framing (why this matters, to whom) + delta-psi intake (what pressure created the task) + target + context + build/test status + hypotheses with falsification criteria (diagnostic tasks) + **theory shortlist** (ring 3+: applicable external theories / prior art / failure patterns, each tagged for alpha-relevance and chi-consistency) + any diagrams (mermaid source + filename + placement)
- **Architect → Implementer:** phased plan with **milestone boundaries, scope envelopes and autonomy budgets** + **theory verdicts** (each proposed item adopted / adapted / refuted, with a one-line reason) + Phase 0 as a diagnostic experiment when hypotheses exist + test plan + any diagrams (mermaid source + filename + placement)
- **Implementer → coordinator (after Phase 0):** raw diagnostic result + which hypothesis was confirmed or refuted
- **Implementer → Evolution:** what changed + diff summary + **Step Log** (per step: test written → red evidence → implementation → green evidence) + tripwire events + test output + diagnostic result if applicable
- **Evolution → coordinator:** verdict (proceed / halt / return to earlier agent) + whether the fix works for the right reasons + **test-quality audit** (write-order, spec-shaped vs code-shaped) + diagram-code consistency findings (if `.mmd` files exist) with `omega-diagram-mismatch: escalate to <role>` when a mismatch is found + delta-psi report

Missing handoff fields are themselves a finding — send the output back and ask for the missing pieces rather than guessing.

See GOODREASON.md for the full GoodReason meta-ontology reference.
