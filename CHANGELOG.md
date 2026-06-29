# Changelog

All notable changes to the `product-view` skill are documented here.

This project follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.3] — 2026-06-26

### Changed
- Tightened the auto-activation clause in the description: it now scopes to *user-facing* feature explanations and explicitly excludes internal components (a service, a queue, an algorithm), which stay in code-language. A triggering eval (3 independent judges per query) found the broad "most software explanations" rationale occasionally misfired on internal-component questions like "summarize what this microservice does" (fired 1/3). After the change, that and the other boundary splits (rate limiter, recommendation algorithm) resolved to consensus "no" with no regression on genuine user-facing triggers.

## [0.1.2] — 2026-06-26

### Added
- New SKILL.md guidance for **explain** and **reframe** mode: **ground before you translate.** When the feature or bug actually exists, read the real artifact (code, ticket, trace) before describing it, so the product-language description is *true* rather than a plausible-sounding reconstruction from the feature's name. Surfaced by an eval run where the skill produced a generic flow instead of grounding in the actual feature — a confident-but-wrong journey is a fluency trap that's harder to catch than a leaked code-word.

## [0.1.1] — 2026-05-07

### Added
- New SKILL.md section: **Stepping out of the view unprompted**. Even with `view on`, the skill now permits Claude to surface a brief code-side aside when a critical technical detail would change the user's decision (misleading product view, infeasibility, security/privacy issue). High bar: the default is to stay in the lens; the aside is formatted as clearly out-of-lens and returns to product-view immediately.
- New EXAMPLES.md entry (#6): a planning conversation where the skill steps out of the lens for one paragraph to flag that the user was about to promise "real-time sync" to a customer when the implementation only supports eventual sync.

### Changed
- Marketplace `source` now uses the explicit `{ "source": "github", "repo": "..." }` object form instead of the `"."` shorthand, for compatibility with older Claude Code versions.

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
