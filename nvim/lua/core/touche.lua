local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>tf", builtin.find_files, { desc = "find file" })
vim.keymap.set("n", "<leader>tg", builtin.live_grep, { desc = "grep" })
vim.keymap.set("n", "<leader>tb", "<cmd>Telescope buffers<CR>", { desc = "buffer" })

-- Navigation entre fenêtres
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)

-- Redimensionner
vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)

--fichier--
vim.keymap.set("n", "<leader>e", ":Neotree filesystem reveal left<CR>", { desc = "search" })

--formatage--
vim.keymap.set("n", "<leader>f", function()
  require("conform").format({ lsp_fallback = true })
end, { desc = "Formatage du fichier" })
