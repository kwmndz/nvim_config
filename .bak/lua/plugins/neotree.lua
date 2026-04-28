return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  -- set lazy to false so it can intercept the directory on startup
  lazy = false, 
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      filesystem = {
        -- Change: This tells Neo-tree to take over when you open a directory
        hijack_netrw_behavior = "open_default", 
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    })
  end,
}
