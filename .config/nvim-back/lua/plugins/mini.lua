return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.move').setup(
      {
        mappings = {
          left = '<M-H>',
          right = '<M-L>',

          line_left = '<M-H>',
          line_right = '<M-L>',

        },
      }
    )
    require('mini.surround').setup()
  end,
}
