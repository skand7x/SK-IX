-- lua/plugins/lazydev.lua
return {
	"folke/lazydev.nvim",
	ft = "lua", -- only loads for Lua files, keeps startup fast
	opts = {
		library = {
			-- Load luv types when `vim.uv` is used
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },

			-- Uncomment and adjust if you use other plugin APIs from your
			-- config and want completion/hover for them too, e.g.:
			-- { path = "lazy.nvim", words = { "LazyVim" } },
		},
	},
}
