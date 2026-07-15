-- THEME and USE_FANCY_TAB_BAR are globals set in wezterm.lua before this module
-- is loaded. lua-ls can't see cross-file globals without a workspace declaration,
-- so suppress the resulting warnings at file scope.
---@diagnostic disable: undefined-global

local wezterm = require("wezterm")
local colorscheme = require("colorscheme")

local theme = THEME or "monokai-pro"
local palette = require("colorscheme.palette." .. theme)

-- Export every palette field as WEZTERM_PALETTE_* so any shell tool can use
-- exact hex values without needing to know the theme name or maintain its own
-- per-theme case statements. When a palette deviates from the monokai convention
-- (accent4=green, accent3=yellow, accent1=red), it can define vcs_clean /
-- vcs_modified / vcs_conflict fields to override the semantic VCS defaults.
local env_vars = {
	WEZTERM_PALETTE_BG = palette.background,
	WEZTERM_PALETTE_DARK1 = palette.dark1,
	WEZTERM_PALETTE_DARK2 = palette.dark2,
	WEZTERM_PALETTE_TEXT = palette.text,
	WEZTERM_PALETTE_ACCENT1 = palette.accent1,
	WEZTERM_PALETTE_ACCENT2 = palette.accent2,
	WEZTERM_PALETTE_ACCENT3 = palette.accent3,
	WEZTERM_PALETTE_ACCENT4 = palette.accent4,
	WEZTERM_PALETTE_ACCENT5 = palette.accent5,
	WEZTERM_PALETTE_ACCENT6 = palette.accent6,
	WEZTERM_PALETTE_DIMMED1 = palette.dimmed1,
	WEZTERM_PALETTE_DIMMED2 = palette.dimmed2,
	WEZTERM_PALETTE_DIMMED3 = palette.dimmed3,
	WEZTERM_PALETTE_DIMMED4 = palette.dimmed4,
	WEZTERM_PALETTE_DIMMED5 = palette.dimmed5,
	-- Semantic git state colors. Palette files define vcs_* to override when
	-- the palette doesn't follow the monokai convention (accent4/3/1 = green/yellow/red).
	WEZTERM_VCS_CLEAN = palette.vcs_clean or palette.accent4,
	WEZTERM_VCS_MODIFIED = palette.vcs_modified or palette.accent3,
	WEZTERM_VCS_CONFLICT = palette.vcs_conflict or palette.accent1,
}

return {
	-- Color scheme (set THEME in wezterm.lua)
	colors = colorscheme(theme),

	set_environment_variables = env_vars,

	-- Window geometry
	initial_cols = 120,
	initial_rows = 28,

	-- Window padding (matches Ghostty's window-padding-y = 0,0)
	window_padding = {
		left = 5,
		right = 5,
		top = 5,
		bottom = 5,
	},
	window_decorations = "RESIZE",
	native_macos_fullscreen_mode = true,

	-- Tab bar font customization
	window_frame = {
		font = wezterm.font({ family = "JetbrainsMono Nerd Font", weight = "Bold" }),
		font_size = 12.0, -- Slightly smaller than terminal font (12)
		active_titlebar_bg = palette.dark2,
		inactive_titlebar_bg = palette.dark2,
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
	max_fps = 60,
	animation_fps = 60,
	front_end = "WebGpu", ---@type 'WebGpu' | 'OpenGL' | 'Software'
	webgpu_power_preference = "LowPower",

	-- Smooth cursor animations
	cursor_blink_ease_in = "EaseIn",
	cursor_blink_ease_out = "EaseOut",
	cursor_blink_rate = 0,

	-- Inactive pane appearance
	inactive_pane_hsb = {
		saturation = 1.0,
		brightness = 0.85,
	},
}
