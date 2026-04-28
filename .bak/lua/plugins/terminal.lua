return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<leader>tf", desc = "Open floating terminal" },
  },
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<c-\>]], -- Ctrl + \
      shade_terminals = true,
      direction = "horizontal", -- 'horizontal' | 'vertical' | 'float'
      start_in_insert = true,
      persist_size = true,
    })

    -- Floating terminal keymap
    vim.keymap.set("n", "<leader>tf", function()
      require("toggleterm.terminal")
        .Terminal
        :new({ direction = "float" })
        :toggle()
    end, { desc = "Open floating terminal" })
  end,
}

