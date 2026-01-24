return {
	"stevearc/conform.nvim",
	opts={},
	config = function()
		require("conform").setup({
			formatters_by_ft={
				lua={"stylua"},
				csharp={"csharpier"}
		}})

	end,
}


