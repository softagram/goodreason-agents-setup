# GoodReason Agent Topology for Claude Code

A systems-thinking framework that organizes [Claude Code](https://docs.anthropic.com/en/docs/claude-code) custom agents into four specialized roles with strict boundaries and coordinated workflows.

## What Is This?

Instead of one AI agent doing everything, GoodReason splits complex work across four subagents — each governing a specific dimension of the problem:

| Agent | Dimension | Role | Tools |
|-------|-----------|------|-------|
| **Strategist** | Purpose + Information | Verifies build/test foundations, generates competing hypotheses for diagnostic tasks, flags goal/reality conflicts | Read, Glob, Grep, Bash, SendMessage |
| **Architect** | Theory + Structure | Designs structure and interfaces; when hypotheses exist, designs a diagnostic experiment (Phase 0) before a fix | Read, Glob, Grep, SendMessage |
| **Implementer** | Action + Integration | Writes code under strict TDD phasing; when stuck, uses the phi-stuck protocol with probe tests instead of grinding | Write, Read, Edit, Bash, Glob, Grep, SendMessage |
| **Evolution** | Feedback + Change | Runs tests, verifies the fix works for the right reasons, flags causal-mismatch and unverified-mechanism risks | Bash, Read, Glob, Grep, SendMessage |

## Why Separate Agents?

Single-agent development blurs roles. The agent that writes code also evaluates it, which produces blind spots. GoodReason enforces separation of concerns:

- **Strategist** cannot write code — only validate goals and gather facts
- **Architect** cannot write code — only design structure and diagnostic experiments
- **Implementer** cannot assess quality — only build
- **Evolution** cannot fix code — only identify what is broken and why

This mirrors real engineering teams where architects don't code and QA doesn't design.

## The Workflow Cycle

```
Strategist ──> Architect ──> Implementer ──> Evolution
    ^                                           │
    └───────────────────────────────────────────┘
```

1. **Strategist** assesses the situation (what do we want vs. what exists?)
2. **Architect** creates a structural plan (how should it be built?)
3. **Implementer** writes the code under TDD discipline
4. **Evolution** tests and evaluates (does it work, and for the right reasons?)
5. Feedback flows back to the Strategist for the next iteration

The **main agent** (Claude Code itself) acts as **coordinator**: routing information between subagents, pacing the cycle, and preventing the disconnections that arise when a single agent both writes code and judges its own work.

## Installation

### Primary: install from the Softagram marketplace (recommended)

```
/plugin marketplace add softagram/claude-plugins-marketplace
/plugin install goodreason@softagram-plugins
```

Once installed, the plugin loads automatically in every Claude Code session — no per-session flags, no manual file copies. You get:

- Four subagents via `/agents`: Strategist, Architect, Implementer, Evolution
- Workflow skills: `/goodreason:cycle`, `/goodreason:cycle-review`, and `/goodreason:cycle-team`
- The GoodReason ontology reference as an on-demand skill

Run the full cycle on any task:

```
/goodreason:cycle Add rate limiting to the public API
```

**Team mode** (`/goodreason:cycle-team`) runs the same cycle, but keeps the four agents alive as a named team for its whole duration. They retain context across phases and ask each other direct clarifying questions via `SendMessage` — instead of being re-spawned fresh each phase — while the coordinator still owns phase transitions and the gates.

### Alternative: `--plugin-dir` (useful for development)

Clone the repo and point Claude Code at it directly. This is the right path when you are modifying the plugin itself, or when you cannot use a marketplace.

```bash
git clone https://github.com/softagram/goodreason-agents-setup.git
cd your-project
claude --plugin-dir /path/to/goodreason-agents-setup
```

You will need to pass `--plugin-dir` on every session unless you configure it in your Claude Code settings.

### Alternative: fork and adapt to your project

If you want to customize the agents — change their tool permissions, rewrite the principles, or integrate project-specific rules into the prompts — fork the repo and adapt it. This is a first-class use case, not a workaround.

```bash
git clone https://github.com/softagram/goodreason-agents-setup.git my-project-agents
# Edit .claude/agents/*.md, CLAUDE.md, and GOODREASON.md as you see fit.
# Then either publish your fork as a plugin, or copy the files into your
# project's .claude/agents/ directory.
```

Note: `.claude/agents/` and root-level `agents/` must stay byte-identical if you plan to re-publish as a plugin — see **Contributing** below.

## Usage Example

```
You: "The profile page occasionally shows stale data after a user updates their email."

Claude (main agent):
  1. Dispatches Strategist → feature-first comprehension, ≥3 competing hypotheses
     for the stale-data symptom with falsification criteria
  2. Dispatches Architect → designs Phase 0 diagnostic experiment to pick between
     hypotheses; holds off on fix design until the cause is confirmed
  3. Dispatches Implementer → runs Phase 0, reports raw result; after coordinator
     confirms the cause, writes tests first (red), then the fix (green), one step
     at a time
  4. Dispatches Evolution → verifies the fix addresses the confirmed root cause,
     not just the observed symptom; flags any causal-mismatch risk
```

## Customization

### Adjusting agent models

Each agent file's front matter includes a `model:` field. All four default to `opus` for maximum capability. You can change this per agent:

- `sonnet` — faster and cheaper; often fine for Implementer on routine tasks
- `haiku` — quickest; reasonable for Strategist fact-checking on small scopes

### Adding domain knowledge

Put project-specific context in your project's `CLAUDE.md`. The subagents inherit that context and apply it through their respective lenses. The coordinator discipline rules live in this repo's `CLAUDE.md` and are what produce the topology's behavior.

### Extending the topology

The full meta-ontology has eight dimensions, not four. You can add more subagents following the remaining pairs. See [GOODREASON.md](GOODREASON.md) for the 28 pairwise relationships and dimension health model.

## Contributing

Agent definitions live in two places that must stay byte-identical:

- `agents/` — read by the Claude Code plugin loader (marketplace installs, `--plugin-dir`)
- `.claude/agents/` — read by Claude Code when users copy the setup into their own project

A CI check (`.github/workflows/agents-drift-check.yml`) fails any PR that lets them drift. Run it locally before committing:

```bash
bin/check-agents-drift.sh
```

If you change an agent definition, edit one copy and mirror it to the other. The script will tell you which direction it needs.

## Background

GoodReason is a meta-ontology based on systems thinking. It divides any system into eight fundamental dimensions (purpose, theory, information, change, feedback, integration, action, structure) and provides operators to describe their relationships (resonance, disconnection, interference, bridge, priority, transition, harmony, recursive feedback).

This agent topology uses four of those dimensions, paired into two complementary pairs per agent. See [GOODREASON.md](GOODREASON.md) for the complete framework.

## Battle-Tested

This topology was used to build SecureOdoo (to be published) — a 10-rule security scanner for Odoo with 99 tests passing on both Odoo 18 and 19. The four agents collaboratively produced ~3000 lines of production code across 6 modules.

## License

MIT

## Author

Ville Laitila / [Softagram Oy](https://softagram.com)
