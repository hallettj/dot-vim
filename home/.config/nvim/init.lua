-- Install plugins by requiring ~/.config/nivm/lua/plugins.lua
require('plugins')

local opt = vim.opt

opt.encoding = 'utf-8'
opt.scrolloff = 3
opt.wildmode = 'longest'
if vim.fn.has('ttyfast') == 1 then
  opt.ttyfast = true
end

-- Make searches case-sensitive only when capital letters are included.
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- Wrap long lines
opt.wrap = true
opt.textwidth = 80
opt.formatoptions = { c = true, q = true, r = true, n = true, ["1"] = true }

-- Reverse chirality of splits
opt.splitbelow = true
opt.splitright = true

if vim.fn.has('gui_running') == 1 then
  -- Remove menu bar, toolbar, and scrollbars
  opt.guioptions:remove({ 'm', 'T', 'r', 'L' })
end

-- When editing a file, always jump to the last cursor position
vim.api.nvim_create_autocmd('BufReadPost', {
  group = vim.api.nvim_create_augroup('restore-cursor-position', { clear = true }),
  pattern = '*',
  callback = function(opts)
    local last_position = vim.api.nvim_buf_get_mark(opts.buf, '"')
    local line, _ = unpack(last_position)
    local total_lines = vim.api.nvim_buf_line_count(opts.buf)
    if line ~= 0 and line <= total_lines and vim.bo.filetype ~= 'gitcommit' then
      vim.api.nvim_feedkeys([[g`"]], 'nx', false)
    end
  end
})

-- Visuals --

opt.signcolumn = 'auto:1-2'
opt.showcmd = false
opt.foldenable = false

opt.listchars = { tab = '▸ ', trail = '·' }
opt.conceallevel = 0
opt.concealcursor = 'c'

-- Nicer diffs
opt.diffopt = { 'filler', 'internal', 'algorithm:histogram', 'indent-heuristic' }

-- We need to apply the colorscheme synchronously during startup - otherwise
-- Treesitter highlight groups get linked to generic group names. See notes in
-- config/colorscheme-catppuccin.lua.
require('config/colorscheme-catppuccin')


-- Load configuration modules from ~/.config/nvim/lua/init_d/*.lua
require('init_d')
