require("config.lazy")

require("config.keymaps")

require("config.terminal")

vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.g.copilot_node_command = "/usr/bin/node"

vim.opt.clipboard = "unnamedplus"

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch", -- The color style used for the flash
			timeout = 200, -- How long the flash lasts (in milliseconds)
		})
	end,
})
