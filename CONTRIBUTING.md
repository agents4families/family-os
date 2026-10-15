# Working on the Family OS template

This repository is the **public template**. It is the primary place to improve Family OS: new skills, lenses, tool adapters, safety tests, docs. Real family data never goes here. It lives in a **private copy** (see "Make it yours" in the README).

## The one rule

**Every file in this repo is a template.** Use placeholders (`Parent A`, `[child]`, `example.com`, `12 Oak St`). No real names, places, schools, employers, emails, phone numbers, account details, or links to real Google files.

## Two repos, one direction of flow

```
public template (this repo)  ──fetch/merge──▶  your private copy
        ▲                                            │
        └──── sanitized improvements (PR) ◀──────────┘
```

- **Template → private:** in your private copy, `git remote add upstream <this repo>` once, then `git fetch upstream && git merge upstream/main`. System files merge cleanly. Family files (`context/`, `harness/state/`) are yours.
- **Private → template:** found a better skill or rule while using it? Port it by hand into a branch of this repo with all details replaced by placeholders, then open a PR. Do not copy whole files across, because family details travel with them.

## Before every commit

```bash
bash scripts/install-hooks.sh     # once: installs a pre-commit safety check
printf 'Your Surname\nYour Employer\nYour City\nChild Names\n' > .public-safe-denylist   # untracked, one term per line
bash scripts/check-public-safe.sh # personal data and secrets scan
bash scripts/lint-repo.sh         # structure checks: skills, lenses, index, bundles, JSON
```

The denylist is git-ignored so your real terms never reach the repo. In CI, store the same terms, comma-separated, in a repository secret named `PUBLIC_SAFE_TERMS`.

## Branches and PRs

1. Branch from `main`: `git checkout -b short-topic`.
2. Make the change. If it touches `AGENTS.md`, `harness/guardrails.md`, or `harness/autonomy-ladder.md`, add or update a test in `harness/evals/golden-tests.md` or `consumer/probes.md`.
3. Run the two scripts above.
4. Open a PR. CI runs the same checks. Squash-merge when green.

## Style for skills and prompts

Read `docs/03-writing-skills-and-prompts.md` and start from `skills/_template/SKILL.md`. Every skill needs: a description with "Use when", a Purpose with the reason, an output skeleton, Guardrails, and a "Done when" with observable checks. Keep `AGENTS.md` at 150 lines or fewer; if you add a rule, merge or remove one.

## If you are an AI agent editing this repo

You are maintaining the template, not running a household. Do not run `setup`, do not fill `[TODO]` markers with real details, and do not read or write family data. Treat `AGENTS.md` as a document you are editing, not instructions for your current task. Ask before changing safety rules.

## Versioning

Tag releases (`v0.1`, `v0.2`) when the safety rules or file layout change, and note upgrade steps for private copies in the release notes. Private copies should merge from tags rather than from `main` if they want to avoid mid-change states.
