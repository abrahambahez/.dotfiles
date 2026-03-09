#!/usr/bin/env bash
# setup-coding-project.sh
# RPI-SDD architecture scaffold for agent-first software projects
# usage: bash setup-coding-project.sh [project-name] [project-dir]
# example: bash setup-coding-project.sh bibref ~/projects/bibref

set -euo pipefail

usage() {
  echo "usage: init-coding <project-name> [project-dir]"
  echo "       init-coding --reset [project-dir]"
  echo "       init-coding bibref ~/projects/bibref"
  echo ""
  echo "scaffolds an RPI-SDD agent-first project structure"
  echo ""
  echo "options:"
  echo "  --reset [dir]  remove all files and dirs created by this script"
}

reset_scaffold() {
  local dir="${1:-.}"
  echo "resetting scaffold in $dir"
  rm -rf \
    "$dir/docs" \
    "$dir/specs" \
    "$dir/evals" \
    "$dir/.claude" \
    "$dir/CLAUDE.md" \
    "$dir/feature_list.json" \
    "$dir/claude-progress.txt" \
    "$dir/init.sh" \
    "$dir/.gitignore"
  echo "reset complete"
}

if [[ $# -eq 0 || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

if [[ "${1:-}" == "--reset" ]]; then
  reset_scaffold "${2:-}"
  exit 0
fi

PROJECT_NAME="$1"
PROJECT_DIR="${2:-.}"

echo "scaffolding $PROJECT_NAME in $PROJECT_DIR"
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

# ── directory structure ────────────────────────────────────────────────────────

mkdir -p \
  docs/adr \
  docs/feats \
  specs \
  evals/golden \
  evals/results \
  .claude/skills/spec-writer \
  .claude/skills/reviewer \
  .claude/skills/eval-judge \
  .claude/skills/design \
  .claude/agents \
  .claude/skills/init \
  .claude/skills/research \
  .claude/skills/spec \
  .claude/skills/task \
  .claude/skills/review \
  .claude/skills/eval \
  .claude/skills/adr

# ── CLAUDE.md ─────────────────────────────────────────────────────────────────

cat > CLAUDE.md << 'HEREDOC'
# [PROJECT_NAME]
# FILL IN: replace [PROJECT_NAME] with your project name
# then fill in each section below. Claude Code will read this at every session start.

## stack
# FILL IN: list your actual stack, one item per line
# example:
# - language: Python 3.12
# - cli framework: Typer
# - llm: Anthropic SDK (claude-sonnet-4-6)
# - testing: pytest
# - package manager: uv
- language:
- framework:
- testing:
- package manager:

## commands
# FILL IN: the exact shell commands to run each task
# Claude will use these — they must work in your project root
- dev:
- test:
- build:
- lint:
- lint-fix:

## workflow
This project uses RPI-SDD workflow.

Session startup (mandatory, every session):
1. Read claude-progress.txt to understand last session state
2. Read feature_list.json and identify highest-priority feature with passes: false
3. Run init.sh to confirm the environment is healthy
4. Only then begin work

Before implementing any non-trivial feature:
1. Write or iterate docs/feats/[feature].md (your design thinking)
2. Run /design [feature] if you want feedback on your thinking (optional)
3. Run /research [feature] to map blast radius
4. Run /spec [feature] to produce acceptance criteria and task DAG
5. Get explicit approval before /task commands
6. Run /review after each task commit
7. Only flip passes: true in feature_list.json after verified end-to-end testing
8. Run /eval before any production deploy

Session end (mandatory):
- Append a progress entry to claude-progress.txt
- Commit all work-in-progress with descriptive message
- Never leave a feature half-implemented and uncommitted

Use "ultrathink" for architecture decisions.

## conventions
# FILL IN: your naming conventions, structural patterns, key rules
# be specific — vague conventions are ignored
# example:
# - all LLM calls go through src/llm/client.py — never instantiate client elsewhere
# - errors: raise typed exceptions from src/exceptions.py, catch at CLI layer only
# - tests mirror src structure: tests/test_X/ for each src/X/

## do not
# FILL IN: anti-patterns Claude must never do in this project
# example:
# - do not add dependencies without asking
# - do not catch bare Exception
# - do not hardcode paths — everything through config

## context
- docs/product.md: what this is and why
- docs/vision.md: aspirational long-term scope
- docs/tech.md: stack decisions and ADRs
- docs/structure.md: module map and layer boundaries
- docs/feats/: canonical feature docs (your design thinking, versioned)
- feature_list.json: cross-session feature state — read every session start
- claude-progress.txt: append-only session log — read every session start
- Active specs: specs/ directory
HEREDOC

# ── docs/product.md ───────────────────────────────────────────────────────────

cat > docs/product.md << 'HEREDOC'
# product: [PROJECT_NAME]
# FILL IN: replace [PROJECT_NAME] with your project name
#
# HOW TO USE THIS FILE WITH CLAUDE CODE:
# Open a Claude Code session and say:
#   "Read this product.md and help me fill in each section.
#    Ask me one section at a time."
# Claude will interview you and write the content.

## what it is
# FILL IN: one paragraph. what the product does and what makes it distinct.
# avoid jargon. write it as if explaining to a smart non-expert.

## who it's for
# FILL IN: primary and secondary users. be specific about context.
# "researchers who manage biblatex databases in plain text environments"
# is more useful than "researchers"

## the core problem
# FILL IN: what is broken or painful without this tool?
# describe the friction in concrete terms, not abstract ones.
# bullet list of 3-5 specific pain points works well here.

## what it does
# FILL IN: numbered list of capabilities, one per feature area.
# use present tense: "1. audit — validates bib records and reports issues"
# this list will seed feature_list.json when you run /init

## non-goals (v1)
# FILL IN: what you are explicitly NOT building in this version.
# important for keeping Claude scoped during implementation.

## success criteria
# FILL IN: what does "done" look like for v1?
# describe it as a user workflow: "a user can X, then Y, then Z"
# this becomes the acceptance standard for the whole project.
HEREDOC

# ── docs/vision.md ────────────────────────────────────────────────────────────

cat > docs/vision.md << 'HEREDOC'
# vision: [PROJECT_NAME]
# Your aspirational feature backlog. Not a roadmap. Reviewed quarterly.
# This is "what could this be?" — not "what are we shipping next?"

## long-term scope
# FILL IN: 5-10 major feature areas you want to build eventually
# don't constrain yourself here. dream big.
# example for biblatex:
# - semantic search across papers
# - collaborative bibliography management
# - integration with Zotero/Mendeley
# - reading list generation with importance scoring
# - automated paper recommendations
# - PDF full-text indexing and extraction
# - citation graph visualization

## non-goals (ever)
# FILL IN: what this will never be
# example: not a PDF reader, not a note-taking app, not a Zotero sync service

## why it matters
# FILL IN: what does the world look like when this vision is realized?

---
# current v0: [describe what MVP does]
HEREDOC

# ── docs/tech.md ──────────────────────────────────────────────────────────────

cat > docs/tech.md << 'HEREDOC'
# tech: [PROJECT_NAME]
# FILL IN: replace [PROJECT_NAME] with your project name
#
# HOW TO USE THIS FILE WITH CLAUDE CODE:
# After filling in docs/product.md, open Claude Code and say:
#   "Read docs/product.md and docs/tech.md.
#    Help me fill in the stack decisions section based on what I'm building.
#    Ask me about any choices you need clarification on."

## stack decisions
# FILL IN: one subsection per major dependency.
# for each: name it, explain why you chose it over alternatives.
# Claude needs the "why" to avoid suggesting replacements mid-project.
# example format:
#
# ### Typer for CLI
# Typer generates clean --help output and supports subcommands naturally.
# Alternative was Click — Typer is Click with better DX. Chosen over argparse
# because we need nested subcommands and automatic type coercion.

## architecture layers
# FILL IN: describe the dependency flow between layers.
# a simple ASCII diagram works well:
#
# CLI layer (src/cli/)
#   ↓ calls
# Service layer (src/services/)
#   ↓ calls
# Data layer (src/db/)     External layer (src/llm/)
#
# Rule: dependencies only flow downward.
# Each layer should be independently testable.

## module map
# FILL IN: one line per key file/module, explain its single responsibility.
# example:
# - src/llm/client.py — single entry point for all LLM calls, owns prompt templates
# - src/config.py — loads and validates config, returns typed dataclass, loaded once

## ADRs
# Architecture Decision Records live in docs/adr/
# Run /adr [decision-name] to scaffold a new one.
# Link them here once written:
# - ADR-001: [title] — docs/adr/001-[slug].md
HEREDOC

# ── docs/structure.md ─────────────────────────────────────────────────────────

cat > docs/structure.md << 'HEREDOC'
# structure: [PROJECT_NAME]
# FILL IN: replace [PROJECT_NAME] with your project name
#
# HOW TO USE THIS FILE WITH CLAUDE CODE:
# Once you have a src/ directory with initial files, say:
#   "Read the current project structure and help me document it in docs/structure.md.
#    Flag any structural issues you notice."

## directory layout
# FILL IN: the intended directory tree with one-line explanations.
# keep it current — update when you add new modules.
# example:
#
# src/
#   cli/         ← Typer app and subcommands, thin layer, no business logic
#   services/    ← one file per feature domain, orchestrates bib + llm layers
#   bib/         ← all .bib file operations, single entry point parser.py
#   llm/         ← all Anthropic API calls, prompt templates in prompts/
#   config.py    ← loads config.toml, returns typed Config dataclass
#   exceptions.py ← all custom exception types

## naming conventions
# FILL IN: the specific naming rules for this project.
# example:
# - modules: snake_case
# - CLI commands: kebab-case (my-app do-thing)
# - classes: PascalCase
# - constants: UPPER_SNAKE_CASE

## layer rules
# FILL IN: what each layer is and is not allowed to do.
# example:
# - CLI layer: handles input/output only, no business logic, catches exceptions
# - Service layer: orchestrates, no direct I/O, raises typed exceptions
# - Data layer: reads/writes external state, never calls LLM

## test structure
# FILL IN: how tests mirror src, what each test type covers.
# example:
# - tests/test_cli/ — integration tests via CLI runner, not unit tests
# - tests/test_services/ — unit tests with mocked dependencies
# - tests/test_bib/ — unit tests with fixture .bib files
HEREDOC

# ── feature_list.json ─────────────────────────────────────────────────────────

cat > feature_list.json << 'HEREDOC'
[
  {
    "_comment": "FILL IN: this file is generated by /init from docs/product.md",
    "_comment2": "Each feature starts with passes: false.",
    "_comment3": "ONLY the passes field may be changed — by the agent, after verified end-to-end testing.",
    "_comment4": "Never remove, reorder, or restructure entries. Append new ones at the end.",
    "_comment5": "Run /init to have Claude generate real features from your product.md"
  }
]
HEREDOC

# ── claude-progress.txt ───────────────────────────────────────────────────────

cat > claude-progress.txt << 'HEREDOC'
# project progress log
# append only — one entry per session, never edit previous entries
# format:
#
# --- [YYYY-MM-DD] session [N] ---
# completed: [list of tasks/features finished this session]
# pending: [open tasks, by spec file and task ID]
# decisions: [architectural choices not yet in an ADR]
# broken: [anything known broken, even outside current scope]
# next: [recommended starting point for next session]

--- [project initialized] ---
completed: project scaffold created
pending: fill in CLAUDE.md, docs/product.md, docs/tech.md — then run /init
decisions: none yet
broken: none
next: fill in docs/product.md first, then run /init to generate feature_list.json
HEREDOC

# ── init.sh ───────────────────────────────────────────────────────────────────

cat > init.sh << 'HEREDOC'
#!/usr/bin/env bash
# init.sh — run at the start of every session to confirm the project is healthy
# FILL IN: replace the placeholder commands with your actual dev server and smoke test
#
# exit 0 = healthy, session can proceed
# exit 1 = broken, fix before implementing anything new

set -euo pipefail

echo "── bibref health check ──"

# FILL IN: check dependencies are installed
# example for Python/uv:
# echo "checking dependencies..."
# uv sync --quiet || { echo "FAIL: uv sync failed"; exit 1; }

# FILL IN: run your test suite (fast subset is fine)
# example:
# echo "running smoke tests..."
# uv run pytest tests/test_smoke.py -q || { echo "FAIL: smoke tests failed"; exit 1; }

# FILL IN: for a CLI tool, verify the entrypoint works
# example:
# echo "checking CLI entrypoint..."
# uv run my-tool --version > /dev/null || { echo "FAIL: CLI not working"; exit 1; }

echo "── all checks passed ──"
exit 0
HEREDOC
chmod +x init.sh

# ── evals/rubric.md ───────────────────────────────────────────────────────────

cat > evals/rubric.md << 'HEREDOC'
# eval rubric
# FILL IN: define grading criteria for each feature area.
# The eval-judge skill uses this to grade outputs pass/fail/partial.
#
# HOW TO USE WITH CLAUDE CODE:
# After implementing your first feature, say:
#   "Help me write eval criteria for [feature] in evals/rubric.md.
#    Base it on the acceptance criteria in specs/[feature].md"
#
# Format per criterion:
#   ## [criterion name]
#   weight: 1.0 (hard fail) | 0.5 (soft, degrades score) | 0.25 (nice to have)
#   description: what pass looks like
#   fail signals: concrete examples of what failure looks like

## correctness
weight: 1.0
description: output matches the expected structure and content from the golden example
fail signals: missing required fields, wrong data types, truncated output

## no data corruption
weight: 1.0
description: .bib file content is unchanged except for intended modifications
fail signals: any unintended field change, record deletion, key modification

## error handling
weight: 0.5
description: errors surface as typed exceptions with actionable messages
fail signals: bare Exception, cryptic messages, silent failures

## convention compliance
weight: 0.5
description: code follows patterns in docs/tech.md and docs/structure.md
fail signals: direct bibtexparser calls outside bib/parser.py, hardcoded paths
HEREDOC

# ── .claude/settings.json ─────────────────────────────────────────────────────

cat > .claude/settings.json << 'HEREDOC'
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit|MultiEdit",
        "hooks": [
          {
            "type": "command",
            "command": "cd $CLAUDE_PROJECT_DIR && uv run ruff check --fix . --quiet 2>/dev/null; uv run ruff format . --quiet 2>/dev/null; true"
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "echo \"$CLAUDE_TOOL_INPUT\" | grep -q 'git commit' && uv run pytest tests/ -q --tb=no 2>/dev/null || true"
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "notify-send 'bibref' 'Claude finished — check terminal' --icon=utilities-terminal 2>/dev/null; true"
          }
        ]
      }
    ]
  }
}
HEREDOC

