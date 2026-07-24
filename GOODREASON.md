# GoodReason Meta-ontology: A Compass for Thinking

**GoodReason** is a universal meta-ontology framework for systematic analysis of complex situations. It serves as a "compass for thinking" that can be used to analyze complex systems across any domain — business, technical, social, or geopolitical — to solve wicked problems and manage large-scale change.

The meta-ontology interprets a system through eight semantic anchors, examining their relationships and potential failure modes before they escalate into problems. Its core promise is to reduce blind spots by forcing attention to angles that human and AI reasoning alike tend to skip.

Canonical source: Eki Laitila, *Axiomatic Systems Science – Geometry of Thinking* (Journal of the ISSS, 70th Meeting, 2026). In that paper's terms the eight symbols are **semantic anchors** with compass directions — do not call them "dimensions" or "8D"; in GoodReason, *dimensions* (1D–8D) name a separate structure, the cognitive degrees of freedom.

---

## 1. Eight Semantic Anchors (Compass Points)

A system of interest is interpreted through eight semantic anchors — foundational roles, like cardinal directions in a coordinate system. Each symbol has a fixed position on the compass and a rich cluster of meanings — the Greek letters carry the semantics so that no single English word over-restricts the interpretation.

| Symbol | Name | Meaning | Position |
| --- | --- | --- | --- |
| **α (alpha)** | **Purpose** | Goals, values, mission, vision, aspirations, intent | North (N) |
| **π (pi)** | **Theory** | Models, logic, concepts, abstractions, design science | Northwest (NW) |
| **χ (chi)** | **Information** | Facts, environment, data, observations, operational reality, context | West (W) |
| **Δψ (delta-psi)** | **Transformation** | Change, change pressure, development, evolution, renewal, pending transitions | Southwest (SW) |
| **Ω (omega)** | **Feedback** | Monitoring, effects, measurement, goal-setting and goal-reaching, learning loops | South (S) |
| **τ (tau)** | **Implementation** | Implementation, practice, integration, coherence, impact | Southeast (SE) |
| **φ (phi)** | **Solution** | Solution, design, interface, R&D, possible responses | East (E) |
| **β (beta)** | **Structure** | Architecture, organization, hierarchy, how things are organized | Northeast (NE) |

Each symbol is a **semantic cluster**, not a single English word. When applying GoodReason:

- **χ (chi)** is much more than a facts file: it is everything observable about the environment and the operational reality — logs, measured facts, declared metadata, the state of the world as it actually is, as opposed to how it is claimed to be.
- **Δψ (delta-psi)** is not only change pressure but also change itself, ongoing transformation, declared-but-not-yet-executed renewal, and the delta between what is and what is becoming.
- **α (alpha)** spans values, mission, dream, goal, aspiration — what the system *wants* to be.
- **φ (phi)** is the designed response — the solution, design or interface that becomes possible. What is actually being *done* in practice belongs to τ.
- **τ (tau)** is praxis: implementation, practice and integration — where designed solutions meet operational reality.

Resist the habit of collapsing each symbol into a single keyword. The richness of the cluster is what makes the framework useful.

---

## 2. The 28 Pairwise Relationships — Where the Insight Lives

With 8 symbols there are exactly **C(8,2) = 28 unique pairs**:

```
α–β  α–χ  α–Δψ  α–π  α–φ  α–τ  α–Ω
     β–χ  β–Δψ  β–π  β–φ  β–τ  β–Ω
          χ–Δψ  χ–π  χ–φ  χ–τ  χ–Ω
                Δψ–π Δψ–φ Δψ–τ Δψ–Ω
                     π–φ  π–τ  π–Ω
                          φ–τ  φ–Ω
                               τ–Ω
```

**The core analytical discipline of GoodReason is to walk through all 28 pairs deliberately and patiently**, asking for each one: "how does X relate to Y in this specific system?" When you do this, opportunities, problems, dissonances and emergent phenomena surface that would otherwise remain unseen — precisely because both human thinking and AI-agent reasoning tend to default to a few habitual pairs (usually α–φ "goal vs action" or β–π "structure vs theory") and skip the rest.

