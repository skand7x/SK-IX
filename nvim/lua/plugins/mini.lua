return {
	"nvim-mini/mini.nvim",
	version = "*",
	config = function()
		require("mini.comment").setup()
		require("mini.pairs").setup()
		require("mini.surround").setup()
		require("mini.ai").setup()
		require("mini.move").setup()
		require("mini.operators").setup()
		require("mini.comment").setup()
		require("mini.animate").setup()
		require("mini.cursorword").setup()
		require("mini.sessions").setup()
	end,
}
