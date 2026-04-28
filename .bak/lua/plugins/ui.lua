return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = false,
        styles = { comments = { italic = true } },
      })
      vim.cmd("colorscheme tokyonight")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "tokyonight", icons_enabled = true },
        tabline = {
          lualine_a = {
            {
              "tabs",
              mode = 2, -- 0 = tab number, 1 = name, 2 = both
              max_length = vim.o.columns / 3,
              tabs_color = {
                active = "lualine_a_normal",
                inactive = "lualine_b_inactive",
              },
              fmt = function(name, _context)
                local short_name = vim.fn.fnamemodify(name, ":~:.")
                if #short_name > 40 then
                  short_name = vim.fn.pathshorten(short_name)
                end
                return string.format("%s", short_name)
              end,
            },
          },
        },
      })
    end,
  },

  { "nvim-tree/nvim-web-devicons" },

  {
    "echasnovski/mini.icons",
    config = function()
      require("mini.icons").setup()
    end,
  },
}
