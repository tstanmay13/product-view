# Test case: non-customer audience — vocabulary fits the player

## Prompt

> In our roguelike, when the player dies, we run a meta-progression update: experience earned during the run is converted to soul-points (clamped at the max), unlocks are re-evaluated, and the run record is committed. New runs read the latest unlock state on init. Walk me through what this looks like to the player.

## Expected behavior

- Skill activates (explanation request).
- Sub-mode: **explain**.
- Output uses **player** vocabulary, not "user". Verbs are gameplay-appropriate: *dies*, *sees*, *taps*, *watches*, *starts a new run*.
- The death recap, the soul-points ticking up, the unlock banner, the next-run carry-over — all described as the player experiences them.
- The clamp on soul-points is described in player terms ("the number stops at the cap" / "soul-points stop ticking up at the ceiling"), not as `Math.min(earned, max)`.

## Expected NOT to do

- Default to "user" when "player" fits.
- Use code-language: `onRunEnd`, `clamp`, `commit`, `playerProfile`, `init`, the formula for soul-point conversion.
- Treat the meta-progression update as a backend phase ("we then update the persistent state…") — that's mechanism, not experience.

## Notes

Audience flexibility is a core feature. Failing this test means the skill is silently a "user" skill, not a general product-view skill.

Other audience variants worth testing later:
- Reader on a blog or CMS
- Student in an LMS
- Patient in a health app
- Buyer / seller in a marketplace
- Developer using your API

Each substitutes the audience word and the audience verbs accordingly.
