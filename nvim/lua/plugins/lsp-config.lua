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
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          -- ACTIVER L'AUTOCOMPLÉTION NATIVE (Remplace nvim-cmp)
          if client.supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, args.buf)
          end

          -- ACTIVER L'INLAY HINTS (Indices de types/paramètres)
          if client.supports_method('textDocument/inlayHint') then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
          end

          -- Raccourcis clavier LSP
          local opts = { buffer = args.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K",  vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        end,
      })

      -- 2. Liaison entre Mason et vos fichiers dans lua/lsp/
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "clangd", "pyright" }, -- Vos serveurs
        handlers = {
          function(server_name)
            -- On cherche si un fichier spécifique existe dans lua/lsp/server_name.lua
            local has_custom_config, custom_config = pcall(require, "lsp." .. server_name)
            
            local config = {}
            if has_custom_config then
              config = custom_config
            end

            -- IMPORTANT : Dans Neovim 0.11+, plus besoin de passer "capabilities" 
            -- manuellement si vous utilisez l'autocomplétion native.
            lspconfig[server_name].setup(config)
          end,
        },
      })
    end,
  },
}
