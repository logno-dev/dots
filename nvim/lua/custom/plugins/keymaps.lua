-- [[ Harpoon ]]
local harpoon = require 'harpoon'
vim.keymap.set('n', '<leader>b', function()
  harpoon:list():add()
end, { desc = 'Add current buffer to harpoon' })
vim.keymap.set('n', '<leader>e', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = 'Open harpoon menu' })

vim.keymap.set('n', '<leader>z', function()
  harpoon:list():select(1)
end, { desc = 'Navigate to harpoon item 1' })
vim.keymap.set('n', '<leader>x', function()
  harpoon:list():select(2)
end, { desc = 'Navigate to harpoon item 2' })
vim.keymap.set('n', '<leader>c', function()
  harpoon:list():select(3)
end, { desc = 'Navigate to harpoon item 3' })
vim.keymap.set('n', '<leader>v', function()
  harpoon:list():select(4)
end, { desc = 'Navigate to harpoon item 4' })

vim.keymap.set('n', '<leader>n', function()
  harpoon:list():next()
end, { desc = 'Navigate to next harpoon item' })
vim.keymap.set('n', '<leader>p', function()
  harpoon:list():prev()
end, { desc = 'Navigate to previous harpoon item' })

vim.keymap.set('n', '<leader>1', function()
  harpoon:list():select(1)
end, { desc = 'Navigate to harpoon item 1' })
vim.keymap.set('n', '<leader>2', function()
  harpoon:list():select(2)
end, { desc = 'Navigate to harpoon item 2' })
vim.keymap.set('n', '<leader>3', function()
  harpoon:list():select(3)
end, { desc = 'Navigate to harpoon item 3' })
vim.keymap.set('n', '<leader>4', function()
  harpoon:list():select(4)
end, { desc = 'Navigate to harpoon item 4' })
vim.keymap.set('n', '<leader>5', function()
  harpoon:list():select(5)
end, { desc = 'Navigate to harpoon item 5' })
vim.keymap.set('n', '<leader>6', function()
  harpoon:list():select(6)
end, { desc = 'Navigate to harpoon item 6' })
vim.keymap.set('n', '<leader>7', function()
  harpoon:list():select(7)
end, { desc = 'Navigate to harpoon item 7' })
vim.keymap.set('n', '<leader>8', function()
  harpoon:list():select(8)
end, { desc = 'Navigate to harpoon item 8' })
vim.keymap.set('n', '<leader>9', function()
  harpoon:list():select(9)
end, { desc = 'Navigate to harpoon item 9' })
vim.keymap.set('n', '<leader>0', function()
  harpoon:list():select(0)
end, { desc = 'Navigate to harpoon item 0' })

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Terminal ]]
vim.keymap.set('n', '<leader>t', ':ToggleTerm<cr>', { desc = 'Toggle Terminal' })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Buffer Nav
vim.keymap.set('n', '[b', ':bprevious<cr>', {})
vim.keymap.set('n', ']b', ':bnext<cr>', {})
vim.keymap.set('n', '<leader>db', ':bdelete<cr>', { desc = 'delete current buffer' })

-- Save file with Ctrl-S
vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'Save file' })
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>', { desc = 'Save file from insert mode' })

-- Save and quit with Ctrl-c
vim.keymap.set('n', '<C-c>', ':wq<CR>', { desc = 'Save and quit' })
vim.keymap.set('i', '<C-c>', '<Esc>:wq<CR>', { desc = 'Save and quit from insert mode' })

-- Close without saving
vim.keymap.set('n', '<C-z>', ':qa!<CR>', { desc = 'Quit!' })
vim.keymap.set('i', '<C-z>', '<Esc>:qa!<CR>', { desc = 'Quit! from insert mode' })

return {}
