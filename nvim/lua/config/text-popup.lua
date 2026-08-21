-- lua/config/text-popup.lua
local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event

---------------------------------------------------------------------
-- 👇 Put whatever text you want displayed here, one string per line
---------------------------------------------------------------------
local content = {
	"gcc to comment a line",
	"gcap to comment a paragraph",
	"alt + hjkl to move lines/selection up and down",
}
-- Auto-size the box to fit the longest line + padding
local width = 0
for _, line in ipairs(content) do
	width = math.max(width, vim.fn.strdisplaywidth(line))
end
width = width + 4
local height = #content + 2

local popup = Popup({
	enter = true,
	focusable = true,
	relative = "editor",
	anchor = "SE", -- anchor point is the popup's South-East (bottom-right) corner
	border = {
		style = "rounded",
		text = {
			top = " Info ",
			top_align = "center",
		},
		padding = { 0, 1 },
	},
	position = {
		row = vim.o.lines - vim.o.cmdheight - 2, -- 2 lines up from the bottom
		col = vim.o.columns - 2, -- 2 columns in from the right edge
	},
	size = {
		width = width,
		height = height,
	},
	win_options = {
		winblend = 0,
		winhighlight = "Normal:NuiPopupNormal,FloatBorder:NuiPopupBorder",
	},
	buf_options = {
		modifiable = false,
		readonly = true,
	},
})

local is_open = false

local function open()
	popup:mount()
	vim.api.nvim_buf_set_option(popup.bufnr, "modifiable", true)
	vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, content)
	vim.api.nvim_buf_set_option(popup.bufnr, "modifiable", false)
	is_open = true

	-- Close on leaving the buffer, or with q / <Esc>
	popup:on(event.BufLeave, function()
		popup:unmount()
		is_open = false
	end)

	popup:map("n", "q", function()
		popup:unmount()
		is_open = false
	end, { noremap = true })

	popup:map("n", "<Esc>", function()
		popup:unmount()
		is_open = false
	end, { noremap = true })
end

local function close()
	popup:unmount()
	is_open = false
end

local M = {}

function M.toggle()
	if is_open then
		close()
	else
		open()
	end
end

return M
