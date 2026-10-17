# Dispatch contract

The block below is pasted, filled in, at the top of **every** agent dispatch in a GoodReason cycle.
It exists because the coordinator retyping these rules from memory drops one each time: in the
2026-09-23 four-defect run the `git stash` ban and the line-length limit were both missing from
the first Implementer prompt and had to be added in the second.

## Coordinator preparation

Both `cycle` and `cycle-review` use this preparation before the first dispatch:

- Create the worktree (`~/worktrees/<branch>/`, never `/tmp`) with its venv or toolchain, and declare
  the main checkout read-only.
- Measure the baseline as *command + branch + count*, and identify the repo's lint config and limits.
  For changes with no runtime output, name the applicable acceptance check in the brief.
- Name a scratch directory per agent.
- Decide the coding budget: an Evolution nit of at most ten lines may be applied by the coordinator,
  with a test run; everything else returns to the Implementer.

## Shared dispatch block

Fill the `<…>` slots. Delete nothing; if a rule does not apply, say so in the slot.

```
## Environment
- Work ONLY in <worktree path> (branch <name>, based on <upstream ref> <sha>). It has a working <venv/toolchain>.
- <main checkout path> is READ-ONLY. Do not grep callers there: untracked files invent call sites.
- Your scratch directory is <scratch root>/<agent name>/ — create it. Reports, logs, probes and
  experiments go there. Product code and permanent tests go to the paths the plan names, in the worktree.
- Never `git stash` in any worktree of this repository. The stash list is shared across worktrees; a failed
  push followed by a pop applies another branch's work. Compare against `git show HEAD:<path>` copies instead.
- Commit only if this brief says so. Default: the coordinator commits after Evolution's verdict.
- Run tests with: <exact command>. Baseline measured by the coordinator: <command> → <N passed, M skipped>.
- Lint config is <path, e.g. .flake8>: <the limits that matter, e.g. max-line-length 100>. Keep every new or
  changed line inside them.
- Siblings: <names of agents running in parallel and what they own>. When you find shared ground and
  SendMessage is available to you, settle it with the sibling directly; otherwise report it to the
  coordinator, who relays. Either way, write the agreed points as an addendum to your own report.

## Evidence
- A claim that a check passed carries the command and one line of its real output. An empty diff between
  two tool outputs proves nothing if both are the same error message. Do not claim a check you did not run.
- Mark every claim [M] measured (you ran or read it at the cited line) or [I] inferred.
- Report where reality differed from the plan as its own section. Do not absorb the difference.

## Handoff
- If you have a Write or Bash tool, write the full report to <scratch root>/<agent name>/<file>.md; it is
  readable the moment it is written, while your final message may arrive hours later. Your final message
  is then a summary of at most 40 lines that points at the file.
- If you have no way to write files (the Architect, by definition), your final message IS the full
  report and has no length cap; the coordinator saves it to the scratch directory.
- Report once. Standard cycle: the final message is delivered by the harness, so do not also send it
  through SendMessage. Team mode: report to `team-lead` through SendMessage as its onboarding says, and
  do not also expect the final message to be read. The brief says which mode this is: <mode>.
- Report exact line counts (`wc -l`) and `git diff --stat` for anything you changed. A later foreign edit
  to an untracked file is only detectable against that number.
```

## Role-specific additions

Append the matching block after the shared block.

### Strategist

```
## Gate 0
1. Confirm the baseline above for the areas you touch. If you share the worktree with siblings, identify
   the test runner first: for pytest, disable its cache provider with `-p no:cacheprovider`; for other
   runners, use their supported isolation options. If shared mutable state cannot be isolated,
   coordinate serial runs. A failure that passes when re-run alone stays an observation; record
   "contention" as one hypothesis beside order dependence and a real timing bug, and close it only
   after controlled re-runs (same set, alone, and on the base) agree.
2. Verify every code claim in the input (report, ticket, prior handoff) against the code with file:line.
   Treat each citation as a hypothesis: confirm the *call path* that produces the symptom, not only that
   the cited function exists.
3. When the task has a reported symptom, reproduce its mechanism on a synthetic fixture with the real
   code, and state which of the reported instances the fixture reproduces and which it does not.

## Deliver
- For diagnostic tasks, competing hypotheses (≥ 3) for cause and fix locus per the Hypothesis Protocol,
  each with evidence, falsification and the cheapest test. Other tasks: the goal assessment format.
- Every code path that can produce the symptom, not only the one the report names.
- Existing tests that pin adjacent behaviour, and what a regression test must pin.
- α check: the minimum that satisfies the consumer of this fix, and what is a follow-up.
```

### Architect

```
## Plan
- Commit order with the conflict analysis for every shared region; when two phases edit one function,
  the earlier phase carves the seam and the later fills it, and you name the test that must fail if the
  seam is removed.
- Per phase: characterization tests (green on base), regression tests (red on base), fix (green). For each
  regression test say whether it CAN be red on base; a test that cannot is a guard against the wrong fix,
  label it as one.
- Pre-registered acceptance deltas AND the fixture that produces them. A delta the fixture cannot show is
  a prediction nobody can check.
- Test commands and expected counts; tests read only paths the test image mounts.
- For every open question, propose a default so the coordinator answers by exception.
```

### Implementer

```
## Per phase (report evidence for each)
1. Planned characterization tests → run on base → GREEN, with their purpose, command, output and count.
2. Regression tests → run → RED, quoting the failing assertion. A test the plan labelled as a guard is
   expected green on base; record its label, purpose and baseline command/output, then continue.
   A test the plan expected red that is green on base is an unexpected green: a tripwire.
   Stop, report what the test executed and asserted, and wait. It may
   be a wrong fixture, a wrong call path or a weak assertion, and renaming it a guard settles none of those.
3. Fix → run → GREEN; then the full sets from the contract.
4. Mutation-check your own guards before handoff: remove each clause on a copy, name the test that fails,
   restore and verify with `cmp`. Evolution then verifies instead of discovering.
5. Read the repo's real lint config before claiming lint results, and cite it.
In autonomous mode (ring ≤ 3) run the steps without returning; the Step Log carries the same evidence.
Do not combine steps into one edit.
```

### Evolution

```
## Assess
1. Right fix for the right reason: does the mechanism match what the Strategist measured?
2. Tests: on a scratch copy of the base with only the tests applied, regression tests must be red;
   planned guards and characterization tests must be green, with their purpose and baseline
   command/output recorded. An unexpectedly green regression test is a tripwire, not a guard to relabel.
   Mutate each guard; report the mutations no test catches as required tests for the next phase.
3. Disconnections between goal, plan, code and claims. Verify every "passed" claim from its command and
   output; a claim without output is unverified.
4. Side effects, not only behaviour: new log lines, import-time prints, new warnings, changed exit codes,
   resource use. (A logger misconfiguration survived three behaviour-only reviews on 2026-09-23.)
5. End-to-end on real data: when the change alters produced output (models, reports, exports, API responses) and the ring is 3 or higher, run the real thing against the base at
   least once per branch and diff the result sets; the only design flaw in the 2026-09-23 branch was
   visible only on a real repository. For a change with no runtime output (docs, agent instructions,
   config), run the acceptance check the brief names instead. Same condition as the cycle skill's Phase 4.
6. Put must-fix items first. Anything that is a defect, however small, is an item, not a footnote.
Verdict: CONTINUE / FIX-FIRST (exact list) / RETURN-TO-<role>.
```
