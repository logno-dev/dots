# Neovim Plugins Summary

## Core Plugins

### Harpoon (File Navigation)
**Plugin**: ThePrimeagen/harpoon (branch: harpoon2)

Quick file navigation and marking system.

**Keymaps**:
- `<leader>r` - Add current buffer to harpoon
- `<leader>e` - Open harpoon menu
- `<leader>z` - Navigate to harpoon item 1
- `<leader>x` - Navigate to harpoon item 2
- `<leader>c` - Navigate to harpoon item 3
- `<leader>v` - Navigate to harpoon item 4
- `<leader>n` - Navigate to next harpoon item
- `<leader>p` - Navigate to previous harpoon item
- `<leader>1-9` - Navigate to harpoon items 1-9
- `<leader>0` - Navigate to harpoon item 0

### Telescope (Fuzzy Finder)
**Plugin**: nvim-telescope/telescope.nvim

Fuzzy finder for files, LSP, and more.

**Keymaps**:
- `<leader>sh` - Search Help
- `<leader>sk` - Search Keymaps
- `<leader>sf` - Search Files
- `<leader>ss` - Search Select Telescope
- `<leader>sw` - Search current Word
- `<leader>sg` - Search by Grep
- `<leader>sd` - Search Diagnostics
- `<leader>sr` - Search Resume
- `<leader>s.` - Search Recent Files
- `<leader><leader>` - Find existing buffers
- `<leader>/` - Fuzzily search in current buffer
- `<leader>s/` - Search in Open Files
- `<leader>sn` - Search Neovim files

### LSP (Language Server Protocol)
**Plugin**: neovim/nvim-lspconfig

Language server support with Mason for automatic installation.

**Keymaps**:
- `grn` - Rename variable
- `gra` - Goto Code Action
- `grr` - Goto References
- `gri` - Goto Implementation
- `grd` - Goto Definition
- `grD` - Goto Declaration
- `gO` - Open Document Symbols
- `gW` - Open Workspace Symbols
- `grt` - Goto Type Definition
- `<leader>th` - Toggle Inlay Hints
- `<leader>q` - Open diagnostic Quickfix list

**Installed Servers**:
- gopls (Go)
- astro (Astro)
- lua_ls (Lua)

### Blink.cmp (Autocompletion)
**Plugin**: saghen/blink.cmp

Code completion with LSP, snippets, buffer, and Copilot integration.

**Keymaps**:
- `<c-y>` - Accept completion

### Conform.nvim (Formatting)
**Plugin**: stevearc/conform.nvim

Code formatting with automatic format on save.

**Keymaps**:
- `<leader>f` - Format buffer

**Settings**:
- Format on save enabled (500ms timeout)
- LSP fallback enabled

### Gitsigns (Git Integration)
**Plugin**: lewis6991/gitsigns.nvim

Git decorations and utilities.

**Keymaps**:
- `]c` - Jump to next git change
- `[c` - Jump to previous git change
- `<leader>hs` - Git stage hunk
- `<leader>hr` - Git reset hunk
- `<leader>hS` - Git Stage buffer
- `<leader>hu` - Git undo stage hunk
- `<leader>hR` - Git Reset buffer
- `<leader>hp` - Git preview hunk
- `<leader>hb` - Git blame line
- `<leader>hd` - Git diff against index
- `<leader>hD` - Git Diff against last commit
- `<leader>tb` - Toggle git show blame line
- `<leader>tD` - Toggle git show Deleted

### DAP (Debugger)
**Plugin**: mfussenegger/nvim-dap

Debug Adapter Protocol support.

**Keymaps**:
- `<F5>` - Debug: Start/Continue
- `<F1>` - Debug: Step Into
- `<F2>` - Debug: Step Over
- `<F3>` - Debug: Step Out
- `<leader>b` - Debug: Toggle Breakpoint
- `<leader>B` - Debug: Set Breakpoint (with condition)
- `<F7>` - Debug: Toggle UI

**Installed Adapters**:
- delve (Go debugger)

### Sidekick (AI Assistant)
**Plugin**: folke/sidekick.nvim

AI coding assistant integration (OpenCode/Claude).

**Backend**: tmux (sidekick cli mux)

**Keymaps**:
- `<tab>` - Goto/Apply Next Edit Suggestion
- `<leader>aa` - Sidekick Toggle OpenCode
- `<leader>as` - Select CLI
- `<leader>at` - Send This (visual/normal)
- `<leader>av` - Send Visual Selection
- `<leader>ah` - Sidekick Horizontal Split
- `<leader>al` - Sidekick Vertical Split
- `<leader>ap` - Sidekick Select Prompt
- `<c-.>` - Sidekick Switch Focus
- `<leader>ac` - Sidekick Toggle Claude
- `<C-k>` (terminal) - Scroll up in terminal
- `<C-j>` (terminal) - Scroll down in terminal

## Editing Plugins

### Mini.nvim
**Plugin**: echasnovski/mini.nvim

Collection of small independent plugins.

**Mini.move Keymaps**:
- `<M-H>` - Move selection/line left
- `<M-L>` - Move selection/line right

**Mini.surround**:
- `saiw)` - Surround Add Inner Word with Paren
- `sd'` - Surround Delete quotes
- `sr)'` - Surround Replace ) with '

**Mini.ai** (Better Around/Inside textobjects):
- `va)` - Visually select Around paren
- `yinq` - Yank Inside Next Quote
- `ci'` - Change Inside quote

### Nvim-autopairs
**Plugin**: windwp/nvim-autopairs

