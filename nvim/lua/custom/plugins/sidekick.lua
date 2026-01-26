return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    -- Required for snacks input/picker
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      provider = {
        enabled = "tmux",
        tmux = {
          -- uses default tmux settings
        },
      },
    }

    -- Required for auto-reload when opencode edits files
    vim.o.autoread = true

    -- Keymaps matching your previous sidekick setup
    local opencode = require("opencode")

    -- Main toggle (was <leader>aa)
    vim.keymap.set({ "n", "t" }, "<leader>aa", function() opencode.toggle() end, { desc = "Toggle OpenCode" })

    -- Send context (was <leader>at for "this")
    vim.keymap.set({ "n", "x" }, "<leader>at", function() opencode.ask("@this: ", { submit = false }) end, { desc = "Send This to OpenCode" })

    -- Send visual selection (was <leader>av)
    vim.keymap.set("x", "<leader>av", function() opencode.ask("@this: ", { submit = false }) end, { desc = "Send Selection to OpenCode" })

    -- Select action/prompt (was <leader>as and <leader>ap)
    vim.keymap.set({ "n", "x" }, "<leader>as", function() opencode.select() end, { desc = "Select OpenCode Action" })
    vim.keymap.set({ "n", "x" }, "<leader>ap", function() opencode.select() end, { desc = "Select OpenCode Prompt" })

    -- Horizontal split (was <leader>ah) - opencode.nvim handles this via provider config
    vim.keymap.set("n", "<leader>ah", function() opencode.toggle() end, { desc = "Toggle OpenCode (horizontal)" })

    -- Vertical split (was <leader>al) - opencode.nvim handles this via provider config
    vim.keymap.set("n", "<leader>al", function() opencode.toggle() end, { desc = "Toggle OpenCode (vertical)" })

    -- Switch focus (was <c-.>)
    vim.keymap.set({ "n", "x", "i", "t" }, "<c-.>", function() opencode.toggle() end, { desc = "Toggle/Focus OpenCode" })

    -- Claude toggle (was <leader>ac) - opencode.nvim is opencode-specific, so this becomes another toggle
    vim.keymap.set("n", "<leader>ac", function() opencode.toggle() end, { desc = "Toggle OpenCode" })

    -- Terminal scroll keymaps (these are terminal-mode generic, keep them)
    vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-u>i", { desc = "Scroll up in terminal" })
    vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-d>i", { desc = "Scroll down in terminal" })

    -- Additional useful opencode.nvim keymaps
    vim.keymap.set({ "n", "x" }, "<C-a>", function() opencode.ask("@this: ", { submit = true }) end, { desc = "Ask OpenCode" })
    vim.keymap.set({ "n", "x" }, "<C-x>", function() opencode.select() end, { desc = "Execute OpenCode action" })

    -- Operator for ranges (vim-y motion support)
    vim.keymap.set({ "n", "x" }, "go", function() return opencode.operator("@this ") end, { expr = true, desc = "Add range to OpenCode" })
    vim.keymap.set("n", "goo", function() return opencode.operator("@this ") .. "_" end, { expr = true, desc = "Add line to OpenCode" })

    -- Netrw: restore window navigation keys
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "netrw",
      callback = function(ev)
        vim.keymap.set("n", "<C-h>", "<C-w>h", { buffer = ev.buf, desc = "Window left" })
        vim.keymap.set("n", "<C-l>", "<C-w>l", { buffer = ev.buf, desc = "Window right" })
      end,
    })
  end,
}
