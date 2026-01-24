return {
  -- Mason : Gestionnaire de serveurs LSP, formateurs et linters
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  -- Mason LSPConfig : Assure l'installation des serveurs
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        -- Liste de vos serveurs basés sur votre config actuelle
        ensure_installed = { 
          "lua_ls", 
          "clangd", 
          "html", 
          "cssls", 
          "omnisharp", 
          "bashls", 
          "pyright" 
        },
      })
    end,
  },
  -- Nvim LSPConfig : Configuration des serveurs
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- Pour l'autocomplétion
    },
     config = function()
      local lspconfig = require("lspconfig")
      -- Récupération des capacités d'autocomplétion pour les envoyer aux serveurs
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Liste des serveurs à configurer avec les mêmes paramètres
      local servers = { 
        "lua_ls", "clangd", "html", "cssls", 
        "omnisharp", "bashls", "pyright" 
      }

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
        })
      end

      -- Mappages clavier globaux pour le LSP
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Afficher la documentation" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Aller à la définition" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Actions de code" })
      vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Afficher le diagnostic" })
      
      -- Mappage pour le renommage (souvent utile)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Renommer le symbole" })
    end,
  },
}
