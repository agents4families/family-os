#!/usr/bin/env bash
# Structural checks for the template repo. Run before opening a PR:  bash scripts/lint-repo.sh
set -uo pipefail
cd "$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
ERR=0
fail() { echo "  FAIL: $*"; ERR=$((ERR+1)); }

echo "Skills"
for d in skills/*/; do
  n=$(basename "$d"); f="$d/SKILL.md"
  [[ -f "$f" ]] || { fail "$n has no SKILL.md"; continue; }
  fm=$(awk 'NR==1&&/^---$/{on=1;next} on&&/^---$/{exit} on{print}' "$f")
  nm=$(echo "$fm" | sed -n 's/^name: *//p' | head -1)
  ds=$(echo "$fm" | sed -n 's/^description: *//p' | head -1)
  [[ "$n" == "_template" ]] && continue
  [[ "$nm" == "$n" ]] || fail "$f: frontmatter name '$nm' != folder '$n'"
  [[ -n "$ds" ]] || fail "$f: missing description"
  [[ "$ds" == *"Use when"* || "$ds" == *"Use at"* || "$ds" == *"Use monthly"* || "$ds" == *"Use on"* ]] || fail "$f: description should say when to use it"
  grep -q '^## Done when' "$f" || fail "$f: missing '## Done when'"
  grep -q '^## Guardrails' "$f" || fail "$f: missing '## Guardrails'"
done

echo "Reviewer lenses"
for f in agents/*.md; do
  grep -q '^## Return' "$f" || fail "$f: missing '## Return'"
done

echo "AGENTS.md references"
for s in morning-brief evening-reset capture weekly-summit meal-plan bills-and-money monthly-retro inbox-triage event-prep home-maintenance decision-brief family-meeting kid-activity setup handoff os-audit; do
  [[ -f "skills/$s/SKILL.md" ]] || fail "AGENTS.md lists skill '$s' but skills/$s/SKILL.md is missing"
done
for a in logistics-checker budget-hawk dietary-checker kids-eye-view future-us safety-reviewer devils-advocate; do
  [[ -f "agents/$a.md" ]] || fail "AGENTS.md lists lens '$a' but agents/$a.md is missing"
done
L=$(wc -l < AGENTS.md); (( L <= 150 )) || fail "AGENTS.md is $L lines (target <= 150)"

echo "Context index"
while IFS= read -r p; do
  [[ -z "$p" ]] && continue
  case "$p" in ../*) t="${p#../}" ;; *) t="context/$p" ;; esac
  [[ "$t" == *"<"* ]] && continue
  [[ -e "$t" ]] || fail "context/INDEX.md references '$p' but $t does not exist"
done < <(grep -oE '^\| `[^`]+` ' context/INDEX.md | sed -E 's/^\| `([^`]+)` /\1/')

echo "Consumer packs"
for p in chief meals trips council kids; do
  out=$(bash scripts/compile-consumer.sh "$p" --max-tier 3 --out "$(mktemp -d)" 2>&1) || fail "compile-consumer.sh $p failed"
  n=$(echo "$out" | sed -n 's/^Knowledge files: \([0-9]*\).*/\1/p'); (( ${n:-0} <= 10 )) || fail "pack $p has $n knowledge files (cap 10)"
done

echo "State files"
python3 -c "import json;json.load(open('harness/state/tasks.json'))" 2>/dev/null || fail "harness/state/tasks.json is not valid JSON"
bash -n scripts/*.sh 2>/dev/null || fail "a script has a syntax error"

echo
if (( ERR > 0 )); then echo "FAILED: $ERR problem(s)."; exit 1; else echo "OK"; fi
