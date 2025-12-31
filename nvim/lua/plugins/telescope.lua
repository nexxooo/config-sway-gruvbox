return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set('n', '<leader>tf', builtin.find_files, {desc ="find file"})
			vim.keymap.set('n', '<leader>tg', builtin.live_grep, {desc = "grep"})
			vim.keymap.set('n', '<leader>tb', '<cmd>Telescope buffers<CR>',{desc ="buffer"})
		end
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extension = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown {}

					}

				}
			})
			require("telescope").load_extension("ui-select")
		end
	},

}
