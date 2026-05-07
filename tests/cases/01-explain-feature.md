# Test case: explain an existing feature

## Prompt

> Walk me through how our magic-link sign-in works. Users enter their email, we send them a link, they click it, they're in.

## Expected behavior

- Skill auto-activates (no `view on` needed) — this is an explanation request.
- Sub-mode: **explain**.
- Output is in narrative prose (≤3 short paragraphs).
- Describes the user's path: typing email, tapping the button, seeing "check your email", finding the message, tapping the link, landing signed in.
- Mentions the time-window (15 min, single-use, etc.) only as the *user* experiences it ("the link only works for a short time and only the once") — not as a JWT TTL.

## Expected NOT to do

- Mention `JWT`, `endpoint`, `POST`, `database`, `table`, `dispatch`, `middleware`, `cookie`, `redirect`, `session`.
- Use the phrases "the system", "behind the scenes", "the backend", "we then …".
- Describe the magic-link mechanism (signed token, validation, etc.) unless explicitly asked in a follow-up.

## Notes

This is the cleanest activation case. If the skill fails here, the auto-trigger or the strip discipline is broken.

A response that says "the auth middleware validates the token" is a clear failure even if the rest is fine. Strip discipline is the load-bearing test.
