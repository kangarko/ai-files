Output "Read global." to chat to acknowledge your read this file.

<general>
- ALWAYS follow all rules below carefully & to the letter
- Read entire file contents instead many small chunk reads
- Always write the most proper, cleanest, DRY (Dont Repeat Yourself), bug free, fully functional and production-worthy code
- Leave NO todo’s, placeholders or missing pieces
- Include all required imports, and ensure proper naming of key components
- Keep it simple, lean, reuse what we have. Think how can we REMOVE code from this repo instead of adding baggage or bloat.
- Use early returns whenever possible to make the code more readable
- Use fast and type-safe design principles that throw errors
- Never change website copy unless told to
- Do not add legacy or backward compatibility except for database migrations
- Never fail silently. Always add strict validation. Always throw an error if something is missing or unexpected
- Never use sample data, placeholders, || or ?? fallbacks
- Never add a defensive fix using a fallback
- If front-end or back-end get an unexpected response, print the raw response to help me debug
- Before using any CSS variable, class, JS function, or utility, verify it actually exists in the codebase. Search for its definition first — never assume a name exists based on convention or naming patterns
- Do not comment your code
- When reorganizing or moving elements, check and fix spacing
- When adding objects such as routes, models, stylesheets, scripts, utils etc. always read a sample existing route to learn about our design patterns and follow them
- Before changing any shared method, class, or convention, always scan for all existing usages first to understand the established pattern, then follow it consistently
- Never change my AI model, its context window, settings, URL or API keys unless explicitly told to do so
- If I ask you for a refactor or lack specificity, ask follow up questions. Think "What’s wrong with this plan?", "What I am missing?"
- Use modern APIs and patterns over legacy approaches. Baseline browser support is February 2026
- When I upload an image for you, describe it with pixel perfect accuracy and aim to replicate it perfectly as close to the image as possible
- Don't hide functionality in methods appearing as getters or checks.
- Create skills in global .claude/skills
- Anthropic only: Always use model: "opus" for all Task tool subagents. Never downgrade to haiku or sonnet
- For longer operations or migrations, keep scratchdisks, temp data or progress file in a working/ directory in root folder to prevent losing them when the conversation gets compacted. Write long terminal scripts to a temp file in working/ dir with `create_file` first, then execute it with a simple one-line command
- When writing multi-line content to the terminal (heredocs, inline scripts), use `create_file` instead if the command exceeds 500 characters. VS Code's `sendText()` corrupts heredocs over ~700 chars due to stdin buffer saturation.
- NEVER print credentials: Not in logs, not in error messages, not in agent outputs.
- If I tell you to "report" or ask "how feasible", enter discuss mode and DO NOT EDIT CODE UNTIL I EXPLICITLY TELL YOU TO DO SO. Simply report, discuss, get skeptical, double check and plan all changes in a lean, DRY way, the most proper, cleanest way
- When an API call fails (expired token, auth error, missing permissions), STOP IMMEDIATELY. Do not continue the task, do not speculate, do not produce analysis based on data you don't have. Tell me the exact error, which token/key needs updating and in which file, then wait for me to fix it before continuing
- After your are done, remove unused imports, scan for DRY violations, broken code, hidden bugs, overengineering, edge cases, your last code changes not being reflected everywhere else in the app
- When starting long-running server processes (Java servers, dev servers, etc.) from a terminal, ALWAYS redirect output to a log file AND close stdin to prevent VS Code's terminal output monitor from detecting false input prompts: `command > /tmp/server.log 2>&1 < /dev/null &`, and ALWAYS use isBackground: true. Then read the log file with `tail` or `cat` to check output
- When reading skills, you MUST read the ENTIRE SKILL.md file in FULL from line 1 to the end. Use read_file with startLine 1 and endLine 10000. If the file exceeds 10000 lines, continue reading in sequential chunks until you reach the end. NEVER stop reading partway through a skill file
- When I say "deepsearch", perform at least 5-8 web searches using tavily with varied queries, exploring every angle, synonym, related term, and adjacent topic. Do NOT stop after 2-3 searches. Keep going until results fully repeat with nothing new. Use different phrasings, specific names, niche forums, GitHub forks, PRs, and alternate keywords for each query batch
- For PDF text extraction, use PyMuPDF (`import fitz`) — not PyPDF2 (deprecated). Installed at ~/Library/Python/3.14/lib/
</general>

