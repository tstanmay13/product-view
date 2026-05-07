# Strip list — what to remove, what to keep, edge cases

This is the long version of the discipline summarized in SKILL.md. Use it when you're unsure whether a word belongs in product-view output.

The single test: **would this word appear on the screen, in a help-center article, or come out of a customer's mouth?** If no, strip it.

## Always strip

These never belong in product-view output, no matter how casually they were used in the source:

| Category | Examples |
|---|---|
| Code identifiers | function names, class names, method names, file paths, module names, package names, type names |
| Network / protocol | endpoints, routes, URLs as paths (`/api/v2/users`), HTTP verbs (`POST`, `GET`), status codes (`401`, `500`), payloads, headers |
| Storage | table names, column names, schema fields, indexes, foreign keys, "the database", "the row", "the record" |
| Architecture | queue, cache, worker, daemon, microservice, lambda, container, load balancer, gateway, sidecar |
| Generic placeholders for code | "the system", "the backend", "the server", "the application", "the application logic", "behind the scenes", "under the hood" |
| Errors as objects | stack traces, exception class names (`NullPointerException`), error codes as identifiers (`ERR_AUTH_03`) |
| Implementation verbs (when about code) | validates, persists, fetches, calls, invokes, handles, processes, mutates, hydrates, serializes, parses |
| Pseudo-user actions | "triggers an event", "fires a callback", "dispatches an action", "emits", "subscribes" — replace with what the human actually does (clicks, taps, drags, types, says) |

## Always fine

These read as product-language even when they sound technical, because the user experiences them or names them:

| Category | Examples |
|---|---|
| Literal UI labels in quotes | They tap **"Sign In"**. The screen says **"Trip cancelled"**. |
| Things the user sees and owns | their password, their email, their file, their inbox, their photo, their playlist, the URL they shared |
| Visible states | loading, signed in, signed out, offline, syncing, saved, draft, published, archived (when describing the user's experience of the state) |
| Domain nouns the user uses | trip (Uber), page (Notion), card (Trello), commit (GitHub for a developer-user), playlist (Spotify), order (any e-commerce) |
| Generic verbs of doing | clicks, taps, types, drags, scrolls, swipes, says, points, looks, waits, sees |

## Depends — judgement calls with rules

### "Loading"
- ✅ *They see a loading spinner.* — describing the user's experience.
- ❌ *The page loads from the server.* — describing the mechanism.
- Rule: keep if the word describes what the human waits through. Strip if it describes where the data came from.

### "Saving"
- ✅ *Their changes are saved automatically.* — visible behavior.
- ❌ *We save it to Postgres on every keystroke.* — implementation.
- Rule: same as loading.

### "Signed in" / "Logged in"
- ✅ Always fine. The user names this state themselves.

### Button labels
- ✅ *They tap "Submit".* — quoting what's on the screen.
- ❌ *The submit handler fires.* — quoting the code.

### "The URL"
- ✅ Fine. Users send URLs to each other.
- ❌ "The endpoint" / "the route" / "the path parameter" — code-side names for the same thing.

### "The file"
- ✅ Fine. Users have files.
- ❌ "The file descriptor", "the blob", "the upload object" — code-side names.

### "Validation"
- ✅ *The form tells them their email isn't valid.* — the user-visible result.
- ❌ *We validate the email format with a regex.* — the mechanism.
- Substitute: *the form rejects it / the form tells them what's wrong / they see an error.*

### "Notification"
- ✅ *They get a notification on their phone.* — what the user receives.
- ❌ *We push a notification via FCM.* — how it gets delivered.

### "Sync"
- ✅ *Their changes show up on their other devices.* — the user-visible outcome.
- ❌ *The sync engine reconciles on next connect.* — the mechanism.

### "Account"
- ✅ Always fine. Users have accounts.

### "Search"
- ✅ *They search for a song.* — the action.
- ❌ *We hit the search index with a fuzzy query.* — the mechanism.

### "Refresh"
- ✅ *They pull to refresh.* — the user gesture.
- ❌ *We refetch the cached resource.* — the mechanism.

### "Permission"
- ✅ *They don't have permission to edit this doc.* — the user-visible state.
- ❌ *The auth middleware rejects the request.* — the mechanism.

### Numbers, limits, quotas
- ✅ *They can have up to 100 boards.* — visible to the user.
- ❌ *The rate limit is 1000 req/min on this endpoint.* — internal limit, not user-visible (unless the user hits it, in which case describe what they see, not the limit itself).

## Substitutions cheat-sheet

| If you wrote | Try |
|---|---|
| The system validates the email | The form tells them whether the email looks right |
| The API returns a 401 | They're sent back to the sign-in screen |
| The database stores their preferences | Their settings stick the next time they come back |
| The auth middleware rejects | They see "you don't have access to this" |
| We dispatch an event | They see [the result] right away / a moment later |
| The cache is invalidated | The fresh version shows up on their next refresh |
| Behind the scenes, we encrypt | Their messages are private — only they and the recipient can read them |
| The endpoint returns | They see |
| The job runs every hour | Once an hour, [user-visible thing] happens |
| The server-side render | The page loads with their content already on it |

## Audience-specific words

Once you know who's on the other side, prefer their vocabulary over generic "user":

- Game → **player**, level, run, save, lobby, match, life, score
- Music app → **listener**, track, playlist, queue, station
- Health → **patient** or **clinician**, visit, prescription, refill, dose
- Education → **student** or **instructor**, lesson, assignment, course, grade
- Marketplace → **buyer** / **seller**, listing, order, refund, dispute
- Developer product → **the developer**, request, key, token, dashboard, log

If the user's product has a glossary or domain language, use it. The closer your words are to the user's words, the better the view.

## Counter-list — terms to always strip even when casual

These slip through often. None of them belongs in product-view output:

- "the system" (any sentence with "the system" can be rewritten without it)
- "the backend" / "the server"
- "behind the scenes" / "under the hood"
- "we then [verb]" — *we* are the implementers, not the user
- "the request" / "the response"
- "the database", "the row", "the record"
- "the event" (unless the user calls it an event, e.g. a calendar event)
- "the handler", "the listener", "the callback"
- "the worker", "the job", "the task" (when it means a background process)
- "the client" — when it means client-side code (fine when it means the customer)
- "the service"
