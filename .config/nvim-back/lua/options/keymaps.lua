-- [[ telescope keymaps ]]

local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    print("Not a git repository. Searching on current working directory")
    return cwd
  end
  return git_root
end

vim.keymap.set("n", "<leader>f", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "[/] Fuzzily search in current buffer" })

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require("telescope.builtin").live_grep({
      search_dirs = { git_root },
    })
  end
end

vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })

local function telescope_live_grep_open_files()
  require("telescope.builtin").live_grep({
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  })
end
vim.keymap.set("n", "<leader>s/", telescope_live_grep_open_files, { desc = "[S]earch [/] in Open Files" })
vim.keymap.set("n", "<leader>ss", require("telescope.builtin").builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>sa", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sG", ":LiveGrepGitRoot<cr>", { desc = "[S]earch by [G]rep on Git Root" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

-- Netrw
vim.keymap.set("n", "-", ":Ex<cr>", { remap = true })

-- Buffer Nav
vim.keymap.set("n", "[b", ":bprevious<cr>", {})
vim.keymap.set("n", "]b", ":bnext<cr>", {})
vim.keymap.set("n", "<leader>db", ":bdelete<cr>", { desc = "delete current buffer" })

-- Spellcheck
vim.keymap.set("n", "<leader>us", ":setlocal spell! spelllang=en_us<cr>", { desc = "Toggle Spellcheck" })

-- Copilot
vim.keymap.set("i", "<C-c>", 'copilot#Accept("<CR>")', { silent = true, expr = true, replace_keycodes = false })
vim.g.copilot_no_tab_map = true

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- [[ Splits ]]
vim.keymap.set("n", "<leader>\\", ":vsplit<cr>", { desc = "Vertical Split" })
vim.keymap.set("n", "<leader>-", ":split<cr>", { desc = "Horizontal Split" })
vim.keymap.set("n", "H", "<C-w>h", { remap = true, desc = "Move to left split" })
vim.keymap.set("n", "J", "<C-w>j", { remap = true, desc = "Move to bottom split" })
vim.keymap.set("n", "K", "<C-w>k", { remap = true, desc = "Move to top split" })
vim.keymap.set("n", "L", "<C-w>l", { remap = true, desc = "Move to right split" })

-- [[ LazyGit ]]
vim.keymap.set("n", "<leader>gg", ":LazyGit<cr>", { desc = "LazyGit" })

-- [[ Session Management ]]
vim.keymap.set("n", "<leader>ms", ":wall<cr>:mksession! ~/.vimsessions/", { desc = "Save Session" })
vim.keymap.set("n", "<leader>mr", ":wall<cr>:source ~/.vimsessions/", { desc = "Restore Session" })

-- [[ Close and Exit ]]
vim.keymap.set("n", "<leader>w", ":w<cr>", { desc = "Save" })
vim.keymap.set("n", "<leader>ww", ":wall<cr>", { desc = "Save All" })
vim.keymap.set("n", "<leader>wq", ":wq<cr>", { desc = "Save and Quit" })
vim.keymap.set("n", "<leader>qw", ":q<cr>", { desc = "Quit buffer" })
vim.keymap.set("n", "<leader>qqq", ":q!<cr>", { desc = "Quit without saving" })
vim.keymap.set("n", "<leader>ws", function()
  local file = vim.fn.expand("%")
  vim.cmd("w")
  vim.cmd("silent !git add " .. file .. ' && git commit -m "$(date)" && git push')
end, { desc = "Save, commit, and push file to remote repo" })
vim.keymap.set("n", "<leader>wa", function()
  local git_root = find_git_root()
  vim.cmd("wall")
  vim.cmd("!cd " .. git_root .. '&& git add . && git commit -m "$(date)" && git push')
end, { desc = "Save all buffers, commit all changed files, and push commit to remote repo" })

-- [[ Terminal ]]
vim.keymap.set("n", "<leader>/", ":ToggleTerm<cr>", { desc = "Toggle Terminal" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- [[ Harpoon ]]
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>b", function()
  harpoon:list():add()
end, { desc = "Add current buffer to harpoon" })
vim.keymap.set("n", "<leader>e", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Open harpoon menu" })

vim.keymap.set("n", "<leader>z", function()
  harpoon:list():select(1)
end, { desc = "Navigate to harpoon item 1" })
vim.keymap.set("n", "<leader>x", function()
  harpoon:list():select(2)
end, { desc = "Navigate to harpoon item 2" })
vim.keymap.set("n", "<leader>c", function()
  harpoon:list():select(3)
end, { desc = "Navigate to harpoon item 3" })
vim.keymap.set("n", "<leader>v", function()
  harpoon:list():select(4)
end, { desc = "Navigate to harpoon item 4" })

vim.keymap.set("n", "<leader>n", function()
  harpoon:list():next()
end, { desc = "Navigate to next harpoon item" })
vim.keymap.set("n", "<leader>p", function()
  harpoon:list():prev()
end, { desc = "Navigate to previous harpoon item" })

vim.keymap.set("n", "<leader>1", function()
  harpoon:list():select(1)
end, { desc = "Navigate to harpoon item 1" })
vim.keymap.set("n", "<leader>2", function()
  harpoon:list():select(2)
end, { desc = "Navigate to harpoon item 2" })
vim.keymap.set("n", "<leader>3", function()
  harpoon:list():select(3)
end, { desc = "Navigate to harpoon item 3" })
vim.keymap.set("n", "<leader>4", function()
  harpoon:list():select(4)
end, { desc = "Navigate to harpoon item 4" })
vim.keymap.set("n", "<leader>5", function()
  harpoon:list():select(5)
end, { desc = "Navigate to harpoon item 5" })
vim.keymap.set("n", "<leader>6", function()
  harpoon:list():select(6)
end, { desc = "Navigate to harpoon item 6" })
vim.keymap.set("n", "<leader>7", function()
  harpoon:list():select(7)
end, { desc = "Navigate to harpoon item 7" })
vim.keymap.set("n", "<leader>8", function()
  harpoon:list():select(8)
end, { desc = "Navigate to harpoon item 8" })
vim.keymap.set("n", "<leader>9", function()
  harpoon:list():select(9)
end, { desc = "Navigate to harpoon item 9" })
vim.keymap.set("n", "<leader>0", function()
  harpoon:list():select(0)
end, { desc = "Navigate to harpoon item 0" })

-- [[ Trouble - error handling]]
vim.keymap.set("n", "<leader>tt", function()
  require("trouble").toggle()
end, { desc = "Toggle Trouble" })
vim.keymap.set("n", "<leader>tw", function()
  require("trouble").toggle("workspace_diagnostics")
end, { desc = "Toggle Workspace Trouble" })
vim.keymap.set("n", "<leader>td", function()
  require("trouble").toggle("document_diagnostics")
end, { desc = "Toggle Document Trouble" })
vim.keymap.set("n", "<leader>tq", function()
  require("trouble").toggle("quickfix")
end, { desc = "Toggle Quickfix Trouble" })
vim.keymap.set("n", "<leader>tl", function()
  require("trouble").toggle("loclist")
end, { desc = "Toggle Loclist Trouble" })
vim.keymap.set("n", "gR", function()
  require("trouble").toggle("lsp_references")
end, { desc = "Toggle LSP References Trouble" })

-- [[ TODO.nvim ]]
vim.keymap.set("n", "<leader>ll", ":TodoTelescope<cr>", { desc = "Open TODO Telescope" })

-- [[ hjkl navigation in insert mode ]]
vim.keymap.set("i", "<M-L>", "<right>", { silent = true })
vim.keymap.set("i", "<M-H>", "<left>", { silent = true })
vim.keymap.set("i", "<M-k>", "<up>", { silent = true })
vim.keymap.set("i", "<M-j>", "<down>", { silent = true })

-- [[ copy and paste to unnamedplus ]]
vim.keymap.set("n", "P", '"+p')
vim.keymap.set("v", "Y", '"+y')
vim.keymap.set("n", "YY", '"+yy')

