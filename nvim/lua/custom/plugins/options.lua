-- Enable break indent
vim.o.breakindent = true

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.colorcolumn = '80'

-- vim.cmd 'setlocal spell spelllang=en_us'
vim.cmd 'set tabstop=2'
vim.cmd 'set shiftwidth=2'
vim.cmd 'set expandtab'
vim.cmd 'set smartindent'

vim.cmd 'command! W w'

return {}
