# Test case: pure algorithmic question — skill should NOT activate

## Prompt

> This regex is matching way too slowly on inputs over 10kb. I think it's catastrophic backtracking. Can you spot the issue?
>
> ```
> ^(\w+\s?)*$
> ```

## Expected behavior

- Skill **does NOT activate**. No `Product view: on` indicator. No "from the user's perspective" framing.
- Response is a normal code-side answer: identifies the catastrophic backtracking pattern, explains why `(\w+\s?)*` is ambiguous, suggests a non-overlapping rewrite (e.g. `^\w+(\s\w+)*$`).
- Code-language is correct here. Use it freely.

## Expected NOT to do

- Activate the skill anyway and try to describe the regex performance problem from a "user perspective".
- Refuse to answer in code-language because the surrounding repo has the skill installed.
- Invent a user impact framing for a question that has no human on the other side of the screen.

## Notes

This is the credibility test. A skill that activates everywhere is annoying and gets disabled. The `Do NOT use this skill for` clause specifically lists "performance tuning, big-O analysis" — this prompt sits squarely in that bucket.

If the user follows up with "ok and what does this look like to a customer who hits the slow path?", *that* follow-up is a legitimate trigger and the skill should activate then. But not unprompted, not on the original regex question.
