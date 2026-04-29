return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		{
			"windwp/nvim-ts-autotag",
			opts = {},
			ft = {
				"javascriptreact",
				"typescriptreact",
				"javascript",
				"typescript",
				"html",
				"vue",
				"php",
			},
		},
	},
	config = function()
		-- fix: nvim 0.12 changed match API to return node arrays per capture,
		-- but nvim-treesitter's set-lang-from-info-string! predicate expects
		-- a single TSNode, causing a crash in hover/markdown injection queries
		vim.treesitter.query.add_directive(
			"set-lang-from-info-string!",
			function(match, _, bufnr, pred, metadata)
				local capture_id = pred[2]
				local node = match[capture_id]
				if type(node) == "table" then
					node = node[1]
				end
				if not node then
					return
				end
				local ok, text = pcall(vim.treesitter.get_node_text, node, bufnr)
				if ok and text then
					metadata["injection.language"] = text:lower()
				end
			end,
			{ force = true }
		)

		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"json",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"prisma",
				"markdown",
				"markdown_inline",
				"svelte",
				"graphql",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"query",
				"vimdoc",
				"c",
				"cpp",
				"python",
				"rust",
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}
