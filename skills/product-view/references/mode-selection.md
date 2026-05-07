# Mode selection — explain / reframe / plan

Three sub-modes, one rule for picking each. Use this when the user's intent is ambiguous.

## The three modes at a glance

| Mode | The user has | They want |
|---|---|---|
| **explain** | An existing feature, code, or shipped behavior | A walkthrough of what it looks like from the outside |
| **reframe** | A bug report, ticket, PR, or stack trace | The customer impact in plain terms |
| **plan** | An idea for new functionality | The user's goal and journey, before any code |

## Picking by signal

### Signals that mean **explain**

- "How does X work?"
- "Walk me through [feature]"
- "What happens when a user does Y?"
- "Explain the [auth/checkout/onboarding/sharing] flow"
- The user pastes existing code or points at a file and asks what it does for the user.
- They mention an already-shipped feature and want to understand it from the outside.

### Signals that mean **reframe**

- The user pastes a stack trace, log line, or error.
- The user pastes a bug ticket or Sentry/Datadog link.
- The user pastes a PR title or diff and asks "what does this fix" or "what changes for users?"
- "What's the customer impact of [bug/incident]?"
- "How would I explain this to support?"
- The conversation has been deep in code-debugging and the user pulls back: "ok so what does this actually look like to the user?"

### Signals that mean **plan**

- "I'm thinking about adding…"
- "We want to let users…"
- "What if we [new behavior]?"
- "How should [new feature] work?"
- The user has *no existing artifact* — only an idea.
- The user is describing something that doesn't exist yet, even if they're using implementation language for it.

## Ambiguous cases — worked examples

### "Walk me through how billing works"
- If the system exists → **explain**.
- If the user is sketching a future billing system → **plan**.
- Default to **explain** unless the user's wording is future-tense ("how billing *should* work").

### User pastes code and asks "is this right?"
- If they mean *correct from the user's perspective* (does it produce the right outcome) → **explain** + light reframe.
- If they mean *technically correct* (algorithm, edge cases, performance) → this skill probably shouldn't be active. They want code review, not product view.
- Tie-breaker: ask once, "do you want this from the user's side or from the code's side?"

### User pastes a stack trace and a feature request in the same message
- Two modes wanted. Do **reframe** on the stack trace, then **plan** on the feature request, separated by a header. Don't blend them.

### User describes a feature in implementation terms
*"We'll add a Redis cache so that profile pages load faster."*
- Treat as **plan**. Restate the user goal first: *the user opens someone's profile and the page comes up right away, no spinner, no stale info.* Then — only if the user asks — get into the cache.
- Refusing to design implementation first is the whole point of plan mode. Don't skip it because the user already proposed an implementation.

### User asks "what is X?"
- If X is a product feature → **explain**.
- If X is an internal concept (a service, a queue, a library) → this skill probably isn't the right mode. Stay in code-language.

### User pastes a long PR description with both customer-facing and internal changes
- **reframe** on the customer-facing pieces. Skip the internal ones (refactors, dependency bumps, build changes) unless the user asks. Don't pretend internal changes have customer impact when they don't.

### User says "explain this"
- Ambiguous: explain to whom? If the prior conversation was about a feature → **explain**. If it was about a bug → **reframe**. If it was about a future idea → **plan**. If you genuinely can't tell, ask once.

## Defaults when truly stuck

If you cannot tell from context which mode fits, default in this order:

1. If there's an artifact in the message (code, ticket, trace) → **reframe** on existing, **explain** on new feature, **plan** on idea.
2. If the user's verb is past or present tense ("does", "did") → **explain**.
3. If the user's verb is future or hypothetical ("would", "should", "could", "want to") → **plan**.
4. Otherwise: **explain**.

## Switching modes mid-conversation

The user can move between modes freely. Track the switch silently — don't announce *"switching to plan mode"* on every turn. The mode is a tool, not a label the user has to manage.

If the *user* explicitly requests a different mode ("forget the bug, what would the redesigned flow look like?"), switch and pick up where they pointed.
