-- lua/plugins/lsp.lua
return {
	-----------------------------------------------------------------------
	-- Mason: installs and manages LSP servers, linters, formatters
	-----------------------------------------------------------------------
	{
		"mason-org/mason.nvim",
		build = ":MasonUpdate",
		opts = {
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},

	-----------------------------------------------------------------------
	-- Bridges Mason-installed servers to lspconfig automatically
	-----------------------------------------------------------------------
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"pyright",
				"ts_ls",
				"html",
				"cssls",
				"jsonls",
				"bashls",
			},
			automatic_installation = true,
		},
	},

	-----------------------------------------------------------------------
	-- The actual LSP client configuration
	-----------------------------------------------------------------------
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"saghen/blink.cmp", -- provides completion capabilities
			{ "j-hui/fidget.nvim", opts = {} }, -- LSP progress spinner in corner
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Diagnostics look and feel
			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
					current_line = true, -- only show virtual text on the current line
				},
				severity_sort = true,
				float = { border = "rounded" },
				signs = true,
				underline = false,
			})

			-- Keymaps that apply only in buffers with an active LSP client
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gd", vim.lsp.buf.definition, "Goto Definition")
					map("gr", vim.lsp.buf.references, "Goto References")
					map("gI", vim.lsp.buf.implementation, "Goto Implementation")
					map("gD", vim.lsp.buf.declaration, "Goto Declaration")
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("<leader>rn", vim.lsp.buf.rename, "Rename")
					map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
					map("<leader>D", vim.lsp.buf.type_definition, "Type Definition")
					map("<leader>d", vim.diagnostic.open_float, "Show Diagnostic")

					-- Highlight references of the symbol under the cursor
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client:supports_method("textDocument/documentHighlight") then
						local hl_group = vim.api.nvim_create_augroup("UserLspHighlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = hl_group,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = hl_group,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})

			-----------------------------------------------------------------
			-- Per-server configuration, applied via vim.lsp.config()
			-- (extends the base config each server ships under lsp/*.lua)
			-----------------------------------------------------------------
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			})

			-- pyright, ts_ls, html, cssls, jsonls, bashls all work fine with
			-- their shipped defaults, so no extra vim.lsp.config() calls
			-- needed — mason-lspconfig's automatic_enable already turns them
			-- on for their respective filetypes.
		end,
	},
}
