return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			local lspconfig = require("lspconfig")

			-- 1. Configuration des comportements natifs (Nouveauté 0.11+)
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then
						return
					end

					-- ACTIVER L'AUTOCOMPLÉTION NATIVE
					if client.supports_method("textDocument/completion") then
						vim.lsp.completion.enable(true, client.id, args.buf)
					end

					-- ACTIVER L'INLAY HINTS
					if client.supports_method("textDocument/inlayHint") then
						vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
					end

					-- Raccourcis clavier LSP
					local opts = { buffer = args.buf }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				end,
			})

			-- 2. Liaison entre Mason et vos fichiers
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "clangd", "pyright", "jdtls" }, -- Ajout de jdtls ici pour s'assurer qu'il est installé
				handlers = {
					function(server_name)
						local has_custom_config, custom_config = pcall(require, "lsp." .. server_name)
						local config = {}
						if has_custom_config then
							config = custom_config
						end
						lspconfig[server_name].setup(config)
					end,

					["jdtls"] = function()
						lspconfig["jdtls"].setup({
							-- SUPPRIMÉ: on_attach et capabilities (inutiles en 0.11+ et causaient une erreur)

							-- AJOUT CRUCIAL: Comment trouver la racine du projet (pour régler ton problème de "non-project file")
							root_dir = lspconfig.util.root_pattern(".git", "pom.xml", "build.gradle"),

							settings = {
								java = {
									project = {
										sourcePaths = {
											"src/main/java",
											"src",
											"code/src",
										},
									},
								},
							},
						})
					end,
				},
			})
		end,
	},
}
