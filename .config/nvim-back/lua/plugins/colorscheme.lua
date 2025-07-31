return {
  -- {
  --   "loctvl842/monokai-pro.nvim",
  --   lazy = false,
  --   -- priority = 1000,
  --   config = function()
  --     require("monokai-pro").setup({
  --       filter = "machine",
  --       transparent_background = true,
  --     })
  --     -- vim.cmd.colorscheme 'monokai-pro'
  --   end,
  -- },
  -- {
  --   "marko-cerovac/material.nvim",
  --   lazy = false,
  --   -- priority = 1000,
  --   config = function()
  --     require("material").setup({
  --       disable = {
  --         background = true,
  --       },
  --     })
  --     -- vim.g.material_style = "darker"
  --     -- vim.cmd [[colorscheme material]]
  --   end,
  -- },
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   -- priority = 1000,
  --   config = function()
  --     require("tokyonight").setup({
  --       style = "night",
  --       transparent = true,
  --     })
  --     -- vim.cmd [[colorscheme tokyonight-night]]
  --   end,
  -- },
  -- {
  --   "ofirgall/ofirkai.nvim",
  --   lazy = false,
  --   -- priority = 1000,
  --   config = function()
  --     require("ofirkai").setup({
  --       theme = "dark_blue",
  --     })
  --     -- vim.cmd.colorscheme 'ofirkai-darkblue'
  --   end,
  -- },
  -- -- {
  -- --   "kaiuri/nvim-juliana",
  -- --   lazy = false,
  -- -- priority = 1000,
  -- -- config = function()
  -- -- vim.cmd.colorscheme 'juliana'
  -- -- end,
  -- -- },
  -- {
  --   "rose-pine/neovim",
  --   name = "rose-pine",
  --   lazy = false,
  --   -- priority = 1000,
  --   config = function()
  --     require("rose-pine").setup({
  --       disable_background = true,
  --     })
  --     -- vim.cmd.colorscheme("rose-pine-main")
  --   end,
  -- },
  -- {
  --   "Shatur/neovim-ayu",
  --   name = "ayu",
  --   lazy = false,
  --   config = function()
  --     require("ayu").setup({
  --       overrides = {
  --         Normal = { bg = "None" },
  --         ColorColumn = { bg = "None" },
  --         SignColumn = { bg = "None" },
  --         Folded = { bg = "None" },
  --         FoldColumn = { bg = "None" },
  --         CursorLine = { bg = "None" },
  --         CursorColumn = { bg = "None" },
  --         WhichKeyFloat = { bg = "None" },
  --         VertSplit = { bg = "None" },
  --       },
  --     })
  --     -- vim.cmd.colorscheme("ayu")
  --   end,
  -- },
  -- {
  --   "projekt0n/github-nvim-theme",
  --   lazy = false,
  --   config = function()
  --     require('github-theme').setup({
  --       options = {
  --         transparent = true,
  --       }
  --     })
  --     -- vim.cmd.colorscheme("github_dark_dimmed")
  --   end,
  -- },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        transparent = true,
      })
      vim.cmd.colorscheme 'kanagawa-dragon'
      -- vim.cmd.colorscheme 'kanagawa-wave'
      -- vim.cmd.colorscheme 'kanagawa'
    end,
  },
}
