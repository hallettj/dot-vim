local wk = require('which-key')
local map = vim.keymap.set

-- Set <leader> to <space>
vim.g.mapleader = ' '

-- Swap : and ,
map({ 'n', 'v' }, ',', ':')
map({ 'n', 'v' }, ':', ',')

-- Swap ' and `
map({ 'n', 'v' }, "'", '`')
map({ 'n', 'v' }, '`', "'")

-- Replace ; and : with Lightspeed versions - overrides : binding above
map({ 'n', 'x' }, ';', '<plug>Lightspeed_;_ft', { remap = true, silent = true })
map({ 'n', 'x' }, ':', '<plug>Lightspeed_,_ft', { remap = true, silent = true })

-- Window management shortcuts
wk.register {
    ['<leader>-'] = { '<c-w>_', 'maximize vertically' },
    ['<leader>='] = { '<c-w>=', 'equal window sizes' }
}

-- Retain selection in visual mode when indenting blocks
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Makes vim's visual mode more consistent with tmux's
map('v', '<enter>', 'y')

-- System copy/paste shortcuts
-- These come from:
-- http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
for _, mode in ipairs { 'n', 'v' } do
    wk.register({
        y = { '"+y', 'yank to system clipboard' },
        p = { '"+p', 'put after from system clipboard' },
        P = { '"+P', 'put before from system clipboard' }
    }, { mode, prefix = '<leader>' })
end

-- Navigation

wk.register {
    ['<c-p>'] = { '<cmd>Telescope find_files<cr>', 'find file' },
    ['<leader>b'] = { '<cmd>Telescope buffers<cr>', 'find buffer' },
    ['<leader>s'] = { '<cmd>SymbolsOutline<cr>', 'toggle symbol outline' },
}

-- Telescope finders
wk.register({
    name = '+finders',
    f = { '<cmd>Telescope find_files<cr>', 'files' },
    p = { "<cmd>lua require('find_directories').find_projects{}<cr>", 'projects' },
    g = { '<cmd>Telescope live_grep<cr>', 'live grep' },
    b = { '<cmd>Telescope buffers<cr>', 'buffers' },
    h = { '<cmd>Telescope help_tags<cr>', 'help tags' },
    c = { '<cmd>Telescope colorscheme<cr>', 'color schemes' }
}, { prefix = '<leader>f' })

-- Where am I?
wk.register({
    ['<leader>H'] = {
        function() print(vim.fn.expand('%:p')) end, 'show file path'
    }
}, { silent = true })

-- IDE features
local fmt = function(cmd) return function(str) return cmd:format(str) end end
local lsp = fmt('<cmd>lua vim.lsp.%s<cr>')
local diagnostic = fmt('<cmd>lua vim.diagnostic.%s<cr>')
local telescope = fmt('<cmd>Telescope %s<cr>')
local trouble = fmt('<cmd>Trouble %s<cr>')

wk.register({
    K = { lsp 'buf.hover()', 'show documentation for symbol under cursor' },
    gd = { telescope 'lsp_definitions', 'go to definition' },
    gD = { lsp 'buf.declaration()', 'go to declaration' },
    gy = { telescope 'lsp_type_definitions', 'go to type' },
    gi = { telescope 'lsp_implementations', 'go to implementation' },
    gr = { telescope 'lsp_references', 'find references' },
    gR = { trouble 'lsp_references', 'list references' },
    gl = { diagnostic 'open_float()', 'show diagnostic info' },
    ['[d'] = { diagnostic 'goto_prev()', 'previous diagnostic' },
    [']d'] = { diagnostic 'goto_next()', 'next diagnostic' },
    ['[D'] = { diagnostic 'goto_prev({ severity = { min = vim.diagnostic.severity.ERROR } })', 'previous error' },
    [']D'] = { diagnostic 'goto_next({ severity = { min = vim.diagnostic.severity.ERROR } })', 'next error' },
    ['[x'] = { function() require('trouble').previous({ skip_groups = true, jump = true }) end,
        'previous item from Trouble' },
    [']x'] = { function() require('trouble').next({ skip_groups = true, jump = true }) end,
        'next item from Trouble' },
    ['<leader><space>'] = {
        vim.fn.has('nvim-0.8') == 1
            and function() vim.lsp.buf.format({ async = true }) end
            or '<cmd>LspZeroFormat<cr>',
        'format document'
    },
    ['<leader>u'] = { '<cmd>MundoToggle<cr>', 'toggle Mundo' },
})

