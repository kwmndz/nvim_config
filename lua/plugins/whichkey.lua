return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")

    wk.setup({
      preset = "modern",
      icons = {
        icons = true,
      },
    })

    wk.add({
      { "<leader>e", group = "Neo-tree" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>t", group = "Tabs" },
      { "<leader>m", group = "Extras" },
    })
  end,
}

