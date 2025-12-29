local wezterm = require("wezterm")

local keys = {
	-- Shift Enter to insert newline
	{ key = "Enter", mods = "SHIFT", action = wezterm.action.SendString("\n") },

	-- Splitting panes
	{ key = "\\", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "/", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- Navigate between panes (vim-style)
	{ key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
	{
		key = "j",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, pane)
			local tab = window:active_tab()
			local panes = tab:panes_with_info()

			-- Check if current pane is zoomed
			local is_zoomed = false
			for _, p in ipairs(panes) do
				if p.pane:pane_id() == pane:pane_id() and p.is_zoomed then
					is_zoomed = true
					break
				end
			end

			-- Unzoom if currently zoomed
			if is_zoomed then
				window:perform_action(wezterm.action.TogglePaneZoomState, pane)
			end

			-- Try moving down and detect if we're at the bottom
			local current_pane_id = pane:pane_id()
			window:perform_action(wezterm.action.ActivatePaneDirection("Down"), pane)

			-- Check if we actually moved to a different pane
			local new_pane = window:active_tab():active_pane()
			if new_pane:pane_id() == current_pane_id then
				-- We didn't move, so we're at the bottom - wrap to top
				-- Move up until we reach the top
				for _ = 1, #panes do
					window:perform_action(wezterm.action.ActivatePaneDirection("Up"), pane)
				end
				-- Don't auto-zoom - let user see both panes
			end
		end),
	},
	{
		key = "k",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, pane)
			-- Navigate up
			window:perform_action(wezterm.action.ActivatePaneDirection("Up"), pane)
			-- Auto-zoom the main editor pane
			window:perform_action(wezterm.action.TogglePaneZoomState, pane)
		end),
	},
	{ key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },

	-- Toggle pane zoom
	{ key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },

	-- Search mode (case-insensitive)
	{ key = "f", mods = "LEADER", action = wezterm.action.Search({ CaseInSensitiveString = "" }) },

	-- Close current pane
	{ key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

	-- Create new tab
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},

	-- Navigate between tabs
	{
		key = "h",
		mods = "ALT|SHIFT",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "l",
		mods = "ALT|SHIFT",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{ key = "[", mods = "LEADER", action = wezterm.action.ActivateCopyMode },
}

local key_tables = {
	copy_mode = {
		-- quit
		{ key = "q", action = wezterm.action.CopyMode("Close") },
		{ key = "Escape", action = wezterm.action.CopyMode("Close") },

		-- movement (vim)
		{ key = "h", action = wezterm.action.CopyMode("MoveLeft") },
		{ key = "j", action = wezterm.action.CopyMode("MoveDown") },
		{ key = "k", action = wezterm.action.CopyMode("MoveUp") },
		{ key = "l", action = wezterm.action.CopyMode("MoveRight") },

		-- word-wise
		{ key = "w", action = wezterm.action.CopyMode("MoveForwardWord") },
		{ key = "b", action = wezterm.action.CopyMode("MoveBackwardWord") },
		{ key = "e", action = wezterm.action.CopyMode("MoveForwardWordEnd") },

		-- line-wise
		{ key = "0", action = wezterm.action.CopyMode("MoveToStartOfLine") },
		{ key = "$", action = wezterm.action.CopyMode("MoveToEndOfLineContent") },
		{ key = "g", action = wezterm.action.CopyMode("MoveToScrollbackTop") },
		{ key = "G", action = wezterm.action.CopyMode("MoveToScrollbackBottom") },

		-- start selection (vim-ish)
		{ key = "v", action = wezterm.action.CopyMode({ SetSelectionMode = "Cell" }) },
		{ key = "V", action = wezterm.action.CopyMode({ SetSelectionMode = "Line" }) },
		{ key = "\x16", action = wezterm.action.CopyMode({ SetSelectionMode = "Block" }) }, -- Ctrl+v

		-- clear selection
		{ key = "u", action = wezterm.action.CopyMode("ClearSelectionMode") },

		-- copy
		{
			key = "y",
			action = wezterm.action.Multiple({
				wezterm.action.CopyTo("ClipboardAndPrimarySelection"),
				wezterm.action.CopyMode("Close"),
			}),
		},

		-- scroll
		{ key = "u", mods = "CTRL", action = wezterm.action.CopyMode({ MoveByPage = -0.5 }) },
		{ key = "d", mods = "CTRL", action = wezterm.action.CopyMode({ MoveByPage = 0.5 }) },

		-- search
		{ key = "/", action = wezterm.action.Search({ CaseInSensitiveString = "" }) },
		{ key = "?", action = wezterm.action.Search({ CaseInSensitiveString = "" }) },
	},
	search_mode = {
		{ key = "Escape", action = wezterm.action.CopyMode("Close") },

		-- Commit pattern & navigate
		{ key = "Enter", action = wezterm.action.CopyMode("NextMatch") },
		{ key = "Enter", mods = "SHIFT", action = wezterm.action.CopyMode("PriorMatch") },

		-- Re-edit pattern
		{ key = "/", action = wezterm.action.CopyMode("EditPattern") },

		-- Clear pattern
		{ key = "u", mods = "CTRL", action = wezterm.action.CopyMode("ClearPattern") },
	},
}

return {
	keys = keys,
	key_tables = key_tables,
}
