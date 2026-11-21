# AGENTS.md

A personal collection of ready-to-run container setups for local development:
podman/docker run commands (plain-text notes such as `services/kafka/kafka`,
`services/n8n/n8n`, `services/elk/elk`), compose-style YAML
(`services/postgres/postgres.yaml`, `services/pgadmin/pgadmin.yml`) and service
config (`services/camunda/`). The target environment is Podman on Windows 11
with WSL2 (see `README.md`). `index.html` at the repo root is a static page for
browsing the setups. `assets/` holds its static files: the brand logo
(`assets/brand/`) and the self-hosted Inter font (`assets/fonts/`). When
changing `index.html`, follow the "Brand" section in `README.md` (colours,
fonts, corners, max width and logo rules).

## Conventions

- Setups live in `services/<service>/`, one folder per service, with files
  named after the service. Plain-text notes start with a short description and
  a host/container connectivity note, then the copy-pasteable command(s).
- A new setup file must also be added to `services/index.json` (paths relative
  to `services/`, sorted), which is the list the browser page reads.
- Containers that talk to each other share the `ps` podman network (defined in
  `services/network/network`).
- Credentials in these files are local-dev defaults only. Never commit real
  secrets.
- When a new git tag is made, update `version.json` at the repo root to the
  tag name: the page footer shows it.

## Setup

A fresh checkout needs nothing installed beyond `python3` with PyYAML
(`pip install pyyaml`) for the checks. There is no build step or dev server
beyond a static file server: to view the browser page, run
`python3 -m http.server` from the repo root and open http://localhost:8000/
(opening `index.html` from disk via `file://` does not work).

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
