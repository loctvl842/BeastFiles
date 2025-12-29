local wezterm = require("wezterm")
local colorscheme = require("colorscheme")

return {
	-- Color scheme (set THEME in wezterm.lua)
	colors = colorscheme(THEME),

	-- Window geometry
	initial_cols = 120,
	initial_rows = 28,

	-- Window padding (matches Ghostty's window-padding-y = 0,0)
	window_padding = {
		left = 0,
		right = 0,
		top = 10,
		bottom = 0,
	},
	window_decorations = "RESIZE",

	-- Tab bar font customization
	window_frame = {
		font = wezterm.font({ family = "JetbrainsMono Nerd Font", weight = "Bold" }),
		font_size = 12.0, -- Slightly smaller than terminal font (12)
	},

	-- scrollbar
	enable_scroll_bar = true,

	-- Tab bar (set USE_FANCY_TAB_BAR in wezterm.lua)
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = false,
	use_fancy_tab_bar = USE_FANCY_TAB_BAR,
	tab_max_width = 30,
	show_tab_index_in_tab_bar = false,
	switch_to_last_active_tab_when_closing_tab = true,

	-- Performance
	max_fps = 120,
	animation_fps = 120,
	front_end = "WebGpu", ---@type 'WebGpu' | 'OpenGL' | 'Software'

	-- Smooth cursor animations
	cursor_blink_ease_in = "EaseIn",
	cursor_blink_ease_out = "EaseOut",
	cursor_blink_rate = 700,

	-- Inactive pane appearance
	inactive_pane_hsb = {
		saturation = 1.0,
		brightness = 1.0,
	},
}
