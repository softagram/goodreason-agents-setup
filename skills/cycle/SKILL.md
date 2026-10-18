---
name: cycle
description: Run the full GoodReason workflow cycle (Strategist -> Architect -> Implementer -> Evolution) on a task. Use when tackling complex engineering tasks that benefit from structured analysis, design, implementation, and verification.
---

# GoodReason Workflow Cycle

Execute the full four-phase GoodReason workflow on the following task: "$ARGUMENTS"

Follow this cycle strictly:

## Phase 0: Intake (coordinator)
- Frame the SOI: what system is selected, why it matters, to whom
- Classify the task's ring (1–5) per CLAUDE.md's Ring Selector and state the ring in every dispatch brief
- Ring 1–2 → lightweight path (Strategist+Architect combined into one dispatch; Evolution still mandatory)
- Before the first dispatch, complete **Coordinator preparation** in the
  [dispatch contract](dispatch-contract.md)
- Every dispatch brief carries its filled-in shared block and matching role-specific addition. Do not
  retype its rules from memory; one is dropped every time

## Phase 1: Analysis (Strategist)
Use the **Strategist** agent to:
- Analyze the goal (alpha) in relation to the current codebase reality (chi) — verify facts by reading before claiming
- Name the change pressure that created the task (delta-psi intake)
- Diagnostic tasks: produce at least 3 competing hypotheses with falsification criteria
- Ring 3+: produce a theory shortlist (applicable external theories / prior art / failure patterns, tagged for alpha-relevance and chi-consistency)
- Identify any alpha/chi interference (goal conflicts with reality)
- Treat every citation in the input (report, ticket, prior handoff) as a hypothesis: verify the call
  path that produces the symptom, not only that the cited symbol exists
- When the task splits into independent parts, run one narrow Strategist per part in parallel; they
  are cheap (short context, short life) and they find shared ground by disagreeing with each other

**Gate A (coordinator):** check alpha x pi (does the proposed theory serve the SOI framing?) and chi x pi (do the facts support it?) before passing to the Architect.

## Phase 2: Design (Architect)
Use the **Architect** agent with the Strategist's analysis to:
- Record theory verdicts (adopt / adapt / refute each proposed item)
- Create a structural plan (pi => beta) with explicit interfaces and a test plan
- Group phases into milestones with scope envelopes and autonomy budgets; include Phase 0 as a diagnostic experiment when hypotheses exist
- Produce a plan the Implementer can follow without guessing
- Pre-register per-phase acceptance deltas **and the fixture that produces them**; label tests that
  cannot be red on the base as guards, not regression tests
- Propose a default for every open question so the coordinator answers by exception

**Gate B (coordinator):** check delta-psi x beta (does the structure survive the pressure?) and phi x tau (are integration points concrete?) before dispatching the Implementer.

## Phase 3: Implementation (Implementer)
Use the **Implementer** agent per milestone:
- Complete the tau-checkpoint (plan exists, interfaces known, integration points clear, error handling defined)
- Autonomous mode (ring ≤3): run red → green → refactor per step, keep the Step Log, stop only on tripwires
- Strict mode (ring 4+): stop after each red and each green phase
- Phase 0 always returns to the coordinator for the hypothesis verdict
- Report any technical constraints discovered (phi => chi)
- A "check passed" claim carries the command and one line of real output; the coordinator does not
  relay one without them
- Never `git stash` in a shared-repository worktree

## Phase 4: Verification (Evolution)
Use the **Evolution** agent at each milestone and pre-commit (ring ≤3) or after each phase (ring 4+):
- Run tests and verify the fix works for the right reasons (omega recursive)
- Audit test quality from the Step Log (write-order, spec-shaped vs code-shaped tests)
- Verify diagram-code consistency when diagrams exist
- Check harmony with original purpose (omega ~ alpha)
- Identify any change pressure (delta-psi) for future iterations
- Mutation-check the tests (remove each guard clause on a copy, name the failing test) and report
  the surviving mutants as required tests for the next milestone
- Ask about side effects, not only behaviour: new log lines, import-time prints, new warnings
- End-to-end on real data: when the change alters produced output (models, reports, exports, API responses) and the ring is 3 or higher, run the real thing against the base at least once per branch and
  diff the result sets; fixtures do not contain the shapes that break a correct-looking design. For a
  change with no runtime output (docs, agent instructions, config), name the acceptance check that
  applies and have Evolution run that instead

**Gate C (coordinator):** check omega x alpha (did we solve the thing that mattered, not merely pass tests?) and chi x phi (does the realized solution meet observed reality, not only the plan?).

Read Evolution's final report to the end before writing PR text; a defect can sit in the last bullet.

## Agent retirement (coordinator)
Stop each subagent as soon as its handoff is verified and recorded, in the same turn, unless its next
phase is already queued for it:
- An Implementer whose phase is committed gets either the next queued phase or a stop. Release the
  next phase only after the previous one is verified and committed: an agent that starts editing while
  the coordinator verifies puts half-finished work into the commit. Commit only the files named in the
  handoff (never `git add -A` on a worktree an agent may still touch), and only after the agent has
  confirmed it stopped editing; re-run the suite if anything changed since the verification run.
- Reviewers and one-off agents (Architect plans, reference pulls, measurements) are stopped as soon as
  their report is saved; their findings live in the spec, not in the agent.
- Before stopping, make sure the agent's output is on disk (handoff file, report): a stopped agent
  cannot be asked to resend a truncated message.

Long multi-phase work otherwise accumulates idle agents that cost resources and blur who owns what.

After all phases, summarize the cycle results and any remaining delta-psi (change pressure) for the next iteration.
