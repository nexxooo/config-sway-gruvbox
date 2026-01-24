local home = os.getenv("HOME")
local mason_path = home .. "/.local/share/nvim/mason/packages/"

local bundles = {
  vim.fn.glob(mason_path .. "java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", 1),
}
-- Ajout des tests unitaires
vim.list_extend(bundles, vim.fn.split(vim.fn.glob(mason_path .. "java-test/extension/server/*.jar", 1), "\n"))

local config = {
  -- ... (garde ton cmd et ton root_dir actuels)
  init_options = {
    bundles = bundles
  },
  on_attach = function(client, bufnr)
    -- Initialise DAP pour Java
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
    
    -- Cette commande permet de détecter les classes "Main" automatiquement
    -- Elle doit être appelée APRÈS que le serveur LSP soit prêt
    require('jdtls.dap').setup_dap_main_class_configs()
    
    -- Optionnel : Ajouter des raccourcis spécifiques au buffer Java
    local opts = { silent = true, buffer = bufnr }
    vim.keymap.set('n', "<leader>df", require('jdtls').test_class, opts)
    vim.keymap.set('n', "<leader>dn", require('jdtls').test_nearest_method, opts)
  end,
}
require("jdtls").start_or_attach(config)
