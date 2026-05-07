# Tests

These are **prompt-level test cases**, not automated tests. Each case in `cases/` is a prompt + the behavior you'd expect when the skill is installed and active.

## How to run them

There's no test runner. To exercise a case:

1. Install the skill (see the repo [README](../README.md)).
2. Open Claude Code in any directory.
3. Send the prompt verbatim.
4. Compare the response to the case's expected behavior.

If a case fails, file an issue with the [view-leak](../.github/ISSUE_TEMPLATE/view_leak.md) or [activation](../.github/ISSUE_TEMPLATE/activation.md) template.

## What the cases cover

| # | File | Tests |
|---|---|---|
| 1 | `01-explain-feature.md` | Activation on a "walk me through" prompt; clean explain output |
| 2 | `02-reframe-bug.md` | Activation on a stack trace; reframe mode; customer-impact framing |
| 3 | `03-plan-feature.md` | Refusal to design implementation first when given an idea |
| 4 | `04-view-persistence.md` | `view on` persists across multiple turns |
| 5 | `05-view-off.md` | `view off` ends the mode and Claude returns to normal behavior |
| 6 | `06-no-trigger-algorithmic.md` | Skill correctly does NOT activate on a pure code question |
| 7 | `07-mixed-request-separation.md` | Mixed product+code request → cleanly separated sections |
| 8 | `08-non-customer-audience.md` | Audience flexibility — vocabulary fits a non-"user" audience |

## Grader notes

The most common failure modes:

- **Strip discipline leak** — words like "the system", "the API", "we then …" sneaking back in. Look at the literal nouns and verbs, not the overall vibe.
- **Implementation-first planning** — in plan mode, did Claude jump to "we'll add a Redis cache"? It shouldn't.
- **Blended views** — when both views are needed, they should be in clearly separated sections, never interleaved sentence-by-sentence.
- **Wrong audience word** — defaulting to "user" when "player" or "reader" or "patient" would fit better.
- **Wrong mode** — using explain mode on a stack trace (should be reframe), or plan mode on a shipped feature (should be explain).
