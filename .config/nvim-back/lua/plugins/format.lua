return {
  {
    'stevearc/conform.nvim',
    opts = {
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true
      }
    },
  },

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {
      disable_filetype = { "markdown", "mdx", "md" },
      check_ts = true,
      disable_in_visualblock = true,
    },
  },

  {
    'windwp/nvim-ts-autotag',
    opts = {
      autotag = {
        enable = true,
      }
    }
  },
  {
    'MunifTanjim/prettier.nvim',
    opts = {
      bin = 'prettierd',
      filetypes = { 'javascript', 'typescript', 'css', 'scss', 'json', 'yaml', 'html', 'markdown', 'mdx', 'vue', 'svelte', 'graphql', 'javascriptreact', 'typescriptreact', 'javascript.jsx', 'typescript.tsx', 'javascriptreact', 'typescriptreact', 'astro' },
      single_quote = false,
      trailing_comma = 'all',
      config_precedence = 'prefer-file',
      bracket_spacing = true,
      jsx_bracket_same_line = false,
      arrow_parens = 'avoid',
      print_width = 80,
      tab_width = 2,
    }
  },
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },
}
