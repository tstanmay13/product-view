# Contributing to product-view

Two contribution types are by far the most useful, because they're the two failure modes the skill exists to handle:

1. **The view leaked.** Code-language slipped through into product-view output. (e.g. Claude said "the API returns" while the lens was active.)
2. **Activation misfire.** The skill activated when it shouldn't have, or didn't activate when it should have.

Both are fixable. File a GitHub issue with a reproducible prompt and we'll either tighten the strip list, refine the activation rules, or — if the case is genuinely ambiguous — document it.

## Filing a view-leak report

Use the [view-leak issue template](.github/ISSUE_TEMPLATE/view_leak.md). At minimum we need:

- The exact prompt you sent.
- The full response (or the specific sentence(s) where code-language leaked).
- The word(s) you'd consider code-language.
- Optional: what you wish the skill had said instead.

Concrete prompts beat abstract complaints. *"It said 'the system handles this' on this prompt"* is fixable. *"It feels too technical sometimes"* is hard to act on.

## Filing an activation issue

Use the [activation issue template](.github/ISSUE_TEMPLATE/activation.md). Tell us:

- The exact prompt.
- Whether the skill activated or not.
- Whether you think it should have.
- Why (which trigger phrase fits, or which do-not-use-for clause covers it).

If the right answer is "it depends on the surrounding conversation", paste the prior turn or two as well.

## Improving the strip list

`references/strip-list.md` grows. If you find a code-word that consistently leaks, add it to the "always strip" list with an example substitution. PRs welcome.

If you find a word people *think* is code-language but is actually fine (the user uses it, the UI shows it), add it to "always fine" with a brief justification.

## Improving the examples

`EXAMPLES.md` is the single best place to make the skill more concrete for new users. If you have a real before/after that's clearer than what's there, open a PR. New examples are most useful when they cover an audience or domain not yet represented (the current set covers SaaS, e-commerce, chat, and a roguelike — gaps include health, finance, education, and developer tools).

## What we don't need

- Stylistic rewrites of SKILL.md without a concrete failure case behind them.
- New sub-modes. Three modes is the design — adding a fourth has to come with a clear gap the existing three don't cover.
- Conversion of the skill into a script-based / file-generating tool. That's a different skill (`code-to-prd` already exists for that).

## Code of conduct

Be specific. Be kind. If a contribution disagrees with a design decision, explain the case in product-language: who's affected, what they're trying to do, what they hit. (We eat our own dog food on this repo.)
