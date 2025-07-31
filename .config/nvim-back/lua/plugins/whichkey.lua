return {
   'folke/which-key.nvim',
   -- init = function()
   --    vim.o.timeout = true
   --    vim.o.timeoutlen = 300
   -- end,
   config = function()
      require('which-key').setup({
         trigger = "<leader>",
      })
   end,
}
