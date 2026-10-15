#!/usr/bin/env bash
# Lists context files past their review_by date, files with many [TODO]s, and rough word counts.
# Run from the Family-OS folder:  bash scripts/check-staleness.sh
# Also useful as input to the os-audit skill.

set -uo pipefail
today=$(date +%Y-%m-%d)
echo "Staleness check for $today"
echo

printf "%-45s %-12s %-12s %6s %6s\n" FILE UPDATED REVIEW_BY TODOS WORDS
find context -name "*.md" -not -path "*/private/*" | sort | while read -r f; do
  updated=$(grep -m1 '^updated:' "$f" | awk '{print $2}')
  review=$(grep -m1 '^review_by:' "$f" | awk '{print $2}')
  todos=$(grep -o '\[TODO' "$f" | wc -l | tr -d ' ')
  words=$(wc -w < "$f" | tr -d ' ')
  flag=""
  if [[ -n "${review:-}" && "$review" != "YYYY-MM-DD" && "$review" < "$today" ]]; then flag=" STALE"; fi
  printf "%-45s %-12s %-12s %6s %6s%s\n" "$f" "${updated:--}" "${review:--}" "$todos" "$words" "$flag"
done

echo
echo "Always-loaded budget (target < 2500 words):"
cat AGENTS.md context/INDEX.md context/household.md 2>/dev/null | wc -w

echo
echo "Possible secrets (patterns only; review by hand, do not paste values anywhere):"
grep -rInE '(password|passwd|pin:|ssn|social security|routing|api[_-]?key|secret|[0-9]{13,19})' \
  --include="*.md" --include="*.json" . 2>/dev/null \
  | grep -v 'harness/evals' | grep -v 'docs/' | grep -v 'skills/' | grep -v 'harness/guardrails.md' \
  | cut -d: -f1,2 | head -20