# ── .claude/agents/ ───────────────────────────────────────────────────────────

cat > .claude/agents/initializer.md << 'HEREDOC'
---
name: initializer
description: First-run setup agent. Reads docs/product.md and generates
  feature_list.json with all project features. Run once via /init.
allowed-tools: Read, Write, Bash
---

You are the initializer agent. Run only once per project.

Read docs/product.md carefully, especially the "what it does" and "success criteria" sections.

Generate feature_list.json: a comprehensive list of every end-to-end feature.

Rules for feature_list.json:
- Every feature starts with "passes": false
- Future agents may ONLY change the "passes" field — never structure or descriptions
- Be comprehensive: 20-50 features is normal for a real project
- Each feature must be testable end-to-end by a human user, not just at unit level
- steps[] must describe what a user does, not what code does

Use exactly this JSON structure:

[
  {
    "id": "feat-001",
    "category": "functional | reliability | ux",
    "description": "User can [verb] [object] and [outcome]",
    "steps": [
      "Run [command]",
      "Observe [expected output]",
      "Verify [specific criterion]"
    ],
    "passes": false
  }
]

After writing feature_list.json, make an initial git commit:
  git add feature_list.json
  git commit -m "chore(init): generate feature list from product spec"

Return a summary: how many features generated, by category.
HEREDOC

