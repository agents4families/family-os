#!/usr/bin/env bash
# Compile role-specific knowledge bundles + paste-ready instructions for consumer assistants
# (Gemini Gems, Grok Workspaces, etc.) from the canonical Family-OS files.
#
# Usage (from the Family-OS folder):
#   bash scripts/compile-consumer.sh <pack> [--max-tier N] [--ext md|txt] [--out DIR]
#
# Packs:   chief | meals | trips | council | kids
# Tier:    includes only files whose frontmatter `sensitivity:` is <= N. Default 1 (safe for Grok/Muse-class tools).
#          Use --max-tier 2 for private Gems that need allergies and money rules. Tier 3 is never stored.
# Output:  dist/<pack>/NN-name.<ext> (<= 10 files) and dist/<pack>/INSTRUCTIONS.txt
#
# Re-run after editing context. If dist/ lives in Drive, a Gem that links the Drive files sees the update.

set -uo pipefail

usage() { sed -n '2,13p' "$0"; exit 1; }

PACK="${1:-}"; [[ -z "$PACK" || "$PACK" == -* ]] && usage; shift
MAX=1; EXT="md"; OUT=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --max-tier) MAX="${2:?}"; shift 2 ;;
    --ext)      EXT="${2:?}"; shift 2 ;;
    --out)      OUT="${2:?}"; shift 2 ;;
    *) echo "Unknown option: $1"; usage ;;
  esac
done
OUT="${OUT:-dist/$PACK}"

[[ -f AGENTS.md && -d context ]] || { echo "Run this from the Family-OS folder."; exit 1; }
mkdir -p "$OUT"; rm -f "$OUT"/*

SKIPPED=()
tier_of() { local t; t=$(sed -n 's/^sensitivity: *\([0-9]\).*/\1/p' "$1" | head -1); echo "${t:-0}"; }

# bundle <name> <file>...   Concatenates files (frontmatter stripped), honoring the tier cap.
bundle() {
  local name="$1"; shift
  local dest="$OUT/$name.$EXT" n=0 f t
  : > "$dest"
  for f in "$@"; do
    [[ -f "$f" ]] || continue
    t=$(tier_of "$f")
    if (( t > MAX )); then SKIPPED+=("$f (tier $t)"); continue; fi
    printf '\n<!-- SOURCE: %s -->\n\n' "$f" >> "$dest"
    awk 'NR==1 && /^---$/ {fm=1; next} fm==1 && /^---$/ {fm=0; next} fm!=1 {print}' "$f" >> "$dest"
    n=$((n+1))
  done
  if (( n == 0 )); then rm -f "$dest"; printf '  %-26s (nothing eligible at tier <= %s)\n' "$name" "$MAX"
  else printf '  %-26s %6s words\n' "$name.$EXT" "$(wc -w < "$dest" | tr -d ' ')"; fi
}

members() { local f; for f in context/members/*.md; do [[ "$(basename "$f")" == _* ]] || echo "$f"; done; }
skill()   { local s; for s in "$@"; do echo "skills/$s/SKILL.md"; done; }
lens()    { local s; for s in "$@"; do echo "agents/$s.md"; done; }

BASE=""; ROLE=""
echo "Pack: $PACK   max tier: $MAX   ext: $EXT   out: $OUT"
case "$PACK" in
  chief)
    bundle 01-household        context/household.md context/charter.md context/routines.md context/calendar-rules.md
    bundle 02-people-contacts  context/contacts.md $(members)
    bundle 03-voice            context/voice.md
    bundle 04-skills-rhythm    $(skill morning-brief evening-reset capture weekly-summit handoff)
    bundle 05-skills-admin     $(skill inbox-triage event-prep home-maintenance bills-and-money) context/home.md context/money-rules.md
    bundle 06-lenses           $(lens logistics-checker safety-reviewer devils-advocate budget-hawk)
    BASE=consumer/shared/constitution-4000.txt; ROLE=consumer/gemini/gems/chief.role.md ;;
  meals)
    bundle 01-food             context/food.md
    bundle 02-rhythm           context/routines.md context/calendar-rules.md
    bundle 03-playbook         $(skill meal-plan) $(lens dietary-checker)
    BASE=consumer/shared/constitution-1500.txt; ROLE=consumer/gemini/gems/meals.role.md ;;
  trips)
    bundle 01-household        context/household.md context/money-rules.md context/vault-pointer.md context/food.md
    bundle 02-playbook         $(skill trip-plan)
    bundle 03-lenses           $(lens safety-reviewer kids-eye-view budget-hawk logistics-checker)
    BASE=consumer/shared/constitution-4000.txt; ROLE=consumer/gemini/gems/trips.role.md ;;
  council)
    bundle 01-charter-money    context/charter.md context/household.md context/money-rules.md
    bundle 02-playbook         $(skill decision-brief family-meeting)
    bundle 03-lenses           $(lens budget-hawk kids-eye-view future-us logistics-checker devils-advocate safety-reviewer)
    BASE=consumer/shared/constitution-4000.txt; ROLE=consumer/gemini/gems/council.role.md ;;
  kids)
    bundle 01-kid-agent        kid-mode/KID-AGENT.md
    bundle 02-activities       $(skill kid-activity)
    BASE=""; ROLE=consumer/gemini/gems/kids.role.md ;;
  *) echo "Unknown pack: $PACK (chief | meals | trips | council | kids)"; exit 1 ;;
esac

# Assemble INSTRUCTIONS.txt: base constitution with the role block inserted before FAMILY BASICS.
ROLE_BODY=""
if [[ -f "$ROLE" ]]; then
  ROLE_BODY=$(awk '/^## (ROLE BLOCK|INSTRUCTIONS)/ {on=1; next} on {print}' "$ROLE")
fi
INSTR="$OUT/INSTRUCTIONS.txt"
if [[ -n "$BASE" && -f "$BASE" ]]; then
  awk -v role="$ROLE_BODY" '
    /^FAMILY BASICS/ && !done { print role; print ""; done=1 }
    { print }' "$BASE" > "$INSTR"
else
  printf '%s\n' "$ROLE_BODY" > "$INSTR"
fi
CHARS=$(wc -c < "$INSTR" | tr -d ' ')

echo
echo "Instructions: $INSTR ($CHARS characters)"
(( CHARS > 8000 )) && echo "  WARNING: over 8,000 characters. Long instructions dilute attention; move detail into knowledge files."
grep -q '\[Paste' "$INSTR" && echo "  TODO: fill in the FAMILY BASICS section before pasting."
grep -q '\[Pip\]\|\[5-8\]' "$INSTR" && echo "  TODO: fill in the bracketed fields (name, age, time cap)."

FILES=$(find "$OUT" -type f ! -name INSTRUCTIONS.txt | wc -l | tr -d ' ')
echo "Knowledge files: $FILES (Gem cap: 10)"
(( FILES > 10 )) && echo "  WARNING: more than 10 knowledge files."

if (( ${#SKIPPED[@]} > 0 )); then
  echo
  echo "Withheld by tier cap (sensitivity > $MAX):"
  printf '  - %s\n' "${SKIPPED[@]}"
  echo "  Re-run with --max-tier 2 for a private Gem that needs these."
fi

echo
echo "Next: paste INSTRUCTIONS.txt into the assistant, then attach the files in $OUT (from Drive if possible)."
