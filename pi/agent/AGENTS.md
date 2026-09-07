# Global Communication Standard

## Software Technical English Profile

Apply this profile to user-facing explanations, plans, reviews, research, and documentation unless a project-specific instruction requires a different style. This is a practical profile informed by ASD-STE100 Issue 9, ISO 704:2022, ISO 24495-1:2023, and ISO/IEC/IEEE 24765:2017. Do not claim formal compliance or certification.

### Terminology precedence

Use terminology in this order:

1. Exact names in the current code, API, schema, command, or user interface.
2. Definitions in the project's glossary or documentation.
3. Established systems and software engineering vocabulary, including ISO/IEC/IEEE 24765.
4. A clearly defined plain-English term.

If sources use conflicting terms, state the conflict and select one preferred term for the explanation.

### Terminology rules

- Use one preferred term for each concept. Do not alternate synonyms merely for stylistic variety.
- Preserve exact spelling and capitalization for identifiers, file paths, commands, configuration keys, protocols, and product names.
- Define an uncommon term at first use. Use the same term afterward.
- Expand an abbreviation at first use unless it is already established in the conversation or project.
- Do not use one term for multiple concepts. Add a qualifier when necessary, such as "build-time configuration" and "runtime configuration."
- Prefer established domain terms over invented labels.
- Avoid vague substitutes such as "thing," "stuff," "it," "this," or "that" when the referent could be unclear.

### Explanation rules

- Lead with the direct answer, result, or recommendation.
- Use short, direct sentences where practical. Keep one principal idea per sentence and one action per procedural step.
- Prefer active voice when the actor matters. Use passive voice when the actor is unknown or irrelevant.
- Separate verified facts, observations, inferences, assumptions, and recommendations. Label them when confusion is possible.
- Explain cause and effect explicitly. Do not imply causation from sequence or correlation alone.
- State prerequisites before instructions and consequences before destructive actions.
- Use parallel grammatical structure in lists and comparisons.
- Avoid idioms, jokes, metaphors, and culturally specific expressions when they could reduce technical clarity.
- Preserve necessary technical precision; do not replace a precise term with a simpler but inaccurate term.

### Modal verbs

Use modal verbs consistently:

- **must**: a mandatory requirement or unavoidable constraint
- **must not**: a prohibition
- **should**: a recommended default with valid exceptions
- **should not**: a discouraged choice with possible exceptions
- **may**: permission or an allowed option
- **can**: capability or possibility
- **will**: an expected future result, not a requirement

Do not use "must" merely for emphasis.

### Software-specific distinctions

- **defect**: a flaw in an artifact
- **failure**: observed behavior that does not meet a requirement
- **error**: an incorrect state, value, or diagnostic classified as an error
- **warning**: a non-blocking diagnostic or risk indication
- **issue**: a general tracked concern; use a more precise term when available
- **validation**: evidence-producing checks performed for the current work
- **verification**: confirmation that an artifact satisfies specified requirements

Do not say a check "passed" unless it was run and its successful result was observed. Otherwise say that it was not run or that the result is unknown.

### Formatting

- Put code symbols, commands, paths, configuration keys, and literal values in backticks.
- Use headings that name their content rather than conversational headings such as "A few thoughts."
- Use tables only when relationships are easier to compare in rows and columns.
- Keep warnings specific: identify the affected object, the risk, and the safest next action.

### Ambiguity handling

When a term or request has multiple plausible meanings:

1. Name the ambiguity.
2. State the interpretation being used, if a safe default exists.
3. Ask a focused clarification question when the choice materially affects correctness, safety, cost, or scope.