Automatic bracket/quote pairing.

**Settings**:
- Disabled for: markdown, mdx, md files
- Tree-sitter integration enabled

### Nvim-ts-autotag
**Plugin**: windwp/nvim-ts-autotag

Auto-close and auto-rename HTML tags.

### Prettier
**Plugin**: MunifTanjim/prettier.nvim

Code formatter for web technologies.

**Supported Filetypes**:
- JavaScript/TypeScript (including React)
- CSS/SCSS
- JSON/YAML
- HTML/Markdown/MDX
- Vue/Svelte/Astro
- GraphQL

## Navigation & UI

### Neo-tree
**Plugin**: nvim-neo-tree/neo-tree.nvim

File system browser.

**Keymaps**:
- `\` - Toggle NeoTree reveal
- `\` (in Neo-tree) - Close window

### Trouble
**Plugin**: folke/trouble.nvim

Better diagnostics list.

**Keymaps**:
- `<leader>xx` - Diagnostics (Trouble)
- `<leader>xX` - Buffer Diagnostics (Trouble)
- `<leader>cs` - Symbols (Trouble)
- `<leader>cl` - LSP Definitions / references (Trouble)
- `<leader>xL` - Location List (Trouble)
- `<leader>xQ` - Quickfix List (Trouble)

### ToggleTerm
**Plugin**: akinsho/toggleterm.nvim

Terminal management.

**Keymaps**:
- `<leader>t` - Toggle Terminal
- `<Esc>` (terminal mode) - Exit to normal mode

### Lualine
**Plugin**: nvim-lualine/lualine.nvim

Status line with custom header-level integration for markdown.

### Indent-blankline
**Plugin**: lukas-reineke/indent-blankline.nvim

Indentation guides.

## Language-Specific

### Treesitter
**Plugin**: nvim-treesitter/nvim-treesitter

Better syntax highlighting and code understanding.

**Installed Languages**:
- bash, c, diff, html, lua, markdown, vim
- astro, typescript, tsx, javascript, css

### Copilot
**Plugin**: zbirenbaum/copilot.lua + giuxtaposition/blink-cmp-copilot

AI code completion integrated with blink.cmp.

### Orgmode
**Plugin**: nvim-orgmode/orgmode

Org-mode support for Neovim.

**Settings**:
- Agenda files: ~/notes.wiki/**/*
- Default notes: ~/notes.wiki/general.org
- Float window mode

### Header-level (Custom Plugin)
**Plugin**: logno-dev/header-level.nvim

Markdown header level indicator in statusline.

**Settings**:
- Virtual text: disabled
- Header tree: enabled
- Position: fixed_corner
- Inverted colors: true

**Keymaps**:
- `<leader>mh` - Toggle the plugin on/off
- `<leader>mt` - Toggle the header tree outline display
- `<leader>mv` - Toggle virtual text display

### Vim-markdown
**Plugin**: preservim/vim-markdown

Markdown folding support with pythonic style.

**Settings**:
- Folding: enabled
- Pythonic folding style

**Folding Keymaps** (standard Vim fold commands):
- `zo` - Open fold under cursor
- `zc` - Close fold under cursor
- `za` - Toggle fold under cursor
- `zR` - Open all folds
- `zM` - Close all folds
- `zr` - Open one fold level throughout file
- `zm` - Close one fold level throughout file
- `zj` - Move to next fold
- `zk` - Move to previous fold
- `[z` - Move to start of current fold
- `]z` - Move to end of current fold

### Nvim-lint
**Plugin**: mfussenegger/nvim-lint

Linting integration (currently no linters configured).

## Utility Plugins

### Which-key
**Plugin**: folke/which-key.nvim

Displays pending keybinds.

**Key Groups**:
- `<leader>s` - [S]earch
- `<leader>t` - [T]oggle
- `<leader>h` - Git [H]unk

### Todo-comments
**Plugin**: folke/todo-comments.nvim

Highlight TODO, NOTE, etc. in comments.

### Guess-indent
**Plugin**: NMAC427/guess-indent.nvim

Automatically detect tabstop and shiftwidth.

## General Keymaps (Outside Plugins)

### Navigation
- `k` - Move up (respects word wrap)
- `j` - Move down (respects word wrap)
- `<C-h>` - Move focus to left window
- `<C-l>` - Move focus to right window
- `<C-j>` - Move focus to lower window
- `<C-k>` - Move focus to upper window
- `-` - Open netrw (file explorer)

### Buffer Management
- `[b` - Previous buffer
- `]b` - Next buffer
- `<leader>db` - Delete current buffer

### File Operations
- `<C-s>` - Save file (normal/insert mode)
- `<C-c>` - Save and quit (normal/insert mode)
- `<C-z>` - Quit without saving (normal/insert mode)

### Clipboard
- `P` - Paste from system clipboard
- `Y` (visual) - Yank to system clipboard
- `YY` - Yank line to system clipboard

### Other
- `<Esc>` - Clear search highlights
- `<leader>us` - Toggle Spellcheck
- `<leader>m` - Toggle Markdown/Org checkbox
- `<Esc><Esc>` (terminal) - Exit terminal mode

## Color Scheme

**Plugin**: rebelot/kanagawa.nvim

Currently using: kanagawa-dragon theme with transparency enabled.

## Notes

- Leader key: `<Space>`
- Local leader: `<Space>`
- Mouse: disabled
- Spell check: enabled (en_us)
- Relative line numbers: enabled
- Format on save: enabled for most filetypes
