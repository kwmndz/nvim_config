return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "python", "lua", "html", "json", "yaml", "rust", "toml", "c", "markdown", "markdown_inline" },
      highlight = { enable = true },
      indent = {
        enable = true,
        disable = { "c", "cpp" }, -- cindent handles C better than treesitter
      },
    })
  end,
}
