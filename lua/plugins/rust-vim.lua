return {
  "rust-lang/rust.vim",
  ft = { "rust" }, -- load only for Rust files
  init = function()
    -- optional: autoformat on save using :RustFmt
    -- vim.g.rustfmt_autosave = 1
  end,
}
