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

    -- TOML LSP (taplo)
    vim.lsp.config.taplo = {
      cmd = { "taplo", "lsp", "stdio" },
      filetypes = { "toml" },
      capabilities = capabilities,
      settings = {
        taplo = {
          schema = {
            enabled = true,
            catalogs = {
              "https://www.schemastore.org/api/json/catalog.json",
            },
          },
        },
      },
    }

    -- C/C++ LSP (clangd)
    vim.lsp.config.clangd = {
        cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--completion-style=detailed",
            "--header-insertion=iwyu",
        },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        capabilities = capabilities,
    }

    -- enable servers
    vim.lsp.enable({ "pyright", "rust_analyzer", "taplo", "clangd"})
  end,
}

