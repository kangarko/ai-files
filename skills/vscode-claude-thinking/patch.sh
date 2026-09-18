#!/usr/bin/env bash
#
# Restores Opus 4.7 / 4.8 extended-thinking summaries in the Claude Code VS Code
# extension by making the spawn args always include --thinking-display.
#
# Root cause: extension.js only pushes --thinking-display when its thinking
# config already has a display value, which it never does by default. So the API
# defaults to "omitted" and the Thinking section renders empty. This patch drops
# the guard and supplies a default value.
#
# Idempotent + auto-detects the newest extension folder, so re-run it after every
# Claude Code extension update.
#
#   bash ~/.claude/skills/vscode-claude-thinking/patch.sh            # apply
#   CC_THINKING_DISPLAY=omitted bash .../patch.sh                    # hide again
#   bash ~/.claude/skills/vscode-claude-thinking/patch.sh --revert   # undo
#
# After running, reload VS Code: Cmd+Shift+P -> Developer: Reload Window.

set -euo pipefail
shopt -s nullglob

DISPLAY_VALUE="${CC_THINKING_DISPLAY:-summarized}"
REVERT=0
[ "${1:-}" = "--revert" ] && REVERT=1

# Matches the unpatched arg-push regardless of minified variable names.
UNPATCHED_RE='type!=="disabled"&&[A-Za-z_$][A-Za-z0-9_$]*\.display\)[A-Za-z_$][A-Za-z0-9_$]*\.push\("--thinking-display"'

found=0
changed=0

for root in "$HOME/.vscode-insiders/extensions" "$HOME/.vscode/extensions"; do
    [ -d "$root" ] || continue

    for dir in "$root"/anthropic.claude-code-*; do
        file="$dir/extension.js"
        [ -f "$file" ] || continue
        found=1

        if [ "$REVERT" = 1 ]; then
            if [ -f "$file.orig" ]; then
                cp "$file.orig" "$file"
                echo "reverted: $file"
                changed=1
            else
                echo "no backup, nothing to revert: $file"
            fi

            continue
        fi

        if ! grep -qE "$UNPATCHED_RE" "$file"; then
            if grep -q -- '--thinking-display' "$file"; then
                echo "already patched: $file"
            else
                echo "pattern not found (extension changed?), skipped: $file"
            fi

            continue
        fi

        [ -f "$file.orig" ] || cp "$file" "$file.orig"

        CC_THINKING_DISPLAY="$DISPLAY_VALUE" perl -0pi -e \
            's/if\(([A-Za-z_\$][A-Za-z0-9_\$]*)\.type!=="disabled"&&\1\.display\)([A-Za-z_\$][A-Za-z0-9_\$]*)\.push\("--thinking-display",\1\.display\)/if($1.type!=="disabled")$2.push("--thinking-display",$1.display||"$ENV{CC_THINKING_DISPLAY}")/g' \
            "$file"

        if grep -qE "$UNPATCHED_RE" "$file"; then
            cp "$file.orig" "$file"
            echo "patch FAILED, restored from backup: $file" >&2
            exit 1
        fi

        echo "patched OK ($DISPLAY_VALUE): $file"
        changed=1
    done
done

if [ "$found" = 0 ]; then
    echo "No Claude Code VS Code extension found." >&2
    exit 1
fi

if [ "$changed" = 1 ]; then
    echo
    echo "Reload VS Code (Cmd+Shift+P -> Developer: Reload Window), then pick Opus 4.8."
fi
