return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- capabilities from cmp
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Python LSP (basedpyright)
    vim.lsp.config.pyright = {
      cmd = { "basedpyright-langserver", "--stdio" },
      capabilities = capabilities,
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic",
          },
        },
      },
    }

    -- Rust LSP (rust-analyzer)
    vim.lsp.config.rust_analyzer = {
      cmd = { "rust-analyzer" },
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          cargo = { allFeatures = true },
          check = { command = "clippy" },
        },
      },
    }

    -- enable servers
    vim.lsp.enable({ "pyright", "rust_analyzer" })
  end,
}

