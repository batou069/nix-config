# Neovim Configuration Guide & Status

## 1. Immediate Action Items

To get your configuration fully green after the recent updates:

1.  **Rebuild System:**
    I have commented out the problematic `norg` parser in `home/editors/nixvim/plugins/treesitters.nix`.
    Run your rebuild command now.

2.  **Authenticate Copilot (Critical):**
    Open Neovim and run the following command to link your GitHub account:

    ```vim
    :Copilot auth
    ```

    This is required for `CopilotChat`, `CodeCompanion`, and standard completions to work.

3.  **Note on Warnings:**
    - **Molten:** You may see warnings about missing `kaleido` or `pnglatex`. These are optional dependencies for image export that are currently difficult to package on NixOS. The core Jupyter notebook functionality will still work.
    - **Snacks:** You may see "disabled" statuses for some modules. This is intentional as you are currently using alternatives (like `Neo-tree` and `Telescope`).

---

## 2. Native LSP Configuration Explained

Your configuration in `home/editors/nixvim/plugins/lsp.nix` uses a powerful hybrid approach:

- **Native LSP (`programs.nixvim.plugins.lsp`):**
  This connects Neovim to language servers like `nixd` (Nix), `gopls` (Go), and `pyright` (Python). It handles the heavy lifting of code intelligence (Go to Definition, Find References).

- **LspSaga (`programs.nixvim.plugins.lspsaga`):**
  This replaces the default, plain text UI with modern, floating windows.
  - **Effect:** When you press `K` for hover docs or rename a variable, you get a nice UI box instead of a command line message.

- **None-LS (`programs.nixvim.plugins.none-ls`):**
  Allows command-line tools to act as Language Servers.
  - **Why:** It lets you use `prettier`, `black`, `shellcheck`, and `gitlint` inside the LSP workflow, enabling formatting and diagnostics for languages that don't have a dedicated server.

### Suggested Improvements

- **Consolidate Keymaps:** Currently, keys like `gd` are defined in multiple places (`keymaps.nix`, `lsp.nix` native config, `lsp.nix` saga config). It is recommended to choose one consistent set (e.g., sticking to `Lspsaga` for UI actions) and remove the duplicates to ensure consistent behavior.
- **Inlay Hints:** Set `lsp.inlayHints = true` in `lsp.nix` if you want to see variable types inline (like `x: int`) while coding.

---

## 3. Cheatsheet: Your New Superpowers

Use `<Space>` (your leader key) and wait a second to see a popup menu of all available keys via the **Which-Key** plugin.

### 🧠 AI Assistants

| Key             | Command       | Description                                       |
| :-------------- | :------------ | :------------------------------------------------ |
| `:Copilot auth` | **Setup**     | **Run this first!** Authenticates GitHub Copilot. |
| `<leader>aa`    | `Avante Ask`  | Opens the **Avante** sidebar to chat about code.  |
| `<leader>ae`    | `Avante Edit` | Asks AI to edit the selected code block.          |
| `<leader>cm`    | `MCPHub`      | Opens the Model Context Protocol hub.             |
| `:CopilotChat`  | `Toggle`      | Opens a chat window with Copilot.                 |

### 🚀 Navigation & Files

| Key          | Tool          | Description                                                          |
| :----------- | :------------ | :------------------------------------------------------------------- |
| `<leader>ff` | **Telescope** | **Find Files**. Fuzzy search project files.                          |
| `<leader>fg` | **Telescope** | **Live Grep**. Search for text inside all files.                     |
| `<leader>fb` | **Telescope** | **Find Buffers**. Switch between open files.                         |
| `<leader>e`  | **Neo-tree**  | Toggle the **File Explorer** sidebar.                                |
| `s`          | **Leap**      | **Jump on screen**. Press `s` then 2 chars to jump anywhere visible. |

### 🛠️ Coding & LSP

| Key          | Tool          | Description                                                       |
| :----------- | :------------ | :---------------------------------------------------------------- |
| `gd`         | **LSP**       | **Go to Definition**. Jumps to where a function/class is defined. |
| `gr`         | **Telescope** | **Find References**. Shows everywhere a symbol is used.           |
| `K`          | **Lspsaga**   | **Hover**. Shows documentation in a floating window.              |
| `<leader>ca` | **Lspsaga**   | **Code Action**. Shows "Quick Fix" menu (imports, fixes).         |
| `<leader>cr` | **Lspsaga**   | **Rename**. Smart rename of a variable across files.              |
| `<leader>cf` | **LSP**       | **Format**. Prettifies the current file.                          |
| `<leader>cd` | **Lspsaga**   | **Line Diagnostics**. Shows errors for the current line.          |

### 🌳 Git Integration

| Key          | Tool         | Description                                            |
| :----------- | :----------- | :----------------------------------------------------- |
| `<leader>gg` | **LazyGit**  | Opens the **full Git GUI** inside Neovim.              |
| `<leader>gb` | **Gitsigns** | Toggles "Git Blame" virtual text for the current line. |
| `<leader>gs` | **Gitsigns** | Stages the current hunk (changes).                     |
| `<leader>gu` | **Gitsigns** | Undoes the current hunk (changes).                     |

### 🐍 Jupyter / Molten

- **Run Cell:** Select code in Visual Mode -> `:MoltenEvaluateVisual`
- **Initialize:** Open a python file -> `:MoltenInit`
