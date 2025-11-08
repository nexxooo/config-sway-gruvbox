return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylelua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.csharpier,
				null_ls.builtins.diagnostics.eslint_d,
				null_ls.builtins.diagnostics.stylelint,
				null_ls.builtins.diagnostics.shellcheck,
				null_ls.builtins.formatting.shfmt.with({ filetypes = { "sh", "bash", "zsh" } }),
			},
		})
		vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {})
	end,
}
