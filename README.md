# AI Files

My VS Code + GitHub Copilot configuration for coding with AI agents. Contains custom instruction files and editor settings that make Copilot follow strict coding conventions, use modern APIs, and produce production-quality code.

## What's Inside

| File | Purpose |
|------|---------|
| `settings.json` | VS Code settings — Copilot agent config, editor preferences, model selection |
| `CLAUDE.md` | Entry point that tells AI agents which instruction files to load |
| `global.instructions.md` | Universal coding rules — DRY, error handling, CSS, JS, formatting |
| `nextjs.instructions.md` | Next.js / TypeScript / React 19 conventions |
| `php.instructions.md` | PHP 8.4+ OOP conventions |

## Prerequisites

- [VS Code Insiders](https://code.visualstudio.com/insiders/) (recommended for latest Copilot features)
- [GitHub Copilot](https://github.com/features/copilot) subscription (Free, Pro, Business, or Enterprise)

## Installation

### Step 1: Clone This Repo

Clone to a permanent location on your machine. This folder will be referenced by VS Code globally across all your projects.

**macOS / Linux:**

```bash
git clone https://github.com/kangarko/ai-files.git ~/dotfiles
```

**Windows (PowerShell):**

```powershell
git clone https://github.com/kangarko/ai-files.git $HOME\dotfiles
```

### Step 2: Update Paths in the Files

Two files contain placeholder paths (`/Users/YOURNAME/dotfiles`) that you must update to match your actual clone location.

**1. Edit `CLAUDE.md`** — replace all `/Users/YOURNAME/dotfiles` with your real path:

```
# macOS example:
/Users/jane/dotfiles/global.instructions.md

# Linux example:
/home/jane/dotfiles/global.instructions.md

# Windows example:
C:/Users/jane/dotfiles/global.instructions.md
```

**2. Edit `settings.json`** — find the `chat.instructionsFilesLocations` entry and update it:

```jsonc
"chat.instructionsFilesLocations": {
    "/Users/jane/dotfiles": true,   // <-- your real path here
    ".github/instructions": true
},
```

### Step 3: Apply the VS Code Settings

Open your VS Code **User** settings JSON file:

1. Press `Cmd+Shift+P` (macOS) or `Ctrl+Shift+P` (Windows/Linux)
2. Type **"Preferences: Open User Settings (JSON)"** and select it
3. Copy the contents of `settings.json` from this repo and paste them into your settings file

> **Merge carefully.** If you already have settings, merge the keys rather than replacing the entire file. The settings in this repo are additive — they won't break your existing setup, but you should review them.

### Step 4: Verify It Works

1. Open any project in VS Code
2. Open the Copilot Chat panel (`Cmd+Shift+I` / `Ctrl+Shift+I`)
3. Switch to **Agent** mode (click the mode dropdown at the top of chat)
4. Ask: *"What instruction files do you see?"*
5. Copilot should list `global.instructions.md` and any other applicable files

You can also run the command **"Chat: Configure Instructions..."** from the Command Palette to see all detected instruction files.

## How It Works

VS Code Copilot supports several types of custom instruction files:

- **`CLAUDE.md`** / **`AGENTS.md`** — Always-on instructions automatically included in every chat request. VS Code detects these at the workspace root. The `CLAUDE.md` in this repo uses `@`-imports to pull in the global/nextjs/php files.

- **`.instructions.md` files** — Scoped instruction files that can target specific file types via `applyTo` patterns. The `chat.instructionsFilesLocations` setting tells VS Code where to search for these files beyond the default `.github/instructions/` folder.

- **`settings.json`** — The `chat.instructionsFilesLocations` key is what makes the external dotfiles folder work. It tells VS Code: *"also look in this folder for instruction files."*

### Key Settings Explained

| Setting | What It Does |
|---------|-------------|
| `chat.instructionsFilesLocations` | Tells Copilot to load instruction files from your dotfiles folder |
| `chat.agent.maxRequests` | Max tool calls per agent session (set high for complex tasks) |
| `chat.tools.global.autoApprove` | Auto-approve all tool calls without confirmation dialogs |
| `github.copilot.chat.anthropic.thinking.budgetTokens` | Token budget for Claude's extended thinking |
| `github.copilot.chat.responsesApiReasoningEffort` | Reasoning effort level for the model |
| `github.copilot.chat.agent.temperature` | Creativity level (1 = more creative, 0 = more deterministic) |

## Customization

These are my personal conventions. Fork this repo and adapt the instruction files to match your own coding style:

- **Don't use PHP?** Delete `php.instructions.md` and remove its reference from `CLAUDE.md`
- **Don't use Next.js?** Delete `nextjs.instructions.md` and remove its reference from `CLAUDE.md`
- **Want different formatting?** Edit the `<code_formatting>` section in `global.instructions.md`
- **Want different CSS rules?** Edit the `<css>` section in `global.instructions.md`

## Updating

Pull the latest changes:

```bash
cd ~/dotfiles
git pull
```

No restart needed — VS Code picks up instruction file changes automatically.
