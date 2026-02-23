# GoodReason Agent Topology for Claude Code

A systems-thinking framework that organizes [Claude Code](https://docs.anthropic.com/en/docs/claude-code) custom agents into four specialized roles with strict boundaries and coordinated workflows.

## What Is This?

Instead of one AI agent doing everything, GoodReason splits complex work across four agents — each governing a specific dimension of the problem:

| Agent | Dimension | Role | Tools |
|-------|-----------|------|-------|
| **Strategist** | Purpose + Information | Analyzes goals, verifies facts, prevents wasted effort | Read, Glob, Grep, Bash |
| **Architect** | Theory + Structure | Designs systems, defines interfaces, resolves conflicts | Read, Glob, Grep |
| **Implementer** | Action + Integration | Writes code, ensures it connects to the whole | Write, Read, Edit, Bash, Glob, Grep |
| **Evolution** | Feedback + Change | Runs tests, detects patterns, demands structural fixes | Bash, Read, Glob, Grep |

## Why Separate Agents?

Single-agent development tends to blur roles. The agent that writes code also evaluates it, leading to blind spots. GoodReason enforces separation of concerns:

- **Strategist** cannot write code — only validate goals
- **Architect** cannot write code — only design structure
- **Implementer** cannot assess quality — only build
- **Evolution** cannot fix code — only identify what's broken

This mirrors real engineering teams where architects don't code and QA doesn't design.

## The Workflow Cycle

```
Strategist ──> Architect ──> Implementer ──> Evolution
    ^                                           │
    └───────────────────────────────────────────┘
```

1. **Strategist** assesses the situation (what do we want vs. what exists?)
2. **Architect** creates a structural plan (how should it be built?)
3. **Implementer** writes the code (build it, integrate it)
4. **Evolution** tests and evaluates (does it work? what needs to change?)
5. Feedback flows back to the Strategist for the next iteration

The **main agent** (Claude Code itself) orchestrates this cycle, routing information between agents and preventing disconnections.

## Setup

### Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI installed
- A project you want to work on

### Installation

Copy the agent definitions and configuration into your project:

```bash
# Clone this repo
git clone https://github.com/villelaitila/goodreason-agents-setup.git

# Copy into your project
cp -r goodreason-agents-setup/.claude/agents/ your-project/.claude/agents/
cp goodreason-agents-setup/CLAUDE.md your-project/CLAUDE.md
cp goodreason-agents-setup/GOODREASON.md your-project/GOODREASON.md
```

Or simply copy the `.claude/agents/` directory and the two `.md` files into any existing project.

### Verify

Start Claude Code in your project directory. The agents will be available as sub-agents. You can verify by asking Claude to use the Strategist to analyze a goal, or the Evolution agent to run tests.

## Usage Example

```
You: "Add user authentication to this app"

Claude (main agent):
  1. Dispatches Strategist → analyzes auth requirements, checks existing code
  2. Dispatches Architect → designs auth module structure, defines interfaces
  3. Dispatches Implementer → writes the auth code, integrates with existing modules
  4. Dispatches Evolution → runs tests, identifies issues, suggests improvements
```

## Customization

### Adjusting Agent Models

Each agent definition includes a `model:` field. By default, all agents use `opus` for maximum capability. You can change this:

- Use `sonnet` for faster, cheaper agents (good for Implementer on routine tasks)
- Use `haiku` for quick checks (good for Strategist fact-checking)

### Adding Domain Knowledge

Add project-specific context to `CLAUDE.md`. The agents inherit this context and apply it through their respective lenses.

### Extending the Topology

You can add more agents following the GoodReason dimensions. See `GOODREASON.md` for the full meta-ontology with all eight dimensions.

## Background

GoodReason is a meta-ontology based on systems thinking. It divides any system into eight fundamental dimensions (purpose, theory, information, change, feedback, integration, action, structure) and provides operators to describe their relationships (resonance, disconnection, interference, etc.).

This agent topology uses four of these dimensions, paired into two complementary pairs per agent. See [GOODREASON.md](GOODREASON.md) for the complete framework.

## Battle-Tested

This topology was used to build [SecureOdoo](https://github.com/softagram/softagram-odoo-addons) — a 10-rule security scanner for Odoo with 99 tests passing on both Odoo 18 and 19. The four agents collaboratively produced ~3000 lines of production code across 6 modules.

## License

MIT

## Author

Ville Laitila / [Softagram Oy](https://softagram.com)
