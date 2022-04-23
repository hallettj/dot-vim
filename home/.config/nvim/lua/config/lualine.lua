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

require('lualine').setup {
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      {'branch', fmt = truncate(12)},
      'diff', 'diagnostics'},
    lualine_c = {'filename'},
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
