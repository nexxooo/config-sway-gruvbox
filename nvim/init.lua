vim.g.mapleader = " " 
vim.o.number = true 

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


local opts = {} 

require("lazy").setup("plugins")
vim.opt.scrolloff = 18

vim.keymap.set('n','<leader>bv',':vs<CR>',{desc ="buffer verticale"})
vim.keymap.set('n','<leader>bh',':sp<CR>',{desc ="buffer horizontale"})
vim.keymap.set('n','<leader>bt',':term<CR>',{desc ="terminale"})

vim.cmd([[
  autocmd TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>
]])


vim.opt.clipboard = "unnamedplus"