cat > .claude/agents/architect.md << 'HEREDOC'
---
name: architect
description: Read-only research agent. Maps blast radius of a proposed change,
  identifies cross-dependencies, flags risks. Never modifies files.
allowed-tools: Read, Grep, Glob
---

You are a read-only architect agent. You MUST NOT create, modify, or delete files.

Your task: $ARGUMENTS

Before responding, read:
- docs/tech.md (architecture layers and constraints)
- docs/structure.md (module map and layer rules)
- Relevant source files in src/

Output a structured findings report:

## files affected
[list each file, reason it would change]

## cross-dependencies
[imports, exports, shared types that would be impacted]

## data/schema implications
[any changes to data structures, config, or file formats]

## risks
[what could break, what's uncertain, what needs a decision]

## open questions
[decisions that must be made before implementation can start]
[if any require an ADR, say so explicitly]

Write your findings to specs/$ARGUMENTS-findings.md, then return a summary.
HEREDOC

cat > .claude/agents/developer.md << 'HEREDOC'
---
name: developer
description: Scoped implementation agent. Implements exactly one task from
  the current spec. Commits on completion. Never works outside task scope.
allowed-tools: Read, Write, Edit, MultiEdit, Bash
---

You are a developer agent implementing a single task.

Task ID: $ARGUMENTS

Before writing any code:
1. Read the relevant spec in specs/ (find it from task ID)
2. Identify exactly which files this task touches
3. Read those files in full

Execution rules:
- Implement only what this task describes — nothing more
- Do not refactor adjacent code even if you notice issues
- Run tests after implementation: if they fail, fix before committing
- If you find a bug outside your scope: add a note to claude-progress.txt, do not fix it

Commit format:
  git add [only the files this task touches]
  git commit -m "task(#$ARGUMENTS): [brief description]"

If blocked: explain what's blocking you and stop. Do not guess or work around it.

Return: done / blocked [reason]
HEREDOC

cat > .claude/agents/reviewer.md << 'HEREDOC'
---
name: reviewer
description: Read-only review agent. Checks implementation against spec
  acceptance criteria and architecture conventions. No generation context.
allowed-tools: Read, Grep, Glob, Bash
---

You are a code reviewer. You have no knowledge of how this code was written.

You will receive a task ID or feature name as $ARGUMENTS.

Read:
1. specs/$ARGUMENTS.md — specifically the acceptance criteria section
2. git diff HEAD~1 — the actual changes made
3. docs/tech.md — conventions and layer rules

For each acceptance criterion, output:
  [criterion text]: PASS | FAIL | PARTIAL
  evidence: [specific line or behavior that supports your verdict]

Then check conventions:
  layer violations: [any cross-layer dependency that shouldn't exist]
  do-not rules: [any violation of CLAUDE.md do-not section]

Final verdict: PASS | FAIL
If FAIL: list what must be fixed before proceeding to the next task.

Do not suggest improvements. Only flag violations of stated criteria and conventions.
HEREDOC

# ── .claude/skills (auto-invoked) ────────────────────────────────────────────

cat > .claude/skills/spec-writer/SKILL.md << 'HEREDOC'
---
name: spec-writer
description: Use when the user describes a new feature, asks to build something,
  or says they want to add functionality. Scaffolds a spec file with EARS-style
  acceptance criteria and an initial task checklist. Writes to specs/.
allowed-tools: Read, Write
context: fork
agent: Explore
---

You are a spec writer. Your output is a specification file, not code.

Read:
- docs/feats/$ARGUMENTS.md (user's design thinking and decisions)
- specs/$ARGUMENTS-findings.md (from agent research, if available)
- docs/product.md (understand the project scope)
- docs/tech.md (understand constraints)
- specs/_template.md (use this structure)
- Any existing specs in specs/ (for consistency)

Write specs/$ARGUMENTS.md with this structure:

# spec: [feature name]

## findings
[populated from docs/feats/$ARGUMENTS.md and specs/$ARGUMENTS-findings.md]
[or: "pending /research" if no findings yet]

## objective
[one paragraph: what changes, why, what success looks like]

## acceptance criteria (EARS format)
[each criterion: "when [condition], the system must [behavior]"]
[be specific enough that a test can be written from each criterion]

## tasks
- [ ] task-01: [atomic unit of work] (blocks: none)
- [ ] task-02: [atomic unit of work] (blocks: task-01)
[each task = one commit, one subagent context]

## ADR required?
[yes — run /adr [decision] before implementing | no]

## risks
[what could go wrong, what's uncertain]

Return: "spec written to specs/$ARGUMENTS.md — review before running /task"
HEREDOC

cat > .claude/skills/reviewer/SKILL.md << 'HEREDOC'
---
name: reviewer
description: Use when the user asks to review code, check an implementation,
  or before marking a task complete. Reads diff against spec criteria.
allowed-tools: Read, Grep, Glob, Bash
context: fork
agent: Explore
---

You are a reviewer running in an isolated context. You do not know how the code was written.

Delegate to the reviewer agent: spawn it with the feature or task name as argument.
The reviewer agent will read the diff and spec and return a structured verdict.

Surface the verdict clearly. If FAIL, list exactly what must be fixed.
Do not proceed until the user acknowledges the verdict.
HEREDOC

cat > .claude/skills/eval-judge/SKILL.md << 'HEREDOC'
---
name: eval-judge
description: Use when the user asks to run evals, check quality, or before
  any production deployment. Runs test suite and grades output against rubric.
allowed-tools: Read, Bash
context: fork
---

You are an evaluation judge. You do not generate code or suggest fixes.

Steps:
1. Run the test suite: [use the test command from CLAUDE.md]
   Report: X passed, Y failed, Z errors

2. For each file in evals/golden/:
   - Read the golden example (input + expected output)
   - Read evals/rubric.md for grading criteria
   - Compare actual behavior against expected
   - Grade each criterion: pass / fail / partial + one-line rationale

3. Write results to evals/results/[YYYY-MM-DD]-[feature].json:
{
  "date": "YYYY-MM-DD",
  "feature": "[name]",
  "test_suite": {"passed": N, "failed": N, "errors": N},
  "criteria": [
    {"criterion": "[name]", "weight": 1.0, "verdict": "pass|fail|partial", "rationale": "..."}
  ],
  "overall": "pass|fail",
  "score": 0.0
}

4. Commit: git add evals/results/ && git commit -m "eval: [feature] [date]"

Return: overall verdict and score. List any failed criteria explicitly.
HEREDOC

# ── .claude/skills (slash commands) ─────────────────────────────────────────

cat > .claude/skills/design/SKILL.md << 'HEREDOC'
---
name: design
description: Help you iterate on canonical feature docs in docs/feats/.
  Refines acceptance criteria, flags ambiguities, suggests tradeoffs.
  For your design thinking, not agent engineering planning.
allowed-tools: Read, Write
context: fork
agent: Explore
---

You are a design collaborator. Your role is to help the user think through features.

Task: improve docs/feats/$ARGUMENTS.md

Read:
- The feature doc itself
- docs/vision.md (what's in scope for long-term)
- docs/product.md (what's in scope for MVP)
- docs/tech.md (constraints and architecture)
- Related feature docs (understand dependencies)

Then:
- Ask clarifying questions (Socratic, not prescriptive)
- Flag ambiguities in acceptance criteria
- Suggest tradeoffs ("if you want X, that implies Y cost")
- Help version the doc (suggest version bump if thinking has shifted)
- Identify unknowns that agents should research

Output format:
- [criterion]: [is this clear? what's ambiguous?]
- [decision]: [is this justified? what's the reasoning?]
- [version suggestion]: bump from v1.0 to v1.1? why?

Do NOT write specs. Do NOT think about implementation.
This is design thinking space, not engineering planning.

When done, ask: "Ready to move this to /spec for agent collaboration?"
HEREDOC

cat > .claude/skills/init/SKILL.md << 'HEREDOC'
---
name: init
description: First-run project initialization. Generates feature_list.json
  from docs/product.md. Run once per project after filling in product.md.
disable-model-invocation: true
---

Run the initializer agent to generate feature_list.json from docs/product.md.

Before running, confirm:
1. docs/product.md is filled in (not just the template comments)
2. The user has reviewed it and is ready to commit the feature list

Spawn the initializer agent with the project name as context.
After it completes, show the user the generated feature_list.json and ask them to confirm it before the commit lands.
HEREDOC

cat > .claude/skills/research/SKILL.md << 'HEREDOC'
---
name: research
description: Phase R of RPI. Maps blast radius of a proposed feature or change.
  Spawns the architect agent to read the codebase and produce findings.
disable-model-invocation: true
---

Spawn the architect agent with task: $ARGUMENTS

The architect will:
- Map all files the change will touch
- Identify cross-dependencies
- Flag risks and open decisions
- Write findings to specs/$ARGUMENTS-findings.md

After the architect returns, present the findings to the user.
Ask: "Do these findings look complete? Any missing files or dependencies?"
Do not proceed to /spec until the user confirms the research is complete.
HEREDOC

cat > .claude/skills/spec/SKILL.md << 'HEREDOC'
---
name: spec
description: Phase P of RPI. Produces the spec file for a feature.
  Reads docs/feats/, agent research, writes specs/[feature].md.
disable-model-invocation: true
---

Invoke the spec-writer skill for: $ARGUMENTS

Context for spec-writer:
- docs/feats/$ARGUMENTS.md (your canonical design thinking)
- specs/$ARGUMENTS-findings.md (agent research, if it exists)
- docs/product.md (project scope)
- docs/tech.md (constraints)

If docs/feats/$ARGUMENTS.md does not exist, ask the user:
  "I don't see docs/feats/$ARGUMENTS.md. Have you written the feature design yet?
   Try /design $ARGUMENTS first, then come back to /spec."

After the spec is written, present it to the user.
Ask for explicit approval before any /task commands run.
Do not proceed without "approved" or equivalent confirmation.
HEREDOC

cat > .claude/skills/task/SKILL.md << 'HEREDOC'
---
name: task
description: Phase I of RPI. Implements one task from the current spec.
  Spawns a developer subagent with scoped context. Commits on completion.
disable-model-invocation: true
---

Implement task $ARGUMENTS.

Before spawning the developer agent, confirm:
1. The relevant spec file exists in specs/
2. The task ID exists in the spec's task list
3. All blocking tasks are marked complete

Spawn the developer agent with task ID: $ARGUMENTS

After the agent returns:
- If done: run /review automatically before marking the task complete
- If blocked: surface the blocker to the user, do not proceed

One task = one subagent = one commit. Do not batch tasks.
HEREDOC

cat > .claude/skills/review/SKILL.md << 'HEREDOC'
---
name: review
description: Post-implementation review gate. Checks the last commit against
  spec acceptance criteria. Run after every /task before the next one.
disable-model-invocation: true
---

Spawn the reviewer agent for: $ARGUMENTS

If no argument given, review the most recent commit against the active spec.

The reviewer will return PASS or FAIL with specific evidence.

If PASS: confirm to the user, proceed is safe.
If FAIL: list what must be fixed. Do not run /task [next] until fixes are committed and /review passes.

This gate is mandatory. Do not skip it under time pressure.
HEREDOC

cat > .claude/skills/eval/SKILL.md << 'HEREDOC'
---
name: eval
description: Quality gate. Runs test suite and LLM judge against golden examples.
  Run after every feature is complete and before any production deploy.
disable-model-invocation: true
---

Invoke the eval-judge skill for: $ARGUMENTS

The judge will:
1. Run the full test suite
2. Grade outputs against evals/rubric.md
3. Write results to evals/results/
4. Commit the results

Surface the score and any failed criteria to the user.
If overall verdict is FAIL: do not proceed to production deploy.
HEREDOC

cat > .claude/skills/adr/SKILL.md << 'HEREDOC'
---
name: adr
description: Scaffold a new Architecture Decision Record in docs/adr/.
  Run when a spec flags an architecture decision is required.
disable-model-invocation: true
---

Create docs/adr/[next-number]-$ARGUMENTS.md with this structure:

# ADR-[NNN]: [title from $ARGUMENTS]

## status
Proposed

## context
[FILL IN: what situation or problem motivated this decision?]
[what constraints, requirements, or forces are in play?]

## decision
[FILL IN: what was decided?]
[be specific: name the approach, library, pattern, or rule]

## alternatives considered
[FILL IN: what other options were evaluated?]
[why were they rejected?]

## consequences
Positive:
- [what this decision enables or improves]

Negative:
- [what this decision costs or constrains]

Neutral:
- [what changes without being clearly good or bad]

---

After writing, link it in docs/tech.md under the ADRs section.
Ask the user to review and change status from "Proposed" to "Accepted" when ready.
HEREDOC

# ── specs/_template.md ────────────────────────────────────────────────────────

cat > specs/_template.md << 'HEREDOC'
# spec: [feature name]
# Copy this file to specs/[feature-name].md
# Read from docs/feats/[feature-name].md before writing this spec

## findings
[populated from docs/feats/[feature-name].md and agent research]
[or: "pending /research"]

## objective
[one paragraph: what changes, why it matters, what success looks like for the user]

## acceptance criteria (EARS format)
# "when [condition], the system must [behavior]"
# each criterion should be independently testable
- when [condition], the system must [behavior]
- when [condition], the system must [behavior]

## tasks
# each task = one atomic commit = one developer subagent context
# list blockers explicitly — the agent will enforce the dependency order
- [ ] task-01: [description] (blocks: none)
- [ ] task-02: [description] (blocks: task-01)

## ADR required?
[yes — run /adr [decision-name] before /task | no]

## risks
[what could go wrong, what's uncertain, what could affect adjacent features]
HEREDOC

# ── .gitignore ────────────────────────────────────────────────────────────────

cat > .gitignore << 'HEREDOC'
# Python
__pycache__/
*.pyc
*.pyo
.venv/
dist/
*.egg-info/
.ruff_cache/
.pytest_cache/
.coverage

# env
.env
.env.*
!.env.example

# OS
.DS_Store

# evals — results are committed, but not temp files
evals/tmp/
HEREDOC

# ── git init ─────────────────────────────────────────────────────────────────

if [ ! -d .git ]; then
  git init --quiet
  git add .
  git commit -m "chore(scaffold): initialize RPI-SDD project structure" --quiet
  echo "git repository initialized"
else
  echo "git repository already exists — skipping git init"
fi

# ── done ─────────────────────────────────────────────────────────────────────

echo ""
echo "scaffold complete. next steps:"
echo ""
echo "  1. fill in CLAUDE.md         — stack, commands, conventions"
echo "  2. fill in docs/product.md   — what it is, who it's for, what it does"
echo "  3. fill in docs/tech.md      — stack decisions, architecture layers"
echo "  4. open Claude Code and say:"
echo "     '/design 01-core-feature' to iterate on your first feature design"
echo "     then '/spec 01-core-feature' to create the spec"
echo "     then '/init' to generate feature_list.json from your product.md"
echo ""
echo "tip: open docs/product.md in Claude Code first and say:"
echo "  'help me fill in this product.md — ask me one section at a time'"
echo ""
