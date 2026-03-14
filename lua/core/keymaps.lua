local map = vim.keymap.set
local opts = { noremap = true, silent = true }
vim.g.mapleader = " "
-- telescope controls
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Grep text" })
map("n", "<leader>gs", "<cmd>LazyGit<cr>", { desc = "Git" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })

-- Neotree controls
map("n", "<leader>ee", "<cmd>Neotree toggle<cr>", { desc = "Toggle Explorer" })
map("n", "<leader>er", "<cmd>Neotree toggle current reveal_force_cwd<cr>", { desc = "Replace Current With Toggle Explorer" })
map("n", "<leader>eb", ":Neotree toggle buffers right<cr>", { desc = "Toggle Open Buffer View" })
map("n", "<leader>eg", ":Neotree float git_status<cr>", { desc = "Toggle GitStatus" })

-- Tab controls
map('n', '<leader>tn', ':tabnew<CR>', opts)   -- new tab
map('n', '<leader>tc', ':tabclose<CR>', opts) -- close tab
map('n', '<leader>to', ':tabonly<CR>', opts)  -- close others
map('n', '<leader>tl', 'gt', opts)            -- next tab
map('n', '<leader>th', 'gT', opts)            -- prev tab
map('n', '<leader>ts', ':tab split<CR>', opts)-- split current buffer into new tab

-- extras
map('n', '<leader>mr', ':%s/\r//g<CR>', { desc = "remove ^M chars" })
map("n", "<leader>mt", ":TagbarToggle<CR>", { desc = "Toggle Tagbar" })
map("n", "<leader>ma", "<cmd>AerialToggle!<cr>", { desc = "Outline (Aerial)" })
map("n", "<leader>mf", "<cmd>lua require('conform').format({ lsp_fallback = true })<cr>", { desc = "Format file" })

-- remove search highlight
map('n', '<Esc>', ':noh<CR>', { silent = true, desc = "disable search highlight" })

-- trouble keys 
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics" })
map("n", "<leader>xw", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics" })

-- git diff view
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diffview Open" })
map("n", "<leader>gD", "<cmd>DiffviewClose<cr>", { desc = "Diffview Close" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "File History" })
