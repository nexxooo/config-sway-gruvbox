local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

-- Configuration du serveur
local config = {
  cmd = {
    "jdtls", -- Mason installe l'exécutable dans votre PATH
    "-data", workspace_dir,
  },
  root_dir = require("jdtls.setup").find_root({".git", "mvnw", "gradlew", "pom.xml", "build.gradle"}),
  
  -- Ici, vous pouvez copier les capacités d'autocomplétion de votre config actuelle
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
}

-- Lancement de jdtls
require("jdtls").start_or_attach(config)
