local ok, bufferline = pcall(require, 'bufferline')
if not ok then
    return vim.notify('COULD NOT LOAD BUFFERLINE', vim.log.levels.ERROR, { title = 'BUFFERLINE' })
end

bufferline.setup {
    options = {
        offsets = {
            {
                filetype = 'NvimTree',
                text = 'File Explorer',
                separator = true,
            },
        },
        numbers = 'ordinal',
        diagnostics = 'nvim_lsp',
    },
}

local keymap = vim.keymap
local opts = { silent = true }

keymap.set('n', '<A-.>', '<CMD>BufferLineCycleNext<CR>', opts)
keymap.set('n', '<A-,>', '<CMD>BufferLineCyclePrev<CR>', opts)

keymap.set('n', '<A-1>', function()
    bufferline.go_to(1, true)
end, opts)
keymap.set('n', '<A-2>', function()
    bufferline.go_to(2, true)
end, opts)
keymap.set('n', '<A-3>', function()
    bufferline.go_to(3, true)
end, opts)
keymap.set('n', '<A-4>', function()
    bufferline.go_to(4, true)
end, opts)
keymap.set('n', '<A-5>', function()
    bufferline.go_to(5, true)
end, opts)
keymap.set('n', '<A-6>', function()
    bufferline.go_to(6, true)
end, opts)
keymap.set('n', '<A-7>', function()
    bufferline.go_to(7, true)
end, opts)
keymap.set('n', '<A-8>', function()
    bufferline.go_to(8, true)
end, opts)
keymap.set('n', '<A-9>', function()
    bufferline.go_to(9, true)
end, opts)
keymap.set('n', '<A-0>', function()
    bufferline.go_to(-1, true)
end, opts)

keymap.set('n', '<A-p>', '<CMD>BufferLineTogglePin<CR>', opts)

keymap.set('n', '<A-Right>', '<CMD>BufferLineMoveNext<CR>', opts)
keymap.set('n', '<A-Left>', '<CMD>BufferLineMovePrev<CR>', opts)

keymap.set('n', '<C-t>', '<CMD>tabedit<CR>', opts)