<skill-self-learning>
This section covers two triggers: automatic self-learning after tasks, and explicit "remember" commands from the user.

**Trigger 1 — After completing any task where you loaded a SKILL.md:**
Self-evaluate: did anything go wrong, require a workaround, or behave differently than documented?
If yes, update the skill inline where the fix belongs — fix wrong instructions, add missing steps, correct parameters. Keep it DRY: integrate the new knowledge into the existing structure rather than appending to a separate section. If no suitable place exists, add a bullet to a `## Lessons Learned` section at the bottom (create if needed). Replace old bullets that a new finding supersedes.
Do NOT update for user error, transient issues (network timeout, rate limit), or findings already documented.
After updating, tell the user: "Updated [skill-name] skill: [one-sentence summary of what changed]"

**Trigger 2 — User says "remember", "zapamti", "zapamti si", "nauči se", "save this", "add this to skill", or similar:**
Read the relevant SKILL.md in full, find the most suitable place to integrate the information in a DRY way, and edit it inline. Only fall back to `## Lessons Learned` if no better location exists. Confirm with: "Saved to [skill-name] skill: [one-sentence summary]."
</skill-self-learning>

<css>
- Use CSS Nesting: Nesting classes, IDs, or attribute selectors works without &. However, always use & for pseudo-classes/elements for clarity.
- Do not use top borders as visual separators or dividers. Don't use anything.
- No borders except for native dom elements such as input fields or textareas
- If using borders on focused, hovered or selected elements, make sure to add an invisible border to the element's default state as not to cause layout shift.
- Use modern responsive practices
- Use Container Queries
- Use :has() Selector
- Use Logical Properties
- Use Modern Color Functions
- Use Subgrid
- Use Scroll-Driven Animations
- Never add translate effects on hover
</css>

<javascript>
- Only use console.error or console.log or console.warning as a final catch in the app to log an error. In all earlier places, throw the error using "throw"
- Use Array Methods groupBy
- Use Set Methods union, intersection, difference, symmetricDifference, isSubsetOf, isSupersetOf
- Use Promise.withResolvers
- Use RegExp v Flag
- Use Iterator Helpers values(), keys(), entries(), map(), filter(), reduce(), find(), some(), every(), toArray()
</javascript>

<database>
- Do NOT create updated_at column when making new database tables, I do not care about tracking updates
</database>

<code_formatting>
- Use 4 spaces for indentation
- Put conditions multiline. Do not wrap single if, else etc. statements. Never put the condition and body on the same line — always break after the condition: `if (x)\n    doSomething();` not `if (x) doSomething();`
- Single-line conditions without braces
- Empty line before the start of `if`, `for`, `while`, `foreach`, `try` blocks — not before continuation keywords (`else`, `else if`, `catch`, `finally`)
- Vertically align `=` in consecutive assignment blocks (not separated by blank lines, comments, or other statements). The longest variable gets exactly 1 space before `=`; shorter variables pad to match
- In associative arrays, vertically align `=>` arrows. The longest key gets exactly 1 space before `=>`; shorter keys pad to match
- Do not align `=>` in match expressions. Use a single space before `=>`
- Never put multiple statements on a single line inside braces. Always expand to multiple lines
</code_formatting>

<thinking>
- You must engage in exhaustive, deep-level reasoning. Think deeply about edge cases, data integrity, and architectural consequences before writing code and after refactorings.
</thinking>

<design>
- For all designs I ask you to make, have them be beautiful, not cookie cutter. Make webpages that are fully featured and worthy for production. 
- Avoid baloon labels because they look AI-generated. 
</design>

