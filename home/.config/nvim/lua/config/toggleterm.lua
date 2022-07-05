require("toggleterm").setup {
    size = function(term)
        if term.direction == "horizontal" then
            return 15
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
        end
    end,
    persist_size = false,
    open_mapping = [[<c-\>]],
    direction = "vertical",
    shade_terminals = false,
}
