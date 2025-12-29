local Config = require("config")

-- Global theme configuration
-- Options: "pro", "spectrum", "classic", "machine", "ristretto", "octagon", "light"
THEME = "pro"

-- Global tab bar mode configuration
-- true = native fancy tabs with borders, false = custom styled tabs with circles
USE_FANCY_TAB_BAR = true

-- Setup event handlers
require("events.left-status").setup()
require("events.right-status").setup()
require("events.tab-title").setup({
	hide_active_tab_unseen = false, -- Hide unseen indicator on active tab
	unseen_icon = "numbered_circle",
	title_source = "main", -- "active" = current pane, "main" = first/top-left pane
	use_fancy_tab_bar = USE_FANCY_TAB_BAR,
})

return Config:init()
	:append(require("config.general"))
	:append(require("config.appearance"))
	:append(require("config.fonts"))
	:append(require("config.bindings")).options
