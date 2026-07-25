return {
	"zaldih/themery.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("themery").setup({
			themes = { "tokyonight-night", "cyberdream", "gruvbox", "tokyodark" },
			livePreview = true,
		})
	end,
}
