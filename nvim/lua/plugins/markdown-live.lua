return{
    'MeanderingProgrammer/render-markdown.nvim',
    --dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
     dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {on = {
            attach = function()
                -- Change "@markup.strong" pour la couleur du gras (ex: Orange)
                vim.api.nvim_set_hl(0, "@markup.strong", { fg = "#ffd000", bold = true })
                -- Optionnel : Couleur pour les formules LaTeX
            end,
        },},
}
