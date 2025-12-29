local wezterm = require("wezterm")
local Cells = require("utils.cells")

-- Get palette colors from the global THEME
local palette = require("colorscheme.palette." .. THEME)

local nf = wezterm.nerdfonts
local attr = Cells.attr

local M = {}

local ICON_FOLDER = nf.md_folder --[[ 󰉋 ]]

---@type table<string, Cells.SegmentColors>
local colors = {
	cwd = { fg = palette.accent3, bg = "#333333" },
}

local cells = Cells:new()

cells
	:add_segment("cwd_icon", ICON_FOLDER .. " ", colors.cwd, attr(attr.intensity("Bold")))
	:add_segment("cwd_text", "", colors.cwd, attr(attr.intensity("Bold")))

M.setup = function()
	wezterm.on("update-right-status", function(window, pane)
		local cwd = pane:get_current_working_dir()
		local cwd_text = ""

		if cwd then
			cwd = cwd.file_path or cwd
			-- Replace home directory with ~
			local home = os.getenv("HOME")
			if home and cwd:sub(1, #home) == home then
				cwd_text = "~" .. cwd:sub(#home + 1)
			else
				cwd_text = cwd
			end
		end

		cells:update_segment_text("cwd_text", cwd_text .. ' ')

		window:set_right_status(wezterm.format(cells:render({ "cwd_icon", "cwd_text" })))
	end)
end

return M
