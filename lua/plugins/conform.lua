return {
  "stevearc/conform.nvim",
  cmd = { "ConformInfo" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format" }, -- or "black"
        rust = { "rustfmt" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        vue = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
      },
      -- don't auto-format yet; we’ll add it if you like it
    })
  end,
}

