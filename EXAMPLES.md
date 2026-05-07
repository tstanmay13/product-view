# Examples

Six before/after pairs. The contrast is the point.

---

## 1. Explaining an existing feature — magic-link sign-in

**Prompt:** *Walk me through how our magic-link sign-in works.*

### Without product-view

> The user submits the email form, which POSTs to `/auth/magic-link`. The handler validates the email, generates a signed JWT with a 15-minute TTL, persists it to the `auth_tokens` table, and dispatches a transactional email via SendGrid. When the user clicks the link, `/auth/verify?token=…` validates the JWT, marks the token consumed, sets a session cookie, and redirects to `/dashboard`.

### With product-view (mode: explain)

> They type their email, tap "Send me a link", and the screen says "Check your email." A moment later there's a message in their inbox: "Sign in to [App]". They tap the button inside it, the link opens in their browser, and they land on their dashboard, signed in. The link only works for fifteen minutes and only the once.

What changed: no JWT, no endpoints, no table. The fifteen-minute window stayed because the *user* experiences it (their link sometimes doesn't work).

---

## 2. Reframing a bug ticket with a stack trace

**Prompt:**
*Sentry alert below — what's actually broken for users?*

```
TypeError: Cannot read properties of null (reading 'address')
  at CheckoutShipping.computeTax (CheckoutShipping.tsx:142:23)
  at handleAddressChange (CheckoutShipping.tsx:88:5)
  …
Affected sessions: 1,247 in the last 24h
Browsers: Safari iOS (98%)
```

### Without product-view

> `computeTax` is being called before `address` is set. The error fires in `handleAddressChange` on iOS Safari, likely because of a stale closure or race condition in the address autofill flow. We need to null-check `address` or guard the tax computation.

### With product-view (mode: reframe)

> Customers on iPhones who use Safari's autofill to enter their shipping address are hitting a dead end at checkout. Right after the address fills in, the page goes blank or the tax line breaks — they can't continue and they're not getting a useful error. About 1,250 of them have hit it in the last day. Roughly all of them are on iOS, so this is mostly a mobile shopping problem, and it's at the worst possible moment: they were ready to pay.

What changed: who's affected, where in their journey, and what they see. No mention of `computeTax` or the file. The user doesn't know either of those things exists.

---

## 3. Planning a new feature — and resisting implementation talk

**Prompt:** *We want to let users undo a sent message in our chat product. I'm thinking we soft-delete the row and broadcast a delete event to clients. How should this work?*

### Without product-view

> Sounds good. On send, store messages with a `deleted_at` field. When the sender hits undo within the window, set `deleted_at` and broadcast a `MESSAGE_DELETED` event over the websocket. Clients listen and remove the message from the local cache. You'll want a 30-second window. Watch out for race conditions if the recipient has already opened the conversation…

### With product-view (mode: plan)

> Quick reset to the user side first — implementation can come right after.
>
> The sender taps Send. Their message appears in the thread. For a short window — say thirty seconds — they see a small "Undo" affordance next to the message. If they tap it, the message disappears from their view and from the recipient's view, replaced with a faint "Message removed" placeholder. After the window passes, the affordance goes away and the message is permanent.
>
> The decisions to make first, all in product-space:
>
> - **How long is the undo window?** Affects how often someone undoes vs. wishes they could have.
> - **What does the recipient see while it's still undoable?** The full message (and they might read it), or a delay?
> - **What does the recipient see after an undo?** A placeholder, or nothing at all? (Placeholder is honest; nothing-at-all is cleaner but feels gaslight-y if they were mid-read.)
> - **Does the sender see anything change after they undo?** A confirmation toast?
>
> Once those are settled, the soft-delete + broadcast plan is reasonable — happy to walk through that next.

What changed: I refused to design the implementation first. I named the decisions that have to be made in product-space, because the right data model depends on them.

---

## 4. Mid-conversation drop-in

The conversation has been deep in a debugging session. The user steps back:

**Prompt:** *Ok, view on. Forget the migration script. What does this whole problem actually look like to a user right now?*

### With product-view (persistent on, mode: reframe)

> `Product view: on.`
>
> Right now, anyone who signed up before March 14th and tries to change their email in their profile settings gets a generic "Something went wrong" message and the change doesn't save. They can still log in with their old email — they're not locked out — but they can't update it. New customers (post-March-14) work fine. There's nothing in the UI that hints why some people are affected and others aren't, so support is getting tickets that read like flaky bugs.

The conversation now stays in product-language until the user says `view off`. If they ask about the migration script next, the skill steps out (implementation question) and answers in code-language.

---

## 5. Non-customer audience — a game mechanic from the player's POV

**Prompt:** *In our roguelike, when the player dies, we run a meta-progression update: experience earned during the run is converted to soul-points (clamped at the max), unlocks are re-evaluated, and the run record is committed. New runs read the latest unlock state on init. Walk me through what this looks like to the player.*

### Without product-view

> The death handler fires `onRunEnd`, which serializes the run state, computes the soul-points delta from `experienceThisRun * conversionRate` (clamped to `maxSoulPoints`), patches the persistent profile, evaluates unlock predicates, and commits the run record. The next run reads `playerProfile` on `Run.init()` so unlocks reflect the new state.

### With product-view (mode: explain)

> The player dies. The screen fades and they see a quiet recap: how far they got, what they killed, what they picked up. Underneath, soul-points pour in — they can watch the number tick up to whatever they earned this run, capped at the ceiling. If they cleared a milestone, a new banner slides in: "Unlocked: [thing]". They tap to continue, the menu comes up, and the next time they start a run, the new unlock is already on the table.

What changed: "the player" not "the user". The player's verbs are *dies*, *sees*, *taps*, *watches the number tick up* — visceral, run-specific. No `onRunEnd`, no clamp formula. The clamp is still felt — the soul-points stop ticking up at the ceiling — but it's described as the player experiences it.

---

## 6. Counter-example — the skill correctly does NOT activate

**Prompt:** *This regex is matching way too slowly on inputs over 10kb. I think it's catastrophic backtracking. Can you spot the issue?*

```
^(\w+\s?)*$
```

### Without product-view (correct)

> Yes — that's a textbook catastrophic backtracking pattern. `(\w+\s?)*` is ambiguous: a string like `"aaaaaaaaaaaaaaaaaaaaaaaa!"` can be partitioned in exponentially many ways before the engine concludes none of them match the trailing `$`. Each `\w+` overlaps with the next, and the optional `\s?` doesn't disambiguate. The fix is to make the alternatives non-overlapping. Try:
>
> ```
> ^\w+(\s\w+)*$
> ```
>
> …which forces a clear "word, then optional `whitespace+word`" structure. No ambiguity, no backtracking.

### Why product-view stayed off

This is a regex performance question. There is no human on the other side of the screen experiencing the regex — it's purely inside the code. Forcing a "user perspective" on it would either fabricate a user ("the user is frustrated by slowness") or refuse to answer the actual question. The skill's `Do NOT use for` clause covers exactly this case.

If the user follows up with *"and what does this look like to a customer who hits the slow path?"*, then the skill activates for that follow-up. Performance hits a customer in product-space when it gets bad enough to be visible — but you only describe that when asked.