wk.register({
    name = '+IDE',
    c = { lsp 'buf.code_action()', 'code actions at cursor or selection' },
    l = { lsp 'codelens.run()', 'codelens command of current line' },
    q = { lsp 'buf.code_action({ only = {"quickfix"} })', 'quickfix at cursor or selection' },
    r = { lsp 'buf.rename()', 'rename' },
    R = { lsp 'buf.code_action({ only = {"refactor"} })', 'refactor at cursor or selection' },
}, { prefix = '<leader>c', remap = true })
wk.register({
    name = '+IDE',
    a = { lsp 'buf.code_action()', 'code actions at cursor or selection' },
    q = { lsp 'buf.code_action({ only = {"quickfix"} })', 'quickfix for cursor or selection' },
    R = { lsp 'buf.code_action({ only = {"refactor"} })', 'refactor for cursor or selection' },
}, { prefix = '<leader>c', mode = 'v' })

wk.register({
    name = '+lists',
    d = { telescope 'diagnostics bufnr=0', 'diagnostics for buffer' },
    D = { telescope 'diagnostics', 'diagnostics for all buffers' },
}, { prefix = '<leader>l' })

wk.register({
    name = '+loclist',
    x = { trouble '', 'diagnostics (same mode as last used)' },
    w = { trouble 'workspace_diagnostics', 'workspace diagnostics ' },
    d = { trouble 'document_diagnostics', 'document diagnostics' },
    l = { trouble 'loclists', 'location list' },
    q = { trouble 'quickfix', 'quickfix list' },
    c = { '<cmd>TroubleClose<cr>', 'close Trouble' },
}, { prefix = '<leader>x', silent = true })

-- Debugging
local dap = fmt('<cmd>lua require("dap").%s<cr>')
wk.register({
    name = '+debug',
    s = {
        name = '+step',
        c = { dap 'continue()', 'Continue' },
        v = { dap 'step_over()', 'Step Over' },
        i = { dap 'step_into()', 'Step Into' },
        o = { dap 'step_out()', 'Step Out' },
    },
    h = {
        name = '+hover',
        h = { "<cmd>lua require('dap.ui.variables').hover()<CR>", 'Hover' },
        v = { "<cmd>lua require('dap.ui.variables').visual_hover()<CR>", 'Visual Hover' },
    },
    u = {
        name = '+UI',
        h = { "<cmd>lua require('dap.ui.widgets').hover()<CR>", 'Hover' },
        f = { "local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>", 'Float' },
    },
    r = {
        name = '+repl',
        o = { dap 'repl.open()', 'Open' },
        l = { dap 'repl.run_last()', 'Run Last' },
    },
    b = {
        name = '+breakpoints',
        c = {
            dap 'set_breakpoint(vim.fn.input("Breakpoint condition: "))',
            'Breakpoint Condition',
        },
        m = {
            dap 'set_breakpoint({ nil, nil, vim.fn.input("Log point message: ") })',
            'Log Point Message',
        },
        t = { dap 'toggle_breakpoint()', 'Create' },
    },
    c = { dap 'scopes()', 'Scopes' },
    i = { dap 'toggle()', 'Toggle' },
}, { prefix = '<leader>d' })

-- wk.register({
--     name = "+CocList",
--     a = {":<C-u>CocList diagnostics<cr>"},
--     c = {":<C-u>CocList commands<cr>"},
--     e = {":<C-u>CocList extensions<cr>"},
--     o = {":<C-u>CocList outline<cr>"},
--     p = {":<C-u>CocList project<cr>"},
--     s = {":<C-u>CocList services<cr>"}
-- }, {prefix = "<leader>d", silent = true})

