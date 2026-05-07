# product-view

A Claude Code skill that flips Claude out of code-language and into product-language — describing what the human on the other side of the screen experiences — until you explicitly ask for the code.

## Before / after

**Without product-view:**
> When a user signs in, the auth middleware validates the JWT, hits the `/me` endpoint to fetch the user record, and dispatches a `LOGIN_SUCCESS` action. The frontend then mounts the dashboard route and the API begins polling for unread notifications.

**With product-view:**
> They tap "Sign In", type their email and password, and a moment later they're looking at their dashboard. A small red dot appears on the bell icon — they have unread messages.

Same flow. The first describes the code. The second describes what actually happened to the person.

## What this is

A **conversational mode**. You flip it on and Claude stays in product-space — what the user sees, what they do, what changes for them, what they feel — until you flip it off or explicitly ask for the code.

Three sub-modes:

| Mode | Use when | You get |
|---|---|---|
| **explain** | You want a walkthrough of an existing feature | What the user experiences end-to-end |
| **reframe** | You have a bug, ticket, PR, or stack trace | Customer impact in plain terms |
| **plan** | You're sketching new functionality | The user's goal and journey, before any implementation |

## What this isn't

| Other skill | What it does | Why this is different |
|---|---|---|
| [`code-to-prd`](https://github.com/alirezarezvani/claude-skills/tree/main/product-team/code-to-prd) | One-shot scan of a repo → writes PRD `.md` files | `product-view` is a live conversational mode, not a document generator |
| Sachin Rekhi's [release-notes skill](https://www.sachinrekhi.com/p/claude-code-for-product-managers) | Commit URL → user-facing release note | `product-view` works on any artifact (code, ticket, idea), at any time, not just at ship-time |
| [`mattpocock/skills` `zoom-out`](https://github.com/mattpocock/skills/tree/main/skills/engineering/zoom-out) | Zooms up within code (modules, callers, glossary) | `zoom-out` stays inside code; `product-view` zooms *out of code entirely* |
| Multi-perspective code review (e.g. [Review Squad](https://github.com/2389-research/review-squad)) | Multi-subagent panel reviews from several personas | `product-view` is single-agent, in-line, and the user perspective is the *only* lens |
| [`wondelai/skills`](https://github.com/wondelai/skills) (JTBD, lean-startup, etc.) | Teach and apply strategic product frameworks | `product-view` operates on whatever's in context; no framework prescribed |

If you want a generated PRD, a release note, a multi-persona review, or a strategic exercise, those skills exist and they're better at their thing than `product-view` would be. This skill does one move: it stops the conversation from sneaking code-language into descriptions of the product.

## Install

The skill ships as a Claude Code plugin. From inside Claude Code:

```
/plugin marketplace add tstanmay13/product-view
/plugin install product-view@tstanmay13-product-view
```

Or, for a manual install, clone into `~/.claude/skills/`:

```bash
git clone https://github.com/tstanmay13/product-view.git ~/.claude/skills/product-view-repo
ln -s ~/.claude/skills/product-view-repo/skills/product-view ~/.claude/skills/product-view
```

## How to use it

### Three activation modes

**On-demand** — say any of these and the skill kicks in for that turn:

- `/product-view`
- "from the product perspective"
- "as a user flow"
- "what does this look like to the user / customer / player / reader"
- "translate this"
- "in plain terms"
- "outside-in"

**Persistent** — turn it on and leave it on:

```
view on
```

It stays on for every subsequent message. Turn off with:

```
view off
```

**Auto-activation** — when you ask Claude to explain a feature, walk through how something works, plan new functionality, or summarize a bug ticket, the skill activates on its own. This is intentional: most software explanations are improved by leading with the product view.

It explicitly does **not** auto-activate on algorithmic, performance, infrastructure, or code-style questions. See [When NOT to use it](#when-not-to-use-it).

### Audience flexibility

The "user" isn't always called "user". The skill picks the right word for the context:

- B2B SaaS → customer
- Game → player
- Blog / CMS → reader
- LMS → student
- Health → patient
- Developer product → the developer using your API

If it isn't obvious, the skill asks once.

## Why a skill and not just a prompt

You could prompt Claude every turn with "describe this from the user's perspective." That works for one message. The skill adds four things you'd otherwise have to re-prompt for, every time:

1. **The strip discipline** — an enumerated list of code-words to remove (`references/strip-list.md`). This is what stops the view from leaking. Without it, "the API returns" sneaks back in within three turns.
2. **Persistence** — `view on` keeps the lens active for the whole conversation. No repeat-prompting.
3. **Auto-trigger** — explanation and feature-planning conversations get the lens by default, even when you don't think to ask.
4. **Clean separation** — when you need both views, the skill formats them as separate sections instead of blending. A blended description is the failure mode.

If you've ever read a "user story" that was secretly an architecture diagram, you know why this exists.

## When NOT to use it

Stay in code-language when the question is:

- Algorithmic (sorting, search, complexity, big-O)
- Performance (memory, latency, profiling)
- Internal infrastructure (CI, build pipelines, deploy, container orchestration)
- Code style, refactoring, linting
- Library or framework selection on technical merits
- Debugging the user is doing themselves at the code level

For these, the right altitude is the code, not the product. Forcing a "user perspective" on a regex-performance question makes the answer worse.

## Examples

See [EXAMPLES.md](EXAMPLES.md) for seven before/after pairs covering explanation, reframing, planning, mid-conversation drop-ins, a non-customer audience (a game player), the skill stepping out of the lens for a critical code-side detail, and a counter-example showing the skill correctly *not* activating.

## Related skills

- [`alirezarezvani/claude-skills` — `code-to-prd`](https://github.com/alirezarezvani/claude-skills) — generate a PRD document from a codebase
- [`mattpocock/skills`](https://github.com/mattpocock/skills) — `zoom-out`, `grill-with-docs`, and others; the closest stylistic neighbor
- [`wondelai/skills`](https://github.com/wondelai/skills) — strategic product frameworks (JTBD, lean-startup, etc.)
- [`deanpeters/Product-Manager-Skills`](https://github.com/deanpeters/Product-Manager-Skills) — full PM workflow (discovery, RICE, OKRs, PRDs)
- [`rohitg00/awesome-claude-code-toolkit`](https://github.com/rohitg00/awesome-claude-code-toolkit) — multi-perspective subagent reviews

## Conceptual roots

The discipline isn't new. The skill borrows labels from places this instinct has lived before:

- **Outside-in** — Dan North's framing of BDD: describe what's observable to the user before touching internals.
- **Fat marker sketch** — Ryan Singer (Shape Up): draw at a resolution that physically prevents implementation detail.
- **Forcing function** — Bryar & Carr (*Working Backwards*): write the press release first; the structure does the work.
- **Job story** — Alan Klement's JTBD template ("When [situation], I want to [motivation], so I can [outcome]") deliberately has no implementation slot.
- **Feature factory / language hack** — John Cutler: consciously substitute outcome words for output words.

`product-view` is none of these specifically. It's the small move all of them share.

## Contributing

Two contribution types are most useful:

1. **The view leaked.** A prompt where the skill let code-language slip through. File via the [view-leak issue template](.github/ISSUE_TEMPLATE/view_leak.md).
2. **Activation misfire.** The skill activated when it shouldn't, or didn't activate when it should. File via the [activation issue template](.github/ISSUE_TEMPLATE/activation.md).

Details in [CONTRIBUTING.md](CONTRIBUTING.md).

## License

[MIT](LICENSE).
