local M = setmetatable({}, {
  __call = function(t, ...)
    return t.get(...)
  end,
})

--- Available filters
---@alias Filter
---| '"classic"'
---| '"octagon"'
---| '"pro"'
---| '"machine"'
---| '"ristretto"'
---| '"spectrum"'

---@param filter Filter
function M.get(filter)
	local palette = require("colorscheme.palette." .. filter)

	return {
		-- The default text color
		foreground = palette.text,
		-- The default background color
		background = palette.background,

		-- Overrides the cell background color when the current cell is occupied by the cursor
		cursor_bg = palette.text,
		-- Overrides the text color when the current cell is occupied by the cursor
		cursor_fg = palette.background,
		-- Specifies the border color of the cursor when the cursor style is set to Block
		cursor_border = palette.text,

		-- The foreground color of selected text
		-- selection_fg = palette.background,
		-- The background color of selected text
		selection_bg = palette.dimmed3,

		-- The color of the scrollbar "thumb"; the portion that represents the current viewport
		scrollbar_thumb = palette.dimmed4,

		-- The color of the split lines between panes
		split = palette.dimmed2,

		-- ANSI color palette
		ansi = {
			palette.dark1, -- black
			palette.accent1, -- red
			palette.accent4, -- green
			palette.accent3, -- yellow
			palette.accent2, -- blue
			palette.accent6, -- magenta
			palette.accent5, -- cyan
			palette.text, -- white
		},

		-- Bright ANSI colors
		brights = {
			palette.dimmed5, -- bright black
			palette.accent1, -- bright red
			palette.accent4, -- bright green
			palette.accent3, -- bright yellow
			palette.accent2, -- bright blue
			palette.accent6, -- bright magenta
			palette.accent5, -- bright cyan
			palette.text, -- bright white
		},

		-- Tab bar colors
		tab_bar = {
			background = palette.dark2,
			active_tab = {
				bg_color = palette.background,
				fg_color = palette.text,
			},
			inactive_tab = {
				bg_color = palette.dark1,
				fg_color = palette.dimmed2,
			},
			inactive_tab_hover = {
				bg_color = palette.dimmed5,
				fg_color = palette.text,
			},
			new_tab = {
				bg_color = palette.dark1,
				fg_color = palette.dimmed2,
			},
			new_tab_hover = {
				bg_color = palette.dimmed5,
				fg_color = palette.text,
			},
		},
	}

end

return M
