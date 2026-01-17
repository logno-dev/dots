return {
  'folke/sidekick.nvim',
  opts = {
    -- add any options here
    cli = {
      mux = {
        backend = 'tmux',
        enabled = true,
      },
      win = {
        layout = "right",
        split = {
          width = 80,
          height = 20,
        },
      },
    },
  },
  -- stylua: ignore
  keys = {
    {
      "<tab>",
      function()
        -- if there is a next edit, jump to it, otherwise apply it if any
        if not require("sidekick").nes_jump_or_apply() then
          return "<Tab>" -- fallback to normal tab
        end
      end,
      expr = true,
      desc = "Goto/Apply Next Edit Suggestion",
    },
    {
      "<leader>aa",
      function() require("sidekick.cli").toggle({ name = "opencode", focus = true }) end,
      desc = "Sidekick Toggle OpenCode",
    },
    {
      "<leader>as",
      function() require("sidekick.cli").select() end,
      -- Or to select only installed tools:
      -- require("sidekick.cli").select({ filter = { installed = true } })
      desc = "Select CLI",
    },
    {
      "<leader>at",
      function() require("sidekick.cli").send({ msg = "{this}" }) end,
      mode = { "x", "n" },
      desc = "Send This",
    },
    {
      "<leader>av",
      function() require("sidekick.cli").send({ msg = "{selection}" }) end,
      mode = { "x" },
      desc = "Send Visual Selection",
    },
    {
      "<leader>ah",
      function()
        require("sidekick.cli").toggle({
          name = "opencode",
          win = { layout = "bottom", split = { height = 15 } }
        })
      end,
      desc = "Sidekick Horizontal Split",
    },
    {
      "<leader>al",
      function()
        require("sidekick.cli").toggle({
          name = "opencode",
          win = { layout = "right", split = { width = 80 } }
        })
      end,
      desc = "Sidekick Vertical Split",
    },
    {
      "<C-k>",
      "<C-\\><C-n><C-u>i",
      mode = "t",
      desc = "Scroll up in terminal",
    },
    {
      "<C-j>",
      "<C-\\><C-n><C-d>i",
      mode = "t",
      desc = "Scroll down in terminal",
    },
    {
      "<leader>ap",
      function() require("sidekick.cli").prompt() end,
      mode = { "n", "x" },
      desc = "Sidekick Select Prompt",
    },
    {
      "<c-.>",
      function() require("sidekick.cli").focus() end,
      mode = { "n", "x", "i", "t" },
      desc = "Sidekick Switch Focus",
    },
    -- Example of a keybinding to open Claude directly
    {
      "<leader>ac",
      function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
      desc = "Sidekick Toggle Claude",
    },
  },
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "netrw",
      callback = function(ev)
        vim.keymap.set("n", "<C-h>", "<C-w>h", { buffer = ev.buf, desc = "Window left" })
        vim.keymap.set("n", "<C-l>", "<C-w>l", { buffer = ev.buf, desc = "Window right" })
      end,
    })
  end,
}
