-- [[ Harpoon ]]
local harpoon = require 'harpoon'
vim.keymap.set('n', '<leader>r', function()
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
local terminal = require 'toggleterm.terminal'
local ui = require 'toggleterm.ui'

local function get_toggleterm_ids()
  local ids = {}
  for _, term in pairs(terminal.get_all()) do
    if term.id then
      table.insert(ids, term.id)
    end
  end
  table.sort(ids)
  return ids
end

local function get_current_toggleterm_id()
  local current_buf = vim.api.nvim_get_current_buf()
  for _, term in pairs(terminal.get_all()) do
    if term.bufnr == current_buf then
      return term.id
    end
  end
  return vim.g.toggleterm_last_id
end

local function get_reuse_window()
  if vim.bo.filetype == 'toggleterm' then
    return vim.api.nvim_get_current_win()
  end

  local has_open, windows = ui.find_open_windows()
  if has_open then
    return windows[#windows].window
  end

  return nil
end

local function open_term_in_place(id)
  local term = terminal.get_or_create_term(id)
  local reuse_window = get_reuse_window()

  if not reuse_window then
    term:toggle()
    return
  end

  if vim.bo.filetype ~= 'toggleterm' then
    ui.set_origin_window()
  end

  if not term.bufnr or not vim.api.nvim_buf_is_valid(term.bufnr) then
    term:spawn()
  end

  term.window = reuse_window
  vim.api.nvim_set_current_win(reuse_window)
  vim.api.nvim_win_set_buf(reuse_window, term.bufnr)
  term:__set_options()
  ui.hl_term(term)
  if term.on_open then
    term:on_open()
  end
end

local function close_open_terms()
  local has_open, windows = ui.find_open_windows()
  if not has_open then
    return false
  end

  for _, window in ipairs(windows) do
    local term = terminal.get(window.term_id)
    if term and term:is_open() then
      term:close()
    end
  end

  return true
end

local function toggle_term(id)
  if close_open_terms() then
    vim.g.toggleterm_last_id = id
    return
  end

  open_term_in_place(id)
  vim.g.toggleterm_last_id = id
end

local function new_term()
  local ids = get_toggleterm_ids()
  local next_id = #ids > 0 and ids[#ids] + 1 or 1
  open_term_in_place(next_id)
  vim.g.toggleterm_last_id = next_id
end

local function cycle_term(direction)
  local ids = get_toggleterm_ids()
  if #ids == 0 then
    toggle_term(1)
    return
  end

  local current_id = get_current_toggleterm_id() or ids[1]
  local current_index = 1
  for index, id in ipairs(ids) do
    if id == current_id then
      current_index = index
      break
    end
  end

  local next_index = current_index + direction
  if next_index < 1 then
    next_index = #ids
  elseif next_index > #ids then
    next_index = 1
  end

  open_term_in_place(ids[next_index])
  vim.g.toggleterm_last_id = ids[next_index]
end

vim.keymap.set('n', '<leader>tt', function()
  toggle_term(1)
end, { desc = 'Toggle Terminal 1' })
vim.keymap.set('n', '<leader>tn', new_term, { desc = 'New Terminal' })
vim.keymap.set('n', '<leader>th', function()
  cycle_term(-1)
end, { desc = 'Previous Terminal' })
vim.keymap.set('n', '<leader>tl', function()
  cycle_term(1)
end, { desc = 'Next Terminal' })
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

-- [[ Toggle Checkbox ]]
-- Function to toggle checkboxes in markdown and org files
local function toggle_checkbox()
  local line = vim.api.nvim_get_current_line()
  local new_line

  -- Markdown checkboxes: - [ ] or - [x]
  if line:match '^%s*[-*+]%s+%[[ xX]%]' then
    if line:match '%[[ ]%]' then
      new_line = line:gsub('%[[ ]%]', '[x]', 1)
    else
      new_line = line:gsub('%[[xX]%]', '[ ]', 1)
    end
    vim.api.nvim_set_current_line(new_line)
    return
  end

  -- Org mode checkboxes: - [ ] or - [X]
  if line:match '^%s*[-*+]%s+%[[ xX]%]' then
    if line:match '%[[ ]%]' then
      new_line = line:gsub('%[[ ]%]', '[X]', 1)
    else
      new_line = line:gsub('%[[xX]%]', '[ ]', 1)
    end
    vim.api.nvim_set_current_line(new_line)
    return
  end

  -- Add checkbox if line starts with list marker but has no checkbox
  if line:match '^%s*[-*+]%s+' and not line:match '%[.-%]' then
    new_line = line:gsub('^(%s*[-*+]%s+)', '%1[ ] ', 1)
    vim.api.nvim_set_current_line(new_line)
  end
end

vim.keymap.set('n', '<leader>mm', toggle_checkbox, { desc = 'Toggle [M]arkdown/Org checkbox' })

-- Refresh all buffers

vim.keymap.set('n', '<leader>R', ':bufdo e!<CR>', { desc = 'reload current buffer' })

return {}
