-- lua/plugins/blink.lua
return {
	"saghen/blink.cmp",
	version = "1.*", -- stable release line — main/v2 has active breaking changes
	dependencies = {
		"rafamadriz/friendly-snippets", -- snippet collection for many languages
	},
	event = "InsertEnter",

	---@module "blink.cmp"
	---@type blink.cmp.Config
	opts = {
		keymap = { preset = "enter" }, -- Tab to select+accept, arrows to navigate

		snippets = { preset = "default" },

		-----------------------------------------------------------------
		-- Appearance
		-----------------------------------------------------------------
		appearance = {
			-- 'mono' keeps icon widths aligned; use 'normal' if your font
			-- isn't a Nerd Font Mono variant
			nerd_font_variant = "mono",

			kind_icons = {
				Text = "󰉿",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "",
				Field = "󰜢",
				Variable = "󰀫",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "󰜢",
				Unit = "󰑭",
				Value = "󰎠",
				Enum = "",
				Keyword = "󰌋",
				Snippet = "",
				Color = "󰏘",
				File = "󰈙",
				Reference = "󰈇",
				Folder = "󰉋",
				EnumMember = "",
				Constant = "󰏿",
				Struct = "󰙅",
				Event = "",
				Operator = "󰆕",
				TypeParameter = "󰊄",
			},
		},

		-----------------------------------------------------------------
		-- Completion menu, docs window, ghost text
		-----------------------------------------------------------------
		completion = {
			accept = {
				auto_brackets = { enabled = true },
			},

			list = {
				selection = { preselect = true, auto_insert = false },
			},

			menu = {
				border = "rounded",
				winblend = 0,
				winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
				scrollbar = true,

				draw = {
					padding = { 1, 1 },
					gap = 2,
					treesitter = { "lsp" }, -- treesitter-highlight the entries themselves
					columns = {
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "kind" },
					},
					components = {
						kind_icon = {
							text = function(ctx)
								return " " .. ctx.kind_icon .. " "
							end,
							highlight = "BlinkCmpKind",
						},
						label = {
							width = { fill = true, max = 40 },
							text = function(ctx)
								return ctx.label
							end,
							highlight = "BlinkCmpLabel",
						},
						label_description = {
							width = { max = 30 },
							text = function(ctx)
								return ctx.label_description
							end,
							highlight = "BlinkCmpLabelDescription",
						},
						kind = {
							text = function(ctx)
								return ctx.kind
							end,
							highlight = "BlinkCmpKind",
						},
					},
				},
			},

			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = {
					border = "rounded",
					winblend = 0,
					winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder",
				},
			},

			ghost_text = {
				enabled = true,
			},
		},

		-----------------------------------------------------------------
		-- Signature help (function param hints while typing)
		-----------------------------------------------------------------
		signature = {
			enabled = true,
			window = {
				border = "rounded",
			},
		},

		-----------------------------------------------------------------
		-- Sources
		-----------------------------------------------------------------
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		-----------------------------------------------------------------
		-- Cmdline completion (: and / search)
		-----------------------------------------------------------------
		cmdline = {
			enabled = true,
		},

		-- Rust fuzzy matcher; falls back to Lua automatically if the
		-- prebuilt binary can't be downloaded/compiled
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
