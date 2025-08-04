local keymap = vim.keymap
local opts = { silent = true }

keymap.set('n', '<C-a>', 'ggVG', opts)
keymap.set('v', '<', '<gv', opts)
keymap.set('v', '>', '>gv', opts)

keymap.set('v', 'K', ":m '<-2<CR>gv=gv", opts)
keymap.set('v', 'J', ":m '>+1<CR>gv=gv", opts)

keymap.set('n', '<C-o>', '<CMD>NvimTreeToggle<CR>', opts)
keymap.set('n', '<A-x>', '<CMD>BufDel<CR>', opts)
