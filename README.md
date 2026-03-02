# AI Files

VS Code + GitHub Copilot configuration that makes AI agents follow strict coding conventions and produce production-quality code.

| File | Purpose |
|------|---------|
| `settings.json` | VS Code settings — Copilot agent config, model selection, editor prefs |
| `CLAUDE.md` | Entry point that tells AI agents which instruction files to load |
| `global.instructions.md` | Universal coding rules — DRY, error handling, CSS, JS, formatting |
| `nextjs.instructions.md` | Next.js / TypeScript / React 19 conventions |
| `php.instructions.md` | PHP 8.4+ OOP conventions |

## Prerequisites

- [VS Code Insiders](https://code.visualstudio.com/insiders/)
- [GitHub Copilot](https://github.com/features/copilot) subscription

## Installation

### 1. Clone This Repo

```bash
# macOS / Linux
git clone https://github.com/kangarko/ai-files.git ~/dotfiles

# Windows (PowerShell)
git clone https://github.com/kangarko/ai-files.git $HOME\dotfiles
```

### 2. Copy CLAUDE.md to Your User .claude Folder

The `CLAUDE.md` file must live in `~/.claude/` so that AI agents (Copilot, Claude Code) pick it up globally across all projects.

```bash
# macOS / Linux
mkdir -p ~/.claude
cp ~/dotfiles/CLAUDE.md ~/.claude/CLAUDE.md

# Windows (PowerShell)
New-Item -ItemType Directory -Force -Path "$HOME\.claude"
Copy-Item "$HOME\dotfiles\CLAUDE.md" "$HOME\.claude\CLAUDE.md"
```

### 3. Update Paths

Replace `/Users/YOURNAME/dotfiles` with your real path in two files:

**`~/.claude/CLAUDE.md`** — update the `@` import paths:

```
# macOS:  /Users/jane/dotfiles/global.instructions.md
# Linux:  /home/jane/dotfiles/global.instructions.md
# Windows: C:/Users/jane/dotfiles/global.instructions.md
```

**`settings.json`** — update `chat.instructionsFilesLocations`:

```jsonc
"chat.instructionsFilesLocations": {
    "/Users/jane/dotfiles": true,   // <-- your path
    ".github/instructions": true
},
```

### 4. Apply VS Code Settings

1. `Cmd+Shift+P` (macOS) or `Ctrl+Shift+P` (Windows/Linux)
2. Type **"Preferences: Open User Settings (JSON)"**
3. Merge the contents of `settings.json` from this repo into your settings file

> If you already have settings, merge the keys — don't replace the entire file.

### 5. Verify

1. Open any project in VS Code
2. Open Copilot Chat (`Cmd+Shift+I` / `Ctrl+Shift+I`) in **Agent** mode
3. Ask: *"What instruction files do you see?"*

You can also run **"Chat: Configure Instructions..."** from the Command Palette.

## Customization

Fork this repo and adapt to your stack:

- Don't use PHP or Next.js? Delete the file and remove its `@` reference from `CLAUDE.md`
- Want different formatting? Edit the `<code_formatting>` section in `global.instructions.md`

## Updating

```bash
cd ~/dotfiles && git pull
```

VS Code picks up instruction file changes automatically — no restart needed.
