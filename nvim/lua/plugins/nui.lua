-- lua/plugins/nui-popup.lua
return {
	"MunifTanjim/nui.nvim",
	lazy = true,
	keys = {
		{
			"<leader>mp", -- 👈 change this to whatever key you want to trigger it
			function()
				require("config.text-popup").toggle()
			end,
			desc = "Toggle Info Popup",
		},
	},
}
