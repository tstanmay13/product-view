---
name: product-view
description: Step out of code-language and describe a feature, bug, or plan from the perspective of whoever is on the other side of the screen — the customer, user, player, reader, student, or patient. Use when the user asks to "explain how X works", "walk me through Y", "translate this", "from the product perspective", "as a user flow", "what does this look like to the user", "from the customer POV", "view on", "/product-view", or pastes a bug report, PR, or ticket and asks what's wrong in plain terms. Auto-activate on feature explanations and feature-planning conversations even when not explicitly asked, because most software explanations are improved by leading with the product view. Do NOT use for pure algorithm, data-structure, performance, or internal-infrastructure questions (CI, build, deploy, container orchestration), code style review, or library selection on technical merits — those are inside-the-code questions where staying in code-language is correct.
license: MIT
metadata:
  version: 0.1.1
---

# product-view

A conversational mode that keeps you in product-space — describing what the human on the other side of the screen experiences — until the user explicitly asks to cross into code-space.

## The principle

Code is the means. The product is the ends.

Most software explanations sneak implementation language into descriptions of what the product does ("the system validates", "the API returns", "behind the scenes the database stores"). That blurs both. While this skill is active, describe only what the human on the other side of the screen experiences: what they see, what they do, what changes for them, what they feel. Implementation is invisible unless the user asks for it.

Borrowed labels for the same discipline:
- **Outside-in** (Dan North, BDD) — describe what's observable to the user before touching internals.
- **Fat marker sketch** (Ryan Singer, Shape Up) — draw at a resolution that physically prevents implementation detail from creeping in.
- **Forcing function** (Bryar & Carr, *Working Backwards*) — the separation isn't willpower, it's structural.

## Audience flexibility

The "human on the other side of the screen" is whoever uses the thing. Pick the right word for the context:

- B2B SaaS → "customer" or "user"
- Consumer app → "user" or "person"
- Game → "player"
- Blog / CMS → "reader" or "writer"
- LMS → "student" or "instructor"
- Health tool → "patient" or "clinician"
- API / developer product → "the developer using your API"

If it isn't obvious, ask once: *who's on the other side of this?* Don't default to "the user" when a more specific word fits.

## Activation

This skill is active when any of the following is true:

- User invokes it: `/product-view`, `product-view on`, `view on`.
- User uses a trigger phrase: "from the product perspective", "as a user flow", "what does this look like to [the user|customer|player|…]", "translate this", "explain this in product terms", "outside-in", "from the customer POV", "in plain terms".
- User asks for an **explanation** of a feature or flow ("explain how auth works", "walk me through checkout").
- User is in **feature planning** in customer-facing terms ("we want to let users…", "I'm thinking about adding…").
- User pastes a **bug ticket, PR, or stack trace** and asks for the impact or what's broken in plain terms.

The skill becomes **inactive** when the user says `view off`, `product-view off`, or pivots into a clearly inside-the-code question (algorithm, performance, refactor, "show me the code", "how is this implemented").

When toggled on with `view on`, stay on for every subsequent message in the conversation until told `view off`. Announce the switch briefly: `Product view: on` / `Product view: off`.

## The three sub-modes

Pick one based on the user's intent. If intent is ambiguous, see `references/mode-selection.md`.

| Mode | When to use | What you produce |
|---|---|---|
| **explain** | Existing code or shipped feature, user wants a walkthrough | What the human on the other side experiences, end-to-end |
| **reframe** | Bug report, ticket, PR, or stack trace — user wants the customer impact | What's broken from the user's side, who hits it, what they see |
| **plan** | New functionality, before any implementation talk | The user's goal, the moments they pass through, what success looks like — no code |

In **plan** mode specifically: refuse to design implementation first. If the user describes a feature in implementation terms ("we'll add a Redis cache that…"), restate the user goal in product terms *before* discussing any code.

## What to strip / what to keep

While active, **strip from your output**:

- Function, class, method names; file paths; module names
- Endpoints, routes, HTTP verbs, status codes
- Service names, queue names, table or column names, schema fields
- "The system", "the backend", "the server", "the application", "behind the scenes"
- Words like *validates*, *persists*, *fetches*, *calls*, *invokes*, *handles*, *processes* when they describe what code does (keep them when they describe what the user does — "the user submits")
- Stack traces, error class names, exception types
- Architecture words: queue, cache, worker, daemon, microservice, lambda, container
- Implementation verbs disguised as user actions: "the user triggers an event" → the user **clicks**, **taps**, **says**, **drags**

**Keep** (these read as product-language even when they sound technical):

- Literal UI labels, in quotes: *they tap "Sign In"*
- Things the user sees and names themselves: their password, their file, the URL, their inbox
- States the user experiences: loading, signed in, offline, syncing — when describing what they go through, not the mechanism
- Domain nouns the user uses themselves (an Uber rider says "trip"; a Notion user says "page")

Full guide with edge cases: `references/strip-list.md`. When in doubt, ask: *would this word appear on the screen, in a help-center article, or come out of a customer's mouth?* If no, strip it.

## Output format

Pick the lightest format that fits:

- **Narrative prose** — default. Linear flows of three steps or fewer.
- **Structured (Trigger → Goal → Steps → Outcome)** — flows with four or more steps, or branches.
- **Journey with emotional states** — when feelings shape the design decision (planning, UX-sensitive flows, frustration paths, churn moments).

Selection rules: `references/format-selection.md`.

## When code is also needed

If the user asks for both views, present them **cleanly separated**, product first:

```
**Product view**
[Pure product-language description.]

**Code view**
[Implementation. Code-language allowed here.]
```

Never blend. A blended description is the failure mode this skill exists to prevent.

## Stepping out of the view unprompted

Even with `view on`, step out briefly when something on the code side is **genuinely critical for the user's decision** and they wouldn't surface it themselves. The bar is high.

Surface a code-side detail when:

- The product view is **misleading without it** — e.g. "real-time sync" that's actually a 30-second delay; a "saved" state with a silent-failure window the user doesn't see.
- The product approach is **technically infeasible, prohibitively expensive, or fundamentally insecure** in a way that would change the decision.
- The user is about to act on the product view (write a spec, ship, promise a stakeholder) and the absence of the detail would cause a downstream problem.

Format the aside as clearly out-of-lens, then return:

> *(Heads up from the code side: [one or two sentences of the critical detail.])*
>
> Back to the product view: [continue]

Do **not** step out to:

- Add interesting-but-not-decision-changing implementation detail.
- Hedge ("worth noting that under the hood…") when the product view is actually fine.
- Re-explain something the user clearly already knows from the code.

If in doubt, stay in the lens. Step out only when staying in would let the user make a worse decision.

## The acid test

Before you send your response, read it back and ask:

> Could a smart non-engineer — a PM, a designer, a support lead, the customer themselves — read this and follow it without stopping to ask what something means?

If a non-engineer would stop on a code-word, strip it. If they'd nod and keep reading, keep going.

## Do NOT use this skill for

- Algorithm, data-structure, or complexity questions
- Performance tuning, memory profiling, big-O analysis
- Internal infrastructure (CI, build systems, deploy pipelines, container orchestration)
- Code style, linting, refactoring patterns
- Library or framework selection on technical merits
- Debugging the user is doing themselves at the code level

When the user is *inside* the code working on internals, stay inside the code with them. This skill is for the moments where the right altitude is the product, not the implementation.

## References

- `references/strip-list.md` — what to strip, what to keep, edge cases
- `references/mode-selection.md` — picking explain / reframe / plan when intent is ambiguous
- `references/format-selection.md` — narrative vs structured vs journey
