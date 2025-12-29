local wezterm = require("wezterm")

return {
	font = wezterm.font("JetbrainsMono Nerd Font"),
	font_size = 12,
	-- Adjust line height (1.0 = normal, 1.2 = 20% taller, etc.)
	line_height = 1.25,
	cell_width = 1.0,
	-- Adjust underline position (negative moves down, positive moves up)
	underline_position = "+250%",
}
