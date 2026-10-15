#!/usr/bin/env bash
# Scans tracked files for personal or secret-looking data. Run before every commit to the PUBLIC repo.
#   bash scripts/check-public-safe.sh            # all tracked files
#   bash scripts/check-public-safe.sh --staged   # only files staged for commit (used by the pre-commit hook)
#
# Built-in checks: emails, phone numbers, SSN-like and card-like numbers, API keys and tokens, private keys,
# real Google Doc/Sheet links, street addresses, and files that must never be tracked.
#
# Your own terms (family names, employer, school, city, street) belong in an UNTRACKED file named
# .public-safe-denylist (one term per line, case-insensitive; it is git-ignored), or in the
# PUBLIC_SAFE_TERMS environment variable (comma-separated; in CI use a repository secret).
# The script prints file:line and the check name, never the matched text.
set -uo pipefail

MODE="all"; [[ "${1:-}" == "--staged" ]] && MODE="staged"
cd "$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

if [[ "$MODE" == "staged" ]]; then FILES=$(git diff --cached --name-only --diff-filter=ACMR)
else FILES=$(git ls-files 2>/dev/null || find . -type f -not -path './.git/*' | sed 's|^\./||'); fi
FILES=$(echo "$FILES" | grep -v -E '^(scripts/check-public-safe\.sh|\.public-safe-denylist)$' | grep -v -E '\.(png|jpg|jpeg|gif|pdf|ico)$' || true)

FOUND=0
report() { echo "  $1:$2  [$3]"; FOUND=$((FOUND+1)); }

scan() { # name  regex  [allow-regex]
  local name="$1" re="$2" allow="${3:-}" f
  while IFS= read -r f; do
    [[ -f "$f" ]] || continue
    while IFS=: read -r ln rest; do
      [[ -z "$ln" ]] && continue
      if [[ -n "$allow" ]] && echo "$rest" | grep -qiE "$allow"; then continue; fi
      report "$f" "$ln" "$name"
    done < <(grep -nE "$re" "$f" 2>/dev/null)
  done <<< "$FILES"
}

echo "Public-safety scan ($MODE)"
scan "email address"      '[A-Za-z0-9._%+-]+@[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*\.[A-Za-z]{2,}' '@example\.|noreply@anthropic\.com|@users\.noreply\.github\.com'
scan "phone number"       '(\+?1[ .-])?\(?[0-9]{3}\)?[ .-][0-9]{3}[ .-][0-9]{4}' '800-222-1222|555-01[0-9]{2}'
scan "SSN-like number"    '\b[0-9]{3}-[0-9]{2}-[0-9]{4}\b'
scan "card/account-like number" '\b[0-9]{13,19}\b|\b([0-9]{4}[ -]){3}[0-9]{4}\b' '4111 ?1111 ?1111 ?1111'
scan "API key or token"   'ghp_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}|sk-[A-Za-z0-9_-]{20,}|AKIA[0-9A-Z]{16}|xai-[A-Za-z0-9]{20,}|AIza[0-9A-Za-z_-]{30,}|xox[baprs]-[A-Za-z0-9-]{10,}'
scan "private key"        '-----BEGIN [A-Z ]*PRIVATE KEY-----'
scan "real Google file link" 'docs\.google\.com/(document|spreadsheets|presentation|forms)/d/[A-Za-z0-9_-]{20,}|drive\.google\.com/(file/d|drive/folders)/[A-Za-z0-9_-]{15,}'
scan "street address"     '\b[0-9]{1,5} [A-Z][a-z]+ (St|Street|Ave|Avenue|Rd|Road|Dr|Drive|Ln|Lane|Blvd|Court|Ct)\b' '12 Oak St'

# Personal terms from the untracked denylist and/or the environment.
TERMS=()
[[ -f .public-safe-denylist ]] && while IFS= read -r t; do [[ -n "$t" && "$t" != \#* ]] && TERMS+=("$t"); done < .public-safe-denylist
IFS=',' read -ra ENVT <<< "${PUBLIC_SAFE_TERMS:-}"; for t in "${ENVT[@]:-}"; do [[ -n "$t" ]] && TERMS+=("$t"); done
for t in "${TERMS[@]:-}"; do
  [[ -z "$t" ]] && continue
  while IFS= read -r f; do
    [[ -f "$f" ]] || continue
    while IFS=: read -r ln _; do [[ -n "$ln" ]] && report "$f" "$ln" "personal term from denylist"; done < <(grep -nIiF -- "$t" "$f" 2>/dev/null)
  done <<< "$FILES"
done
(( ${#TERMS[@]} == 0 )) && echo "  note: no personal-term denylist found (.public-safe-denylist or PUBLIC_SAFE_TERMS). Add your family's names, employer, school and city to catch them."

# Files that should never be tracked in the public repo.
if [[ "$MODE" == "all" ]]; then TRACKED=$(git ls-files 2>/dev/null); else TRACKED="$FILES"; fi
while IFS= read -r f; do
  case "$f" in
    outputs/*.gitkeep) ;;
    outputs/*|dist/*|context/members/*/private/*|.env|*.env|.public-safe-denylist) report "$f" 0 "must not be tracked" ;;
  esac
done <<< "$TRACKED"

echo
if (( FOUND > 0 )); then echo "FAILED: $FOUND finding(s). Replace real details with placeholders (Parent A, [child], example.com), or move them to your private copy."; exit 1
else echo "OK: nothing flagged."; fi
