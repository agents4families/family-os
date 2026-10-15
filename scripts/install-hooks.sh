#!/usr/bin/env bash
# Installs a git pre-commit hook that blocks commits containing personal or secret-looking data.
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
cat > .git/hooks/pre-commit <<'HOOK'
#!/usr/bin/env bash
exec bash scripts/check-public-safe.sh --staged
HOOK
chmod +x .git/hooks/pre-commit scripts/*.sh
echo "Installed .git/hooks/pre-commit. Create .public-safe-denylist (untracked) with your family's names, employer, school and city, one per line."
