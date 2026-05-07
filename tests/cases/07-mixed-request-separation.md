# Test case: mixed request — clean separation, never blended

## Prompt

> Explain how our two-factor flow works, both from the user's side AND from the code side. I want to send the user-side part to support and the code-side part to a new engineer.

## Expected behavior

- Skill activates (the user explicitly asked for both views).
- Output is **two clearly labeled sections**, in this order:
  - `**Product view**` — pure product-language description: the user enabled 2FA, signs in, gets prompted for a code, opens the authenticator app, types the code, lands on their dashboard.
  - `**Code view**` — implementation: TOTP, secret generation, time windows, validation steps, etc.
- The two sections are visually and verbally separate. A reader could send one section to support and the other to an engineer without further editing.

## Expected NOT to do

- Blend the views: "When the user enters the code, the TOTP validator computes the expected value for the current 30-second window…" — this is the failure mode.
- Sprinkle implementation parentheticals throughout the product view ("they enter the code (which we validate against the TOTP secret with a ±1 window)").
- Lead with the code view. Product view first.
- Use the product-view section to set up the code-view section ("now let's look at how this works under the hood…") — that creates an interleaved feel.

## Notes

The test: can the user copy/paste each section independently? If yes, pass. If they'd have to manually clean up the product-view section to remove implementation hints before sending it to support, fail.
