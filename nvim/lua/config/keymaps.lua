local map = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

map("n", "<leader>w", ":w<CR>", opts) -- Save
map("n", "<leader>q", ":q<CR>", opts) -- Quit

map("n", "<leader>th", ":Themery<CR>")

-- Pane navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Telescope keymaps
local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
map("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
map("n", "<leader>fc", builtin.current_buffer_fuzzy_find, { desc = "Telescope current file" })

--File navigation
map("n", "<Tab>", ":bnext<CR>", opts, { desc = "Next buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", opts, { desc = "Previous buffer" })
map("n", "<leader>bd", ":bdelete<CR>", opts, { desc = "Delete buffer" })

map("n", "<leader>x", ":source $MYVIMRC<CR>", { desc = "Reload Neovim config" })

map("n", "[d", builtin.diagnostics, { desc = "Diagnostic" })

-- mini
