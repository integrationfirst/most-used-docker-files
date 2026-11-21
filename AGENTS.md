# AGENTS.md

A personal collection of ready-to-run container setups for local development:
podman/docker run commands (plain-text notes such as `kafka`, `n8n`, `elk`),
compose-style YAML (`postgres.yaml`, `pgadmin.yml`) and service config
(`camunda/`). The target environment is Podman on Windows 11 with WSL2 (see
`README.md`).

## Conventions

- One service per file, named after the service. Plain-text notes start with a
  short description and a host/container connectivity note, then the
  copy-pasteable command(s).
- Containers that talk to each other share the `ps` podman network (see
  `network`).
- Credentials in these files are local-dev defaults only. Never commit real
  secrets.

## Setup

A fresh checkout needs nothing installed beyond `python3` with PyYAML
(`pip install pyyaml`) for the checks. There is no dev server.

## Validation

`bash factory/checks.sh` (run from the repo root or a worktree). It checks:

- every tracked `*.yml`, `*.yaml` and `*.json` file parses;
- no merge-conflict markers are committed;
- every tracked `*.sh` passes `bash -n`.

## Software factory

`/factory run` builds every open GitHub issue labeled `factory` through
intake → spec → build → gate → review → approve, one PR per issue. State is in
`factory/jobs/` (gitignored); `factory/bin/job` is its only writer. Checks:
`factory/checks.sh`. Dashboard: `cd factory && python3 -m http.server`, then
open http://localhost:8000/dashboard.html.

Each job works in its own git worktree, a full checkout of the repo at
`.worktrees/<job-id>` (gitignored). A tool run from the repo root that doesn't
read `.gitignore` sees those copies too; exclude `.worktrees/` in its config.
