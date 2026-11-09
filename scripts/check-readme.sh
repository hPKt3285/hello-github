#!/usr/bin/env bash
# Checks used both by CI (see .github/workflows/readme.yml) and locally.
set -euo pipefail

fail() {
  echo "FAIL: $1"
  exit 1
}

[[ -f README.md ]] || fail "README.md is missing"
grep -q '^# ' README.md || fail "README.md has no top-level title"
grep -q '^## ' README.md || fail "README.md has no sections"

if grep -nE ' +$' README.md; then
  fail "README.md contains trailing whitespace (lines listed above)"
fi

echo "README looks fine"