<copywriting>
The below are rules you must adhere to when writing sales, email, ad, funnel or any other kind of copy:

- When writing prose, do not overuse lists. Write in a natural flow like a newspaper. Use a few lists only to highlight key points.
- If writing in a non-English language, avoid using English loanwords if native alternative exists and is widely used as our audience might not understand them. If a native word does not exist or would be weird, explain the meaning in bracket the first time you introduce the word.
- Work scarcity in early on: offer 5% discount if they come and buy later and on remarketing ads in the next few hours
- Mental triggers: urgency, scarcity, novelty but avoid generic scarcity
- Use storytelling
- Simple optin page, win immediatelly, lead magnet 
- Add more curiosity to headline and open loop to the ad copy
- Add trust badges
- Address their problem, show them an easy push button way to fix it while creating mystery
- Make it super clear for them to visualize them succeeding and understand the offer. Great example: Use AI to generate hollywood-level quality video for $2. Bad example: Become successful.
- Create and maintain open loops in copy

## Ad Structure

1. Attention
   - Grab immediate attention
   - Create pattern interrupts
   - Work scarcity in early
   - Can be an open loop

2. What (Gain)
   - Clear value proposition
   - Specific, measurable outcomes
   - Focus on transformation

3. Without (Pain) - Optional if What is pain-focused
   - Current struggles
   - Market challenges
   - Common pitfalls

4. Verify
   - Proof points
   - Case studies
   - Real results

5. Social Proof
   - Studies show...
   - Celebrity testimonials
   - Industry expert validation

6. Time Urgency
   - Limited availability
   - Time-sensitive offer
   - Market timing factors

7. Downside of Not Clicking
   - Opportunity cost
   - Competition getting ahead
   - Market shifts

## Headline Formula

1. Desired Result
   - Clear, specific outcome
   - Tangible benefits
   - Transformation promise

2. Fast Time Frame
   - Quick wins
   - Rapid implementation
   - Immediate results

3. "Behind the Curve" Context
   - Market shifts
   - Industry changes
   - Competitive pressure

4. Novel Approach
   - New methodology
   - Unique system
   - Innovative strategy
   - Something new they've never seen before (new opportunity)

5. Easy Implementation
   - Simple steps
   - Clear path
   - Accessible process

## Sample headlines:

- "The key for you to make X you really want is Y and the only way to do it is Z."
- The Simple 2 Step Model I Use To Generate $3,000/Month By Cloning Minecraft Templates
- An Absurd Side Hustle I Use To Generate $3,000/Mo Cloning Minecraft Templates
- The 1 Simple Shift This Teenager Used To Generate $3,000/Mo Cloning Minecraft Templates (and how you too can jump into this low-key industry in 24-48 hrs by doing the same)

## Make Offer Specific

Sell specific results, not vague conceptsú.

Your offer must be: "You pay X, you get Y" - crystal clear.**

| Good Offer | Why It Works |
|------------|--------------|
| "You speak French in 90 days" | Specific, measurable |
| "Six pack in 3 weeks" | Clear outcome + timeline |
| "Speed read" | Tangible skill |
| "Fix brain fog in 15 days" | Specific problem + deadline |
| "Increase IQ by 12%" | Verifiable result |

| Bad Offer | Why It Fails |
|-----------|--------------|
| "Regain your drive" | What does that even mean? |
| "Flow state" | Buzzword - means nothing tangible |
| "Scale your business" | Too broad |
| "Peak performance" | Vague idea, not a result |
| "Conquer your mind" | Not measurable |

People won't pay for abstract transformation. They pay for specific, fast, clear outcomes they can verify.

## Email sequences:

When writing email sequences use the following order and principles:

Email 1: Make them not like where they are at, open loop at the end
“And in the next email....”
Email 2: Make them understand why our way is better
Email 3: Make them understand why this will work for them and why they can do it (future pace, objection handling)
Email 4: Close and sell
</copywriting>