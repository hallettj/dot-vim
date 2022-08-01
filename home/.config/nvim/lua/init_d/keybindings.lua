local wk = require('which-key')
local map = vim.keymap.set

local function pumvisible() return vim.fn["coc#pum#visible"]() ~= 0 end

-- Set <leader> to <space>
vim.g.mapleader = " "

-- Swap : and ,
map({"n", "v"}, ",", ":")
map({"n", "v"}, ":", ",")

-- Swap ' and `
map({"n", "v"}, "'", "`")
map({"n", "v"}, "`", "'")

-- Replace ; and : with Lightspeed versions - overrides : binding above
map({"n", "x"}, ";", "<plug>Lightspeed_;_ft", {remap = true, silent = true})
map({"n", "x"}, ":", "<plug>Lightspeed_,_ft", {remap = true, silent = true})

-- Window management shortcuts
wk.register {
    ["<leader>-"] = {"<c-w>_", "maximize vertically"},
    ["<leader>="] = {"<c-w>=", "equal window sizes"}
}

-- Retain selection in visual mode when indenting blocks
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Makes vim's visual mode more consistent with tmux's
map("v", "<enter>", "y")

-- System copy/paste shortcuts
-- These come from:
-- http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
for _, mode in ipairs {"n", "v"} do
    wk.register({
        y = {'"+y', "yank to system clipboard"},
        p = {'"+p', "put after from system clipboard"},
        P = {'"+P', "put before from system clipboard"}
    }, {mode, prefix = "<leader>"})
end

-- Navigation

wk.register {
    ["<c-p>"] = {"<cmd>Telescope find_files<cr>", "find file"},
    ["<leader>b"] = {"<cmd>Telescope buffers<cr>", "find buffer"}
}

-- Telescope finders
wk.register({
    name = "+finders",
    f = {"<cmd>Telescope find_files<cr>", "files"},
    p = {"<cmd>lua require('find_directories').find_projects{}<cr>", "projects"},
    g = {"<cmd>Telescope live_grep<cr>", "live grep"},
    b = {"<cmd>Telescope buffers<cr>", "buffers"},
    h = {"<cmd>Telescope help_tags<cr>", "help tags"},
    c = {"<cmd>Telescope colorscheme<cr>", "color schemes"}
}, {prefix = "<leader>f"})

wk.register({
    name = "+CocList",
    a = {":<C-u>CocList diagnostics<cr>"},
    c = {":<C-u>CocList commands<cr>"},
    e = {":<C-u>CocList extensions<cr>"},
    o = {":<C-u>CocList outline<cr>"},
    p = {":<C-u>CocList project<cr>"},
    s = {":<C-u>CocList services<cr>"}
}, {prefix = "<leader>d", silent = true})

-- Where am I?
wk.register({
    ["<leader>H"] = {
        function() print(vim.fn.expand("%:p")) end, "show file path"
    }
}, {silent = true})

-- IDE features
wk.register({
    name = "+IDE",
    a = {
        "<Plug>(coc-codeaction-selected)", "code actions for selection / motion"
    },
    c = {"<Plug>(coc-codeaction-line)", "code actions for current line"},
    f = {"<Plug>(coc-codeaction)", "code actions for entire file"},
    F = {"<Plug>(coc-format-selected)", "format selected"},
    g = {"<Plug>(coc-openlink)", "open link under cursor"},
    l = {"<Plug>(coc-codelens-action)", "codelens command of current line"},
    q = {"<Plug>(coc-fix-current)", "quickfix current line"},
    r = {"<Plug>(coc-rename)", "rename"},
    R = {"<Plug>(coc-refactor)", "refactor"}
}, {prefix = "<leader>c", remap = true})
wk.register({
    name = "+IDE",
    a = {
        "<Plug>(coc-codeaction-selected)", "code actions for selection / motion"
    },
    F = {"<Plug>(coc-format-selected)", "format selected"}
}, {prefix = "<leader>c", mode = "v"})

local function show_documentation()
    if vim.bo.filetype == "vim" then
        vim.cmd("h " .. vim.fn.expand("<cword>"))
    else
        vim.fn.CocAction("doHover")
    end
end

wk.register({
    gd = {"<plug>(coc-definition)", "go to definition"},
    gy = {"<plug>(coc-type-definition)", "go to type"},
    gi = {"<plug>(coc-implementation)", "go to implementation"},
    gr = {"<cmd>Telescope coc references<cr>", "list references"},
    K = {show_documentation, "show documentation"},
    ["[."] = {"<plug>(coc-diagnostic-prev)", "previous diagnostic"},
    ["]."] = {"<plug>(coc-diagnostic-next)", "next diagnostic"},
    ["[>"] = {"<plug>(coc-diagnostic-prev-error)", "previous error"},
    ["]>"] = {"<plug>(coc-diagnostic-next-error)", "next error"},
    ["<leader>?"] = {
        "<cmd>call CocAction('diagnosticInfo')<cr>", "show diagnostic info"
    }
}, {silent = true})

map("n", "<leader><space>", "<cmd>CocCommand editor.action.formatDocument<cr>",
    {remap = true})
wk.register {
    ["<leader><space>"] = {
        "<cmd>CocCommand editor.action.formatDocument<cr>", "format document"
    },
    ["<leader>u"] = {"<cmd>MundoToggle<tr>", "toggle Mundo"}
}

local function check_back_space()
    local col = vim.fn.col('.') - 1
    return (col < 1) or
               vim.api.nvim_get_current_line():sub(col, col):match("%s")
end

-- Tab and Shift-Tab
map("i", "<tab>", function()
    if pumvisible() then
        return vim.fn["coc#pum#next"](1)
    elseif check_back_space() then
        return "<tab>"
    else
        return vim.fn["coc#refresh"]()
    end
end, {expr = true, silent = true})
map("i", "<s-tab>", function()
    return pumvisible() and vim.fn["coc#pum#prev"](1) or "<c-h>"
end, {expr = true})

-- Pressing enter closes popupmenu if it is open, and inserts a line break.
-- Defer to vim-smartinput when the popupmenu is not visible.
map("i", "<cr>", function()
    return pumvisible() and vim.fn["coc#_select_confirm"]() or
               "<c-g>u<cr><c-r>=coc#on_enter()<cr>"
end, {expr = true, silent = true})

-- Use <c-space> for trigger completion
local refresh_shortcut = vim.fn.has("nvim") == 1 and "<c-space>" or "<c-@>"
map("i", refresh_shortcut, vim.fn["coc#refresh"], {expr = true, silent = true})

-- Scroll floating coc windows
local scroll = vim.fn["coc#float#scroll"]
local function iscroll(dir) return "<c-r>=coc#float#scroll(" .. dir .. ")<cr>" end
local function handlePage(scrollImpl, dir, fallbackKey)
    return function()
        return vim.fn["coc#float#has_scroll"]() ~= 0 and scrollImpl(dir) or
                   fallbackKey
    end
end
map({"n", "v"}, "<PageDown>", handlePage(scroll, 1, "<c-f>"),
    {silent = true, nowait = true, expr = true})
map({"n", "v"}, "<PageUp>", handlePage(scroll, 0, "<c-b>"),
    {silent = true, nowait = true, expr = true})
map("i", "<PageDown>", handlePage(iscroll, 1, "<Right>"),
    {silent = true, nowait = true, expr = true})
map("i", "<PageUp>", handlePage(iscroll, 0, "<Left>"),
    {silent = true, nowait = true, expr = true})

-- snippets
vim.g.coc_snippet_next = "<c-j>"
vim.g.coc_snippet_prev = "<c-k>"
map("i", "<c-l>", "<plug>(coc-snippets-expand)", {remap = true})
map("v", "<c-j>", "<plug>(coc-snippets-select)", {remap = true})
map("i", "<c-j>", "<plug>(coc-snippets-expand-jump)", {remap = true})
wk.register(
    {["<leader>x"] = {"<plug>(coc-convert-snippet)", "convert snippet"}},
    {mode = "x", remap = true})

