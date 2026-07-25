return {
	"nvim-mini/mini.nvim",
	version = "*",
	lazy = false,
	config = function()
		require("mini.pairs").setup()
		require("mini.move").setup()
		require("mini.cursorword").setup()
		require("mini.statusline").setup()
		require("mini.surround").setup()
	end,
}
