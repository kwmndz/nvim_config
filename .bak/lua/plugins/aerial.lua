return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = { "AerialToggle", "AerialOpen" },
  config = function()
    require("aerial").setup({
      backends = { "lsp", "treesitter", "markdown" },
      layout = { min_width = 28 },
    })
  end,
}

