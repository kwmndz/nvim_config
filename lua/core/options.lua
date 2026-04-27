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

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.opt_local.cindent = true
    vim.opt_local.autoindent = true
    vim.opt_local.smartindent = false
    vim.opt_local.cinoptions = "l1,(0,W4,m1,j1"
  end,
})