**Skipping the 28-pair walk is the single most common way to get a shallow analysis that feels thorough but misses the actual leverage points.**

Concrete examples of non-obvious pairs that often carry the decisive finding:

- **χ–α (fact vs claim):** Do the observed operational facts contradict what the system says it is? E.g., a company whose stated value (α) is "privacy by design" while its χ shows 47 subprocessors and no DPIA — a χ–α interference.
- **Δψ–φ / Δψ–τ (declared change vs designed response vs active work):** Is pressure (Δψ) acknowledged without a designed response (φ) — or designed but never implemented (τ)? "We know we need to" ≠ "we have a solution" ≠ "we are doing it."
- **χ–Ω (reality vs measurement):** Is the system measuring (Ω) the things that χ actually shows are happening, or is it measuring comfortable proxies?
- **π–τ (model vs runtime practice):** Does the theoretical model (π) match how modules actually connect and run (τ) in practice?
- **Δψ–β (change pressure vs structure):** Will existing β survive the change pressure in Δψ, or will it crack?

**Triads (C(8,3) = 56)** deepen this further when needed: the cross-section of any three symbols sometimes reveals emergent phenomena that no pair captures alone. For example, α–χ–τ together surface "we say we want X (α), the facts show Y (χ), and we are actually doing Z (τ)" — a three-way tension that a pair-only analysis would split across multiple findings.

Start with pairs. Use triads when a pair-level finding has more depth than two symbols can express.

---

## 3. Relational Operators (Dynamics)

Relationships between symbols describe the system's movement, tension, and health. The operators below are not exhaustive — they are the most common ways a relationship can manifest.

| Operator | Meaning |
| --- | --- |
| **x (Resonance)** | Parts reinforce each other and operate in synchrony |
| **/ (Disconnection)** | Systemic blindness; parts are unaware of each other |
| **interference** | Friction or active conflict; parts wear each other down |
| **domination** | Destructive dominance; A completely overrides B (pathological) |
| **~ (Bridge)** | Emerging contact or loose coupling |
| **> (Priority)** | Controlled dominance (e.g., strategy guides implementation) |
| **=> (Transition)** | Evolutionary progression; A transforms into or produces B |
| **harmony** | Balanced and reciprocal state |
| **recursive** | Self-referencing process or feedback loop |

When walking the 28 pairs, label each relationship with the operator that best fits. "α x φ" reads as "purpose and solution are in resonance"; "χ interference α" reads as "facts are in active conflict with the stated goal".

---

## 4. Anchor Status

The "health" of each individual symbol can be assessed on a four-level scale:

1. **Absent** — The anchor is entirely missing from the system.
2. **Passive** — The anchor exists but has no effect on the whole.
3. **Distorted** — The anchor is present but corrupted or inauthentic.
4. **Active** — The anchor is healthy, authentic, and a vital part of the system.

A system can have every symbol nominally "present" and still fail badly if several are Passive or Distorted. Status assessment is done per symbol; pair analysis is done between symbols. Both are needed.

---

## 5. Usage Methods

### Systematic analysis (the 28-pair walk)

1. **Name the SOI, then state the MOI.** The **System of Interest (SOI)** is the raw target — what is being analyzed — and sits at the origin of the compass. The **MOI** is what the SOI becomes once you commit to an interpretation: why this system matters, to whom, and under which constraints. Every later judgment traces back to this SOI → MOI statement.
2. **Fill in each of the 8 symbols** for this system. What is its α? Its χ? Its current Δψ? Be specific. "chi-gap" ("this is not yet verified") is a legitimate answer and more useful than a fabricated one.
3. **Assess each symbol's status** (Absent / Passive / Distorted / Active).
4. **Walk all 28 pairs deliberately.** For each pair, name the operator and describe the relationship. Flag any interference, disconnection, or domination.
5. **Escalate to triads** (C(8,3) = 56) only for findings where two symbols are clearly insufficient to describe what is happening.
6. **Synthesize** — which findings matter most? What are the leverage points?

