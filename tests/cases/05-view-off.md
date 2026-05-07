# Test case: `view off` ends the mode

## Prompt sequence

**Turn 1:**
> view on

**Turn 2:**
> Walk me through how a comment thread loads on a post.

**Turn 3:**
> view off. Now show me the actual fetch logic — pseudocode is fine.

## Expected behavior

- Turn 1: brief acknowledgement (`Product view: on.`).
- Turn 2: clean product-view explanation of the comment thread experience.
- Turn 3: brief acknowledgement (`Product view: off.`), followed by code-language pseudocode for the fetch logic. Code-language is now correct.

## Expected NOT to do

- Continue describing in product-language on turn 3 after `view off` was said.
- Refuse to show pseudocode on turn 3 because the prior context was product-view.
- Forget the conversation context (the response on turn 3 should still be about the comment thread the user just asked about, just from the code side).

## Notes

The test is symmetry: the toggle works in both directions. If `view on` is honored but `view off` isn't, the skill is incorrectly sticky.

Acceptable variant: turn 3 might briefly recap what was just established in product-view ("we just covered what the reader sees; now from the code side …") before the pseudocode. That's fine — it's continuity, not leak.
