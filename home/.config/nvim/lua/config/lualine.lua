-- Mode is indicated in status line instead
vim.o.showmode = false

local filetype_aliases = {
  typescript = 'ts',
  typescriptreact = 'tsx',
}

local function truncate(max_len)
  return function(str)
    if string.len(str) <= max_len then
      return str
    end
    return string.sub(str, 1, max_len - 1)..'…'
  end
end

local function format_filetype(ft)
  local alias = filetype_aliases[ft]
  return alias or ft
end

local function coc_status()
  -- Get CoC status, and remove leading whitespace and the string 'Prettier'
  return vim.g.coc_status:gsub('^%s+', ''):gsub('^Prettier%s+', '')
end

-- Termtoggle provides multiple toggleable terminals that are accessed by
-- number. For example, `:2ToggleTerm` brings up terminal number 2.
local function termtoggle_number()
  return vim.b.toggle_number or ''
end

require('lualine').setup {
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      {'branch', fmt = truncate(12)},
      'diff', 'diagnostics'},
    lualine_c = {
      termtoggle_number,
      'filename',
    },
    lualine_x = {
      {'filetype', fmt = format_filetype},
      coc_status,
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {{'filename', path = 1}},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
}

-- Lualine does not automatically select its solarized themes when I set the
-- theme to 'auto'.
vim.api.nvim_create_augroup('SetLualineTheme', {clear=true})
vim.api.nvim_create_autocmd('ColorScheme', {
  group = 'SetLualineTheme',
  pattern = '*',
  callback = function(args)
    local theme = 'auto'
    if args.match == 'solarized' and vim.o.background == 'dark' then
      theme = 'solarized_dark'
    end
    if args.match == 'solarized' and vim.o.background == 'light' then
      theme = 'solarized_light'
    end
    require('lualine').setup {
      options = { theme = theme }
    }
  end,
})
