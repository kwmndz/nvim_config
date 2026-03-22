local o = vim.opt
-- Disable netrw (so Neo-tree can handle directories)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


o.number = true
o.relativenumber = true
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.smartindent = true
o.termguicolors = true
o.cursorline = true
o.signcolumn = "yes"
o.clipboard = "unnamedplus"
o.splitbelow = true
o.splitright = true
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldenable = true  -- open files with folds active
o.foldlevel = 99
o.fillchars:append({ fold = " " })
o.foldcolumn = "1"
o.foldlevelstart = 99
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

vim.cmd.colorscheme("wallbash")