### Recursion

Each symbol can contain its own subsystem. For example, a project's β (structure) can be opened as its own GoodReason analysis, examining the internal α, π, χ, Ω, etc. of the structure itself. The same 8 symbols and 28 pairs apply at every level of recursion.

### Visualization

A GoodReason analysis is often best drawn as a diagram where nodes are symbols and arrows carry operators. This makes bottlenecks and "systemic leaks" visible at a glance, and it forces explicit decisions about which pairs carry findings.

### Agent topologies: projecting the compass onto agents

When GoodReason organizes a team of agents (human or AI), do **not** distribute the eight anchors as exclusive territories. Every agent instantiates the **full compass** — each is a complete G = (Mindset, Agency, Feedback) system, and the team is the same structure one holarchic level up. Three rules follow:

1. **Draw agent boundaries where context must differ, not where concepts differ** — independence of judgment (a verifier must not share the writer's context), parallelism (genuinely independent workstreams), or specialization. Boundaries are expensive: every one is a lossy handoff and a fresh context.
2. **Insight lives in the pairs**, so pairs must be resolved inside a single context or carried as explicit fields in handoffs. A topology that turns the 28 pairs into 28 inter-agent negotiations dismembers the observer.
3. **Authority is (anchor, ring)-scoped.** One agent *leads* an anchor (verdict authority) at a given process depth; others *consult and contribute* to it. (*Rings* — the 1–5 process-depth tiers — belong to the workflow binding, not to the ontology; see CLAUDE.md's Ring Selector.) Example: in the four-agent engineering topology, the Strategist *proposes* π — hypotheses and candidate theories — while the Architect holds the π *verdict*; at rings 1–2 the two roles merge into a single dispatch.

The four-agent topology in this repository (see CLAUDE.md) is one such projection, aligned with the workflow's control-transfer points rather than with the anchors themselves.

---

## 6. Common Failure Modes

When GoodReason analysis goes shallow, it almost always fails in one of these ways:

- **Habitual-pair defaulting.** The analyst walks α–φ, β–π, and maybe α–χ, then stops. Everything under Δψ, Ω, and τ is treated as "covered" without actually being examined.
- **Cluster collapse.** A symbol is reduced to a single keyword (χ becomes "facts.yaml only", Δψ becomes "change pressure only") and its richer semantic cluster is lost. The analysis then cannot see the things that only surface from the full cluster.
- **Static audit bias.** Every symbol is treated as a yes/no checklist rather than a live state with direction and velocity. This especially hurts Δψ (which is inherently dynamic) and χ (which has a time dimension — facts change).
- **Isolated symbol thinking.** Each of the 8 symbols is described in isolation; no pair analysis is done. The output reads like a well-organized list but carries zero insight, because insight lives in the relationships, not in the nodes.
- **Finding-pair mismatch.** A finding that belongs to one pair (e.g., χ–α interference) is recorded under a different pair (α–φ) because that is where the analyst was looking. The finding remains but it is misattributed, and subsequent action targets the wrong lever.

If an analysis does not explicitly walk all 28 pairs and does not explicitly assess each symbol's status, treat it as a first draft, not a finished analysis.

---

## 7. Why GoodReason?

- **Reduces blind spots** — forces you to look at things from eight different angles, and from twenty-eight different relationships, rather than the two or three habitual ones.
- **Common language** — provides precise vocabulary (symbols + operators + status) for communicating complex matters without the over-restriction of plain English.
- **Predictability** — helps see where Δψ (change pressure) will break β (structure) *before* it happens.
- **Domain-agnostic** — the same 8 symbols apply to a software system, a business, a team, a geopolitical situation, or a single decision, at any level of recursion.

---

> "GoodReason is not just a way to describe the world — it is a tool for changing the world in a controlled manner."
