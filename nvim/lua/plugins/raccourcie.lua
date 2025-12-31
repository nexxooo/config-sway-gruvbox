return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300 -- Délai avant l'apparition (300ms)
  end,
  opts = {
    -- Tu peux laisser vide pour les réglages par défaut
    preset = "helix", -- ou "helix" / "modern"
	spec = {
			{"<leader>b" , group = "buffer"},
			{"<leader>m" , group = "Markdown", icon =" "},
			{"<leader>c" , group = "code", icon = " "},
			{"<leader>t" , group = "telescope"},
		}
  },
}
