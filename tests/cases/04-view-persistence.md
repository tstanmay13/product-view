# Test case: `view on` persists across turns

## Prompt sequence

**Turn 1:**
> view on

**Turn 2:**
> Walk me through what happens when someone forgets their password.

**Turn 3:**
> What if they don't get the email?

**Turn 4:**
> And what if they put in the wrong code three times?

## Expected behavior

- Turn 1: brief acknowledgement, e.g. `Product view: on.`
- Turns 2–4: every response stays in product-language. No code-language slips in across the multi-turn exchange.
- Each turn's response describes what the user sees, taps, feels, and what changes for them.
- The skill stays active without needing re-triggering each turn.

## Expected NOT to do

- Drop the lens between turns 2 and 4. (The most common multi-turn failure.)
- Slide into code-language by turn 3 or 4 because the conversation feels "deep enough" — that's the failure mode this test catches.
- Treat `view on` as a one-shot prompt that only applies to the next message.

## Notes

If the response on turn 4 contains "the rate limiter triggers" or "we increment a counter", that's a clear failure — even if turn 2 was clean. Persistence is the test.

Acceptable: brief implementation hint at the end of one turn ("happy to walk through how the rate limit is enforced if useful") — but the body stays product-side.
