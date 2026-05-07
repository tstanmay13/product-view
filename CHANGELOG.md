# Changelog

All notable changes to the `product-view` skill are documented here.

This project follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] — 2026-05-07

Initial release.

### Added
- `skills/product-view/SKILL.md` — the skill itself, with auto-activation triggers, manual `view on` / `view off` toggle, three sub-modes (explain, reframe, plan), and explicit do-not-use-for clauses.
- `references/strip-list.md` — the strip discipline: code-language to remove, product-language to keep, judgement-call edge cases, substitution cheat-sheet, and audience-specific vocabulary.
- `references/mode-selection.md` — heuristics for picking explain / reframe / plan when intent is ambiguous, with worked examples.
- `references/format-selection.md` — narrative vs structured vs journey, with an upgrade/downgrade rule and anti-patterns.
- `EXAMPLES.md` — six before/after pairs covering explanation, reframing, planning, mid-conversation drop-in, a non-customer audience (a game player), and a counter-example showing correct non-activation on a regex performance question.
- Plugin manifest at `.claude-plugin/plugin.json` for marketplace install.
- GitHub issue templates for view-leak reports and activation misfires.
- Eight test cases under `tests/cases/`.
