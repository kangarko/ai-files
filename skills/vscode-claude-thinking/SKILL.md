---
name: vscode-claude-thinking
description: Restore empty Opus extended-thinking summaries in the Claude Code VS Code extension on macOS by patching extension.js to always send thinking.display=summarized. Use when Opus 4.7/4.8 shows an empty or missing Thinking section, a live token counter with no thinking text, or after a Claude Code extension update wipes the fix. Keywords claude code, thinking, extended thinking, summaries, opus 4.7, opus 4.8, empty thinking, thinking-display, summarized, omitted, extension.js, vscode patch.
---

# Restore Claude Code thinking summaries (VS Code, macOS)

## Problem

On Opus 4.7 / 4.8 the Claude Code VS Code extension shows an empty Thinking
section (just a token counter, no text). Switching to Sonnet 4.6 or Opus 4.6
restores it. `showThinkingSummaries`, `MAX_THINKING_TOKENS`, Ctrl+O, Alt+T, and
extension rollback all change nothing.

## Root cause

The model API default flipped from `display: "summarized"` to
`display: "omitted"` on 4.7/4.8. The extension only forwards `--thinking-display`
when its thinking config already has a `display` value, which it never sets, so
the request omits it and the API returns thinking blocks with `thinking: ""`.
The native binary honors the flag and the flag is not interactivity-gated, so
forcing the extension to always pass it fixes VS Code. (GitHub issue
anthropics/claude-code#63358.)

## The one-line change

In each `anthropic.claude-code-*/extension.js`:

    // before
    if(l.type!=="disabled"&&l.display)B.push("--thinking-display",l.display)
    // after
    if(l.type!=="disabled")B.push("--thinking-display",l.display||"summarized")

The minified variable names (`l`, `B`) drift between builds, so
[patch.sh](patch.sh) matches them with a backreference regex instead of literal
names.

## Apply

    bash ~/.claude/skills/vscode-claude-thinking/patch.sh

Then reload the window: Cmd+Shift+P -> Developer: Reload Window, and pick Opus
4.8. The script:

- auto-detects the newest extension folder under `~/.vscode-insiders/extensions`
  and `~/.vscode/extensions`
- backs up `extension.js` to `extension.js.orig` once before first patching
- is idempotent: skips a file that is already patched or whose pattern is gone
- verifies the edit and auto-restores the backup if it failed

## Re-apply after updates

VS Code installs each update into a new `anthropic.claude-code-<version>` folder,
which resets the file. Just run the same command again after an update.

## Toggle and revert

    CC_THINKING_DISPLAY=omitted bash ~/.claude/skills/vscode-claude-thinking/patch.sh   # hide thinking
    bash ~/.claude/skills/vscode-claude-thinking/patch.sh --revert                       # restore original

## Scope notes (verified on this machine)

- Summarized is the CEILING. `thinking.display` accepts only `summarized`,
  `omitted`, and `updates` (beta, shows even less). Official docs: "No `display`
  setting returns the raw chain of thought." Full CoT exists only as an
  org-level grant via sales@anthropic.com (Claude 4 "Developer Mode"),
  unconfirmed for 4.7+/Fable 5. Do not research a "full"/"raw" value again.
- `claude-thinking-patch.py` is silent by design (no log() calls, prints
  nothing on success) and throws on real errors, whose tracebacks land in
  `~/.claude/claude-thinking-patch.log` via the hook's `2>&1` redirect. A
  Python syntax error in the script fails EVERY SessionStart silently, so
  check that log if binaries stop getting re-patched after updates.

- Install: Homebrew cask `claude-code`; VS Code Insiders extension
  `anthropic.claude-code` (2.1.167 at time of writing). The extension runs its
  own bundled `resources/native-binary/claude`, not the Homebrew CLI.
- The official extension has no executable-path setting, so the `claudemax`
  wrapper approach from the issue does not apply here. Patching `extension.js` is
  the working VS Code fix.
- This `extension.js` one-liner only fixes the FIRST-PARTY Anthropic API path.
- On AWS Bedrock / Vertex the empty-thinking cause is different and lives in the
  native binary, not `extension.js`. The API request-body builder gates
  `thinking.display` behind a provider check (`<flag>&&BO()&&gkt(u)?n.display:void 0`)
  that is false for `bedrock`/`vertex`, so `display` is dropped and the model
  defaults to `display:"omitted"` (empty thinking text). Verified against Bedrock
  Fable 5: sending `thinking.display:"summarized"` returns real summarized
  thinking; omitting it returns empty. Fix = byte-length-preserving binary patch
  of that gate to force `"summarized"`, then ad-hoc re-sign (hardened runtime).
  Script: `~/.claude/claude-thinking-patch.py`, run every session via the
  `SessionStart` hook in `~/.claude/settings.json`. It patches ALL claude
  binaries (Homebrew CLI, VS Code extension `resources/native-binary/claude`, and
  the `agent-host/sdk-cache` `@anthropic-ai/claude-agent-sdk` binaries) since they
  are different versions and update independently. `CLAUDE_CODE_EXTRA_BODY` also
  works but was rejected in favor of the binary patch.
- Interactive terminal CLI on first-party already honors `showThinkingSummaries:
  true` and needs no patch; on Bedrock it needs the binary patch above.

## Troubleshooting

- No effect after patch: confirm the window was fully reloaded and the model is
  Opus 4.8, then re-check with
  `grep -o 'display||"summarized"' <ext>/extension.js`.
- If VS Code ever blocks the modified extension over signature verification, set
  `"extensions.verifySignature": false` in settings, reload, and re-run.
