# Format selection — narrative / structured / journey

Pick the lightest format that fits. Heavier formats look more thorough but read worse.

## The three formats

### Narrative prose

A flowing description, one to a few short paragraphs.

> The reader opens the article. They see the title, the author's photo, and the first line. They scroll, and the next paragraph appears. When they reach the end, three suggested articles slide up from the bottom.

When to use:
- The flow has three steps or fewer.
- There are no branches.
- The user's emotional state isn't load-bearing.
- The user asked for a quick sketch, not a spec.

This is the **default**. Most product views should be a paragraph.

### Structured (Trigger → Goal → Steps → Outcome)

A small bulleted skeleton.

> **Trigger:** the customer's card declines on a renewal.
> **Goal:** keep their service running.
> **Steps:**
> 1. They get an email: "We couldn't charge your card."
> 2. The email links them to a page where their old card is shown and a "Use a different card" button.
> 3. They tap it, enter the new card, and confirm.
> 4. They see "You're all set, your subscription continues until [date]."
>
> **Outcome:** their service never lapsed, they're back on a working card.

When to use:
- Four or more steps.
- One or more branches (different things can happen depending on the user's choice).
- The user wants something they can hand to someone else (a designer, a PM, a stakeholder).
- The flow has an entry condition that matters (the trigger).

### Journey with emotional states

Each step paired with what the user is feeling, looking for, or worrying about.

> **They're stuck.** They've been trying to import their data for ten minutes.
> *Feeling:* annoyed, starting to question the switch.
> *What they're hoping for:* a clear next step, not another retry button.
>
> **They find the help link.**
> *Feeling:* slight relief — at least there's a person at the other end.
> *What they're hoping for:* somebody who will look at *their* import, not a generic FAQ.
>
> **A real person replies in chat within two minutes.**
> *Feeling:* trust restored.

When to use:
- The feelings shape the design decision. (You can't decide whether to add a help link without knowing what the user is feeling at the moment they need it.)
- Planning a UX-sensitive flow: onboarding, error recovery, payment failure, account deletion.
- Investigating churn or drop-off — the moments where users *leave* are about feeling, not about logic.
- The user explicitly asks "how does this feel?" or "what's the experience?"

Don't use journey-with-feelings format for a routine explanation. It looks like padding when feelings aren't load-bearing.

## Quick decision rule

```
If the flow is ≤3 steps, no branches, feelings irrelevant → narrative
Else if 4+ steps OR branches → structured
Else if feelings shape the design decision → journey
```

When uncertain, default narrative. Add structure only when the content actually demands it.

## Format upgrades and downgrades

You can move between formats inside a single answer:

- A narrative paragraph followed by a structured list of edge cases.
- A structured outline with one step expanded into a mini-journey because that step is where users get stuck.

Don't do this just to fill space. Do it when one section genuinely benefits from a different resolution.

## Anti-patterns

- **Headers for a two-step flow.** A two-line description doesn't need *Trigger / Goal / Steps / Outcome* headings.
- **Emotional states on every step of a routine flow.** "They click Sign Up. *Feeling: neutral.*" — drop it.
- **Tables for prose.** A table of three rows where each cell is a sentence is just prose laid out badly.
- **Bullet-vomit.** A flowing experience flattened into 20 single-clause bullets reads like a checklist, not a journey.

## A tiny worked example

Same scenario in three formats:

**Scenario:** the user opens a doc that's been deleted.

> *Narrative:* They tap the link in their email. The page comes up empty with the message "This doc isn't around anymore." A button below says "Go to your docs."

> *Structured:* — too heavy here. Skip.

> *Journey:* — only worth it if you're trying to decide whether to soften the wording, add an undo, or surface a contact link. Then the feelings (confusion, loss, suspicion that they did something wrong) matter.

The first format is right unless someone is making a design decision about the empty-state itself.