-- tpope/vim-fugitive
wk.register({
    name = "+git",
    s = {"<cmd>vert Git<CR>", "git status in vert split"},
    d = {"<cmd>Gvdiffsplit<CR>", "git diff in vert splits"},
    c = {"<cmd>Git commit<CR>", "git commit"},
    b = {"<cmd>Git blame<CR>", "git blame"},
    l = {"<cmd>GV<cr>", "log graph for branch"},
    L = {"<cmd>GV --all<cr>", "log graph for all branches"},
    e = {"<cmd>Gedit<space>", "open file from history, e.g. :Gedit HEAD^:%"},
    p = {"<cmd>Git push<CR>", "push"},
    w = {"<cmd>Gwrite<CR>", "write file and stage"},
    r = {
        "<cmd>GRename<space>",
        "rename file - enter path relative to current file"
    },
    R = {"<cmd>Gremove<CR>", "git rm"}
}, {prefix = "<leader>g"})

-- See gitsigns bindings in config/gitsigns.lua for:
-- - <leader>h
-- - <leader>tb, <leader>td
-- - ]c, [c
-- - ih

-- gh.nvim bindings
wk.register({
    name = "+Github",
    c = {
        name = "+Commits",
        c = {"<cmd>GHCloseCommit<cr>", "Close"},
        e = {"<cmd>GHExpandCommit<cr>", "Expand"},
        o = {"<cmd>GHOpenToCommit<cr>", "Open To"},
        p = {"<cmd>GHPopOutCommit<cr>", "Pop Out"},
        z = {"<cmd>GHCollapseCommit<cr>", "Collapse"}
    },
    i = {name = "+Issues", p = {"<cmd>GHPreviewIssue<cr>", "Preview"}},
    l = {name = "+Litee", t = {"<cmd>LTPanel<cr>", "Toggle Panel"}},
    r = {
        name = "+Review",
        b = {"<cmd>GHStartReview<cr>", "Begin"},
        c = {"<cmd>GHCloseReview<cr>", "Close"},
        d = {"<cmd>GHDeleteReview<cr>", "Delete"},
        e = {"<cmd>GHExpandReview<cr>", "Expand"},
        s = {"<cmd>GHSubmitReview<cr>", "Submit"},
        z = {"<cmd>GHCollapseReview<cr>", "Collapse"}
    },
    p = {
        name = "+Pull Request",
        c = {"<cmd>GHClosePR<cr>", "Close"},
        d = {"<cmd>GHPRDetails<cr>", "Details"},
        e = {"<cmd>GHExpandPR<cr>", "Expand"},
        o = {"<cmd>GHOpenPR<cr>", "Open"},
        p = {"<cmd>GHPopOutPR<cr>", "PopOut"},
        r = {"<cmd>GHRefreshPR<cr>", "Refresh"},
        t = {"<cmd>GHOpenToPR<cr>", "Open To"},
        z = {"<cmd>GHCollapsePR<cr>", "Collapse"}
    },
    t = {
        name = "+Threads",
        c = {"<cmd>GHCreateThread<cr>", "Create"},
        n = {"<cmd>GHNextThread<cr>", "Next"},
        t = {"<cmd>GHToggleThread<cr>", "Toggle"}
    }
}, {prefix = "<leader>gh"})

wk.register({
    name = "+math",
    a = {
        "<plug>(coc-calc-result-append)",
        "evaluate math expression on line, and append result"
    },
    r = {
        "<plug>(coc-calc-result-replace)",
        "evaluate math expression on line, and replace with result"
    }
}, {prefix = "<leader>m", remap = true})

-- Magic Registers
wk.register({
    d = {'"=strftime("%F")<cr>', "put current date in unnamed register"},
    p = {
        '"=expand("%:p:h")<cr>',
        "put directory of open file in unnamed register"
    }
}, {prefix = '<leader>"'})
