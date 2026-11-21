#!/usr/bin/env bash
# The repo's checks. Exit 0 only when the branch is fit to review.
#
# The gate runs this script from the main checkout with the job's worktree as
# the working directory. Keep it fast, deterministic and non-interactive: no
# watch modes, no prompts, nothing that rewrites files.
#
# This repo is a collection of container reference files (YAML configs and
# plain-text podman/docker command notes). It has no build or test suite, so
# the checks validate syntax and catch broken commits.
set -euo pipefail

python3 -c 'import yaml' 2>/dev/null || {
  echo "checks.sh needs PyYAML: pip install pyyaml" >&2
  exit 1
}

echo "== YAML / JSON syntax"
git ls-files -z -- '*.yml' '*.yaml' '*.json' | python3 -I -c '
import json, sys, yaml
failed = False
for path in sys.stdin.read().split("\0"):
    if not path:
        continue
    try:
        with open(path, encoding="utf-8") as fh:
            if path.endswith(".json"):
                json.load(fh)
            else:
                list(yaml.safe_load_all(fh))
    except Exception as exc:
        print(f"{path}: {exc}", file=sys.stderr)
        failed = True
sys.exit(1 if failed else 0)
'

echo "== Merge-conflict markers"
if git grep -nE '^(<<<<<<< |>>>>>>> |=======$)' -- . ':!factory/dashboard.html'; then
  echo "Merge-conflict markers found" >&2
  exit 1
fi

echo "== Shell syntax"
while IFS= read -r -d '' f; do
  bash -n "$f"
done < <(git ls-files -z -- '*.sh')

echo "All checks passed."
