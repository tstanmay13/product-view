# Test case: plan a feature, resist implementation-first

## Prompt

> We want to let users undo a sent message in our chat product. I'm thinking we soft-delete the row and broadcast a delete event to clients. How should this work?

## Expected behavior

- Skill auto-activates (feature-planning conversation, customer-facing surface).
- Sub-mode: **plan**.
- Output **restates the user goal first** in product terms: the sender taps Send, then for some short window has an "undo" affordance, taps it, the message disappears for them and the recipient.
- Output **names the open product-side decisions**: how long the window is, what the recipient sees during and after, what the sender sees on undo.
- Only AFTER the product side is laid out does the response acknowledge the soft-delete + broadcast plan as reasonable, and it does so briefly. The body of the response is product-side.

## Expected NOT to do

- Jump straight into discussing the soft-delete approach, the websocket event shape, race conditions on the recipient side, or `deleted_at` columns as the *first* response.
- Conflate the implementation question and the product question into one blended answer.
- Skip the "what does the recipient see" question — that's the design-load-bearing decision.

## Notes

This is the highest-failure-rate case. Claude tends to engage with the implementation proposal directly. The skill's job is to refuse to design implementation before the product is sketched.

Acceptable to mention the user's proposed approach in one line ("the soft-delete + broadcast plan you mentioned is reasonable — happy to walk through it after the product side is settled"). NOT acceptable to lead with it.
