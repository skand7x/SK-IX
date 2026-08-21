-- lua/plugins/bufferline.lua
return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	opts = {
		options = {
			mode = "buffers",
			themable = true,
			numbers = "none",
			close_command = "bdelete! %d",
			right_mouse_command = "bdelete! %d",
			left_mouse_command = "buffer %d",
			indicator = {
				icon = "▎",
				style = "icon",
			},
			buffer_close_icon = "󰅖",
			modified_icon = "●",
			close_icon = "",
			left_trunc_marker = "",
			right_trunc_marker = "",
			max_name_length = 18,
			max_prefix_length = 15,
			truncate_names = true,
			tab_size = 18,
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level)
				local icon = level:match("error") and " " or " "
				return " " .. icon .. count
			end,
			color_icons = true,
			show_buffer_icons = true,
			show_buffer_close_icons = true,
			show_close_icon = false,
			show_tab_indicators = true,
			show_duplicate_prefix = true,
			persist_buffer_sort = true,
			move_wraps_at_ends = false,
			separator_style = "thin", -- try "slant" for a sharper look
			enforce_regular_tabs = false,
			always_show_bufferline = true,
			hover = {
				enabled = true,
				delay = 150,
				reveal = { "close" },
			},
			sort_by = "insert_after_current",

			-- 👇 This is the important bit for snacks.nvim explorer
			offsets = {
				{
					filetype = "snacks_layout_box",
					text = "Explorer",
					text_align = "center",
					separator = true,
				},
			},
		},

		highlights = {
			fill = { bg = { attribute = "bg", highlight = "Normal" } },
			background = { bg = { attribute = "bg", highlight = "Normal" } },

			buffer_selected = {
				fg = { attribute = "fg", highlight = "Normal" },
				bold = true,
				italic = false,
			},
			buffer_visible = {
				fg = { attribute = "fg", highlight = "Comment" },
			},

			separator = {
				fg = { attribute = "bg", highlight = "Normal" },
				bg = { attribute = "bg", highlight = "Normal" },
			},
			separator_selected = {
				fg = { attribute = "bg", highlight = "Normal" },
				bg = { attribute = "bg", highlight = "Normal" },
			},

			indicator_selected = {
				fg = { attribute = "fg", highlight = "Function" },
				bg = { attribute = "bg", highlight = "Normal" },
			},

			modified = {
				fg = { attribute = "fg", highlight = "String" },
			},
			modified_selected = {
				fg = { attribute = "fg", highlight = "String" },
				bg = { attribute = "bg", highlight = "Normal" },
			},

			duplicate_selected = {
				fg = { attribute = "fg", highlight = "Comment" },
				italic = true,
			},
			duplicate = {
				fg = { attribute = "fg", highlight = "Comment" },
				italic = true,
			},

			diagnostic_selected = {
				fg = { attribute = "fg", highlight = "Normal" },
				bg = { attribute = "bg", highlight = "Normal" },
			},
			error_diagnostic_selected = {
				fg = { attribute = "fg", highlight = "DiagnosticError" },
				bg = { attribute = "bg", highlight = "Normal" },
			},
			warning_diagnostic_selected = {
				fg = { attribute = "fg", highlight = "DiagnosticWarn" },
				bg = { attribute = "bg", highlight = "Normal" },
			},
		},
	},
}