-- tpope/vim-fugitive
wk.register({
    name = '+git',
    s = { '<cmd>vert Git<CR>', 'git status in vert split' },
    d = { '<cmd>Gvdiffsplit<CR>', 'git diff in vert splits' },
    c = { '<cmd>Git commit<CR>', 'git commit' },
    b = { '<cmd>Git blame<CR>', 'git blame' },
    l = { '<cmd>GV<cr>', 'log graph for branch' },
    L = { '<cmd>GV --all<cr>', 'log graph for all branches' },
    e = { '<cmd>Gedit<space>', 'open file from history, e.g. :Gedit HEAD^:%' },
    p = { '<cmd>Git push<CR>', 'push' },
    w = { '<cmd>Gwrite<CR>', 'write file and stage' },
    r = { ':GRename<space>', 'rename file - enter path relative to current file' },
    R = { '<cmd>Gremove<CR>', 'git rm' }
}, { prefix = '<leader>g' })

-- See gitsigns bindings in config/gitsigns.lua for:
-- - <leader>h
-- - <leader>tb, <leader>td
-- - ]c, [c
-- - ih

-- gh.nvim bindings
wk.register({
    name = '+Github',
    c = {
        name = '+Commits',
        c = { '<cmd>GHCloseCommit<cr>', 'Close' },
        e = { '<cmd>GHExpandCommit<cr>', 'Expand' },
        o = { '<cmd>GHOpenToCommit<cr>', 'Open To' },
        p = { '<cmd>GHPopOutCommit<cr>', 'Pop Out' },
        z = { '<cmd>GHCollapseCommit<cr>', 'Collapse' }
    },
    i = { name = '+Issues', p = { '<cmd>GHPreviewIssue<cr>', 'Preview' } },
    l = { name = '+Litee', t = { '<cmd>LTPanel<cr>', 'Toggle Panel' } },
    r = {
        name = '+Review',
        b = { '<cmd>GHStartReview<cr>', 'Begin' },
        c = { '<cmd>GHCloseReview<cr>', 'Close' },
        d = { '<cmd>GHDeleteReview<cr>', 'Delete' },
        e = { '<cmd>GHExpandReview<cr>', 'Expand' },
        s = { '<cmd>GHSubmitReview<cr>', 'Submit' },
        z = { '<cmd>GHCollapseReview<cr>', 'Collapse' }
    },
    p = {
        name = '+Pull Request',
        c = { '<cmd>GHClosePR<cr>', 'Close' },
        d = { '<cmd>GHPRDetails<cr>', 'Details' },
        e = { '<cmd>GHExpandPR<cr>', 'Expand' },
        o = { '<cmd>GHOpenPR<cr>', 'Open' },
        p = { '<cmd>GHPopOutPR<cr>', 'PopOut' },
        r = { '<cmd>GHRefreshPR<cr>', 'Refresh' },
        t = { '<cmd>GHOpenToPR<cr>', 'Open To' },
        z = { '<cmd>GHCollapsePR<cr>', 'Collapse' }
    },
    t = {
        name = '+Threads',
        c = { '<cmd>GHCreateThread<cr>', 'Create' },
        n = { '<cmd>GHNextThread<cr>', 'Next' },
        t = { '<cmd>GHToggleThread<cr>', 'Toggle' }
    }
}, { prefix = '<leader>gh' })

wk.register({
    name = '+math',
    a = {
        '<plug>(coc-calc-result-append)',
        'evaluate math expression on line, and append result'
    },
    r = {
        '<plug>(coc-calc-result-replace)',
        'evaluate math expression on line, and replace with result'
    }
}, { prefix = '<leader>m', remap = true })

-- Magic Registers
wk.register({
    d = { '"=strftime("%F")<cr>', 'put current date in unnamed register' },
    p = {
        '"=expand("%:p:h")<cr>',
        'put directory of open file in unnamed register'
    }
}, { prefix = '<leader>"' })
