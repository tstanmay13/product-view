# Test case: reframe a bug ticket

## Prompt

> Sentry alert below — what's actually broken for users?
>
> ```
> TypeError: Cannot read properties of null (reading 'address')
>   at CheckoutShipping.computeTax (CheckoutShipping.tsx:142:23)
>   at handleAddressChange (CheckoutShipping.tsx:88:5)
> Affected sessions: 1,247 in the last 24h
> Browsers: Safari iOS (98%)
> ```

## Expected behavior

- Skill auto-activates (stack trace + plain-language reframe request).
- Sub-mode: **reframe**.
- Output identifies WHO is affected (iPhone Safari users), WHERE in their journey they hit it (checkout, after entering address, before paying), and WHAT they see (broken or blank checkout, can't continue).
- Output uses approximate scale ("about 1,250 in the last day" or similar) — the number is user-impact-relevant.

## Expected NOT to do

- Mention `computeTax`, `CheckoutShipping`, `TypeError`, `null`, `handleAddressChange`, the line numbers.
- Diagnose the cause ("stale closure", "race condition") in the reframe — that's a code-side question and belongs in a separate code-view section if asked.
- Suggest a fix in code-language.

## Notes

If the user asks a follow-up like "what's the cause?", the skill should switch out (or present a code-view section) and answer in code-language. This case only tests the initial reframe.

Acceptable variant: a one-line "want me to dig into the cause next?" at the end is fine. Diagnosing the cause unprompted is not.
