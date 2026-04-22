return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    -- Required for snacks input/picker
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    local fallback = require("opencode.terminal")

    local function tmux_available()
      return vim.fn.executable("tmux") == 1 and vim.env.TMUX and vim.env.TMUX ~= ""
    end

    local opencode_pane_id

    local function tmux_pane_exists(pane_id)
      if not pane_id or pane_id == "" then
        return false
      end

      local panes = vim.fn.system({ "tmux", "list-panes", "-a", "-F", "#{pane_id}" })
      if vim.v.shell_error ~= 0 then
        return false
      end

      for _, pane in ipairs(vim.split(panes, "\n", { trimempty = true })) do
        if pane == pane_id then
          return true
        end
      end

      return false
    end

    local function tmux_start()
      if tmux_pane_exists(opencode_pane_id) then
        return
      end

      local pane = vim.fn.system({ "tmux", "split-window", "-h", "-p", "50", "-d", "-P", "-F", "#{pane_id}", "opencode --port" })
      if vim.v.shell_error == 0 then
        opencode_pane_id = vim.trim(pane)
      end
    end

    local function tmux_toggle()
      if not tmux_pane_exists(opencode_pane_id) then
      local pane = vim.fn.system({ "tmux", "split-window", "-h", "-p", "50", "-P", "-F", "#{pane_id}", "opencode --port" })
        if vim.v.shell_error == 0 then
          opencode_pane_id = vim.trim(pane)
        end
        return
      end

      local current_pane = vim.trim(vim.fn.system({ "tmux", "display-message", "-p", "#{pane_id}" }))
      if current_pane == opencode_pane_id then
        vim.fn.system({ "tmux", "select-pane", "-l" })
      else
        vim.fn.system({ "tmux", "select-pane", "-t", opencode_pane_id })
      end
    end

    ---@type opencode.Opts
    vim.g.opencode_opts = {
      server = {
        start = function()
          if tmux_available() then
            tmux_start()
          else
            fallback.open("opencode --port", {
              split = "right",
              width = math.floor(vim.o.columns * 0.35),
            })
          end
        end,
        stop = function()
          if tmux_available() then
            if tmux_pane_exists(opencode_pane_id) then
              vim.fn.system({ "tmux", "kill-pane", "-t", opencode_pane_id })
            end
            opencode_pane_id = nil
          else
            fallback.close()
          end
        end,
        toggle = function()
          if tmux_available() then
            tmux_toggle()
          else
            fallback.toggle("opencode --port", {
              split = "right",
              width = math.floor(vim.o.columns * 0.35),
            })
          end
        end,
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

    -- Horizontal split (was <leader>ah) - opencode.nvim handles this via server config
    vim.keymap.set("n", "<leader>ah", function() opencode.toggle() end, { desc = "Toggle OpenCode (horizontal)" })

    -- Vertical split (was <leader>al) - opencode.nvim handles this via server config
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
