------------------------------------------------------------------------------------------
-- Inspired by https://github.com/wez/wezterm/discussions/628#discussioncomment-1874614 --
------------------------------------------------------------------------------------------

local wezterm = require('wezterm')
local Cells = require('utils.cells')
local OptsValidator = require('utils.opts-validator')

-- Get palette colors from the global THEME
local palette = require('colorscheme.palette.' .. THEME)

---
-- =======================================
-- Defining event setup options and schema
-- =======================================

---@alias Event.TabTitleOptions { unseen_icon: 'circle' | 'numbered_circle' | 'numbered_box', hide_active_tab_unseen: boolean, title_source: 'active' | 'main', use_fancy_tab_bar: boolean }

---Setup options for the tab title
local EVENT_OPTS = {}

---@type OptsSchema
EVENT_OPTS.schema = {
   {
      name = 'unseen_icon',
      type = 'string',
      enum = { 'circle', 'numbered_circle', 'numbered_box' },
      default = 'circle',
   },
   {
      name = 'hide_active_tab_unseen',
      type = 'boolean',
      default = true,
   },
   {
      name = 'title_source',
      type = 'string',
      enum = { 'active', 'main' },
      default = 'active',
   },
   {
      name = 'use_fancy_tab_bar',
      type = 'boolean',
      default = false,
   },
}
EVENT_OPTS.validator = OptsValidator:new(EVENT_OPTS.schema)

---
-- ===================
-- Constants and icons
-- ===================

local nf = wezterm.nerdfonts

local M = {}

local GLYPH_SCIRCLE_LEFT = nf.ple_left_half_circle_thick --[[  ]]
local GLYPH_SCIRCLE_RIGHT = nf.ple_right_half_circle_thick --[[  ]]
local GLYPH_CIRCLE = nf.fa_circle --[[  ]]
local GLYPH_ADMIN = nf.md_shield_half_full --[[ 󰞀 ]]
local GLYPH_LINUX = nf.cod_terminal_linux --[[  ]]
local GLYPH_DEBUG = nf.fa_bug --[[  ]]
-- local GLYPH_SEARCH = nf.fa_search --[[  ]]
local GLYPH_SEARCH = '🔭'

-- Process icons mapping with colors (inspired by nvim-web-devicons)
local PROCESS_ICONS = {
   ['nvim'] = { icon = nf.custom_neovim, color = '#019833' }, --[[ 󰕷 ]] -- Neovim green
   ['vim'] = { icon = nf.dev_vim, color = '#019833' }, --[[  ]] -- Vim green
   ['node'] = { icon = nf.md_nodejs, color = '#8CC84B' }, --[[ 󰎙 ]] -- Node.js green
   ['python'] = { icon = nf.dev_python, color = '#3776AB' }, --[[  ]] -- Python blue
   ['python3'] = { icon = nf.dev_python, color = '#3776AB' }, --[[  ]] -- Python blue
   ['ruby'] = { icon = nf.dev_ruby, color = '#CC342D' }, --[[  ]] -- Ruby red
   ['git'] = { icon = nf.dev_git, color = '#F14E32' }, --[[  ]] -- Git orange-red
   ['cargo'] = { icon = nf.dev_rust, color = '#CE422B' }, --[[  ]] -- Rust orange
   ['docker'] = { icon = nf.linux_docker, color = '#2496ED' }, --[[  ]] -- Docker blue
   ['ssh'] = { icon = nf.md_ssh, color = '#F48924' }, --[[ 󰣀 ]] -- SSH orange
   ['bash'] = { icon = nf.cod_terminal_bash, color = '#89E051' }, --[[  ]] -- Bash green
   ['zsh'] = { icon = nf.dev_terminal, color = '#89E051' }, --[[  ]] -- Zsh green
   ['fish'] = { icon = nf.dev_terminal, color = '#89E051' }, --[[  ]] -- Fish green
}

-- Editor processes that should show folder name instead of file name
local EDITOR_PROCESSES = {
   ['nvim'] = true,
   ['vim'] = true,
   ['vi'] = true,
   ['nano'] = true,
   ['emacs'] = true,
   ['code'] = true,  -- VS Code
   ['subl'] = true,  -- Sublime Text
}

local GLYPH_UNSEEN_NUMBERED_BOX = {
   [1] = nf.md_numeric_1_box_multiple, --[[ 󰼏 ]]
   [2] = nf.md_numeric_2_box_multiple, --[[ 󰼐 ]]
   [3] = nf.md_numeric_3_box_multiple, --[[ 󰼑 ]]
   [4] = nf.md_numeric_4_box_multiple, --[[ 󰼒 ]]
   [5] = nf.md_numeric_5_box_multiple, --[[ 󰼓 ]]
   [6] = nf.md_numeric_6_box_multiple, --[[ 󰼔 ]]
   [7] = nf.md_numeric_7_box_multiple, --[[ 󰼕 ]]
   [8] = nf.md_numeric_8_box_multiple, --[[ 󰼖 ]]
   [9] = nf.md_numeric_9_box_multiple, --[[ 󰼗 ]]
   [10] = nf.md_numeric_9_plus_box_multiple, --[[ 󰼘 ]]
}

local GLYPH_UNSEEN_NUMBERED_CIRCLE = {
   [1] = nf.md_numeric_1_circle, --[[ 󰲠 ]]
   [2] = nf.md_numeric_2_circle, --[[ 󰲢 ]]
   [3] = nf.md_numeric_3_circle, --[[ 󰲤 ]]
   [4] = nf.md_numeric_4_circle, --[[ 󰲦 ]]
   [5] = nf.md_numeric_5_circle, --[[ 󰲨 ]]
   [6] = nf.md_numeric_6_circle, --[[ 󰲪 ]]
   [7] = nf.md_numeric_7_circle, --[[ 󰲬 ]]
   [8] = nf.md_numeric_8_circle, --[[ 󰲮 ]]
   [9] = nf.md_numeric_9_circle, --[[ 󰲰 ]]
   [10] = nf.md_numeric_9_plus_circle, --[[ 󰲲 ]]
}

local TITLE_INSET = {
   DEFAULT = 6,
   ICON = 8,
}

local TAB_WIDTH = {
   MIN = 20,  -- Minimum tab width
   MAX = 40,  -- Maximum tab width
}

local RENDER_VARIANTS = {
   { 'scircle_left', 'icon', 'title', 'padding', 'scircle_right' },
   { 'scircle_left', 'icon', 'title', 'unseen_output', 'padding', 'scircle_right' },
   { 'scircle_left', 'admin', 'icon', 'title', 'padding', 'scircle_right' },
   { 'scircle_left', 'admin', 'icon', 'title', 'unseen_output', 'padding', 'scircle_right' },
   { 'scircle_left', 'wsl', 'icon', 'title', 'padding', 'scircle_right' },
   { 'scircle_left', 'wsl', 'icon', 'title', 'unseen_output', 'padding', 'scircle_right' },
}


---@type table<string, Cells.SegmentColors>
-- Custom tab bar colors (when use_fancy_tab_bar = false)
-- stylua: ignore
local colors = {
   text_default          = { bg = palette.dimmed5, fg = palette.dark1 },
   text_hover            = { bg = palette.dimmed4, fg = palette.dark1 },
   text_active           = { bg = palette.dimmed3, fg = palette.dark2 },

   unseen_output_default = { bg = palette.dimmed5, fg = palette.accent2 },
   unseen_output_hover   = { bg = palette.dimmed4, fg = palette.accent2 },
   unseen_output_active  = { bg = palette.dimmed3, fg = palette.accent2 },

   scircle_default       = { bg = 'rgba(0, 0, 0, 0.4)', fg = palette.dimmed5 },
   scircle_hover         = { bg = 'rgba(0, 0, 0, 0.4)', fg = palette.dimmed4 },
   scircle_active        = { bg = 'rgba(0, 0, 0, 0.4)', fg = palette.dimmed3 },
}

---@type table<string, {bg: string, fg: string}>
-- Fancy tab bar colors (when use_fancy_tab_bar = true)
-- stylua: ignore
local fancy_colors = {
   text_default          = { bg = palette.dimmed5, fg = '#a0a0a0' },
   text_hover            = { bg = palette.dimmed4, fg = '#d0d0d0' },
   text_active           = { bg = palette.background, fg = '#ffffff' },

   admin_default         = { bg = palette.dimmed5, fg = palette.accent2 },
   admin_hover           = { bg = palette.dimmed4, fg = palette.accent2 },
   admin_active          = { bg = palette.dimmed3, fg = palette.accent2 },

   wsl_default           = { bg = palette.dimmed5, fg = palette.accent3 },
   wsl_hover             = { bg = palette.dimmed4, fg = palette.accent3 },
   wsl_active            = { bg = palette.dimmed3, fg = palette.accent3 },

   unseen_default        = { bg = palette.dimmed5, fg = palette.accent2 },
   unseen_hover          = { bg = palette.dimmed4, fg = palette.accent2 },
   unseen_active         = { bg = palette.background, fg = palette.accent2 },
}

---
-- ================
-- Helper functions
-- ================

---@param proc string
local function clean_process_name(proc)
   local a = string.gsub(proc, '(.*[/\\])(.*)', '%2')
   return a:gsub('%.exe$', '')
end

---@param process_name string
---@param base_title string
---@param max_width number
---@param inset number
---@return string icon, string|nil icon_color, string text
local function create_title(process_name, base_title, max_width, inset)
   local icon = ''
   local icon_color = nil
   local text = base_title

   -- Check if we have an icon for this process
   local process_icon_data = PROCESS_ICONS[process_name]

   if process_icon_data then
      -- Use icon instead of process name for compact display
      icon = process_icon_data.icon
      icon_color = process_icon_data.color
      text = base_title
      inset = inset - 1  -- Icons are more compact than text
   elseif process_name:len() > 0 then
      -- Fallback to text if no icon available (no icon segment)
      text = process_name .. ' ~ ' .. base_title
   end

   if base_title == 'Debug' then
      icon = GLYPH_DEBUG
      icon_color = '#FF6C6B'  -- Red for debug
      text = 'DEBUG'
      inset = inset - 2
   end

   if base_title:match('^InputSelector:') ~= nil then
      icon = GLYPH_SEARCH
      icon_color = nil  -- Use default color for search emoji
      text = base_title:gsub('InputSelector:', '')
      inset = inset - 2
   end

   -- Calculate width: min width with ability to grow up to max
   local combined = icon .. (icon ~= '' and ' ' or '') .. text
   local target_width = combined:len() + inset

   if target_width > TAB_WIDTH.MAX then
      -- Truncate if exceeds max
      local diff = target_width - TAB_WIDTH.MAX
      text = text:sub(1, text:len() - diff)
   elseif target_width < TAB_WIDTH.MIN then
      -- Pad to minimum width
      local padding = TAB_WIDTH.MIN - target_width
      text = text .. string.rep(' ', padding)
   end
   -- Otherwise use natural width (between min and max)

   return icon, icon_color, text
end

---@param panes any[] WezTerm https://wezfurlong.org/wezterm/config/lua/pane/index.html
local function check_unseen_output(panes)
   local unseen_output = false
   local unseen_output_count = 0

   for i = 1, #panes, 1 do
      if panes[i].has_unseen_output then
         unseen_output = true
         if unseen_output_count >= 10 then
            unseen_output_count = 10
            break
         end
         unseen_output_count = unseen_output_count + 1
      end
   end

   return unseen_output, unseen_output_count
end

---
-- =================
-- Tab class and API
-- =================

---@class Tab
---@field icon string
---@field icon_color string|nil
---@field title string
---@field cells FormatCells
---@field title_locked boolean
---@field locked_title string
---@field is_wsl boolean
---@field is_admin boolean
---@field unseen_output boolean
---@field unseen_output_count number
---@field is_active boolean
local Tab = {}
Tab.__index = Tab

function Tab:new()
   local tab = {
      icon = '',
      icon_color = nil,
      title = '',
      cells = Cells:new(),
      title_locked = false,
      locked_title = '',
      is_wsl = false,
      is_admin = false,
      unseen_output = false,
      unseen_output_count = 0,
   }
   return setmetatable(tab, self)
end

---@param event_opts Event.TabTitleOptions
---@param tab any WezTerm https://wezfurlong.org/wezterm/config/lua/MuxTab/index.html
---@param max_width number
function Tab:set_info(event_opts, tab, max_width)
   -- Choose which pane to use for the title
   local pane = tab.active_pane
   if event_opts.title_source == 'main' and tab.panes and #tab.panes > 0 then
      pane = tab.panes[1]  -- Use first pane (top-left/main pane)
   end

   local process_name = clean_process_name(pane.foreground_process_name)

   self.is_wsl = process_name:match('^wsl') ~= nil
   self.is_admin = (
      pane.title:match('^Administrator: ') or pane.title:match('(Admin)')
   ) ~= nil
   self.unseen_output = false
   self.unseen_output_count = 0

   if not event_opts.hide_active_tab_unseen or not tab.is_active then
      self.unseen_output, self.unseen_output_count = check_unseen_output(tab.panes)
   end

   local inset = (self.is_admin or self.is_wsl) and TITLE_INSET.ICON or TITLE_INSET.DEFAULT
   if self.unseen_output then
      inset = inset + 2
   end

   if self.title_locked then
      self.icon, self.icon_color, self.title = create_title('', self.locked_title, max_width, inset)
      return
   end

   -- For editors, show folder name instead of file name
   local title_text = pane.title

   if EDITOR_PROCESSES[process_name] then
      local cwd = pane.current_working_dir
      if cwd then
         local cwd_path = cwd.file_path or cwd
         -- Extract the last folder name from the path
         local folder = cwd_path:match('([^/]+)/?$')
         if folder then
            title_text = folder
         end
      end
   end

   self.icon, self.icon_color, self.title = create_title(process_name, title_text, max_width, inset)
end

function Tab:create_cells()
   local attr = self.cells.attr
   self.cells
      :add_segment('scircle_left', GLYPH_SCIRCLE_LEFT)
      :add_segment('admin', ' ' .. GLYPH_ADMIN)
      :add_segment('wsl', ' ' .. GLYPH_LINUX)
      :add_segment('icon', ' ', nil, attr(attr.intensity('Bold')))
      :add_segment('title', ' ', nil, attr(attr.intensity('Bold')))
      :add_segment('unseen_output', ' ' .. GLYPH_CIRCLE)
      :add_segment('padding', ' ')
      :add_segment('scircle_right', GLYPH_SCIRCLE_RIGHT)
end

---@param title string
function Tab:update_and_lock_title(title)
   self.locked_title = title
   self.title_locked = true
end

---@param event_opts Event.TabTitleOptions
---@param is_active boolean
---@param hover boolean
function Tab:update_cells(event_opts, is_active, hover)
   local tab_state = 'default'
   if is_active then
      tab_state = 'active'
   elseif hover then
      tab_state = 'hover'
   end

   -- Update icon segment with colored icon
   if self.icon ~= '' then
      self.cells:update_segment_text('icon', ' ' .. self.icon)
      -- Use custom color for icon if available, otherwise use tab state color
      if self.icon_color then
         self.cells:update_segment_colors('icon', { bg = colors['text_' .. tab_state].bg, fg = self.icon_color })
      else
         self.cells:update_segment_colors('icon', colors['text_' .. tab_state])
      end
   else
      self.cells:update_segment_text('icon', '')
   end

   self.cells:update_segment_text('title', ' ' .. self.title)

   if event_opts.unseen_icon == 'numbered_box' and self.unseen_output then
      self.cells:update_segment_text(
         'unseen_output',
         ' ' .. GLYPH_UNSEEN_NUMBERED_BOX[self.unseen_output_count]
      )
   end
   if event_opts.unseen_icon == 'numbered_circle' and self.unseen_output then
      self.cells:update_segment_text(
         'unseen_output',
         ' ' .. GLYPH_UNSEEN_NUMBERED_CIRCLE[self.unseen_output_count]
      )
   end

   self.cells
      :update_segment_colors('scircle_left', colors['scircle_' .. tab_state])
      :update_segment_colors('admin', colors['text_' .. tab_state])
      :update_segment_colors('wsl', colors['text_' .. tab_state])
      :update_segment_colors('title', colors['text_' .. tab_state])
      :update_segment_colors('unseen_output', colors['unseen_output_' .. tab_state])
      :update_segment_colors('padding', colors['text_' .. tab_state])
      :update_segment_colors('scircle_right', colors['scircle_' .. tab_state])
end

---@return FormatItem[] (ref: https://wezfurlong.org/wezterm/config/lua/wezterm/format.html)
function Tab:render()
   local variant_idx = self.is_admin and 3 or 1
   if self.is_wsl then
      variant_idx = 5
   end

   if self.unseen_output then
      variant_idx = variant_idx + 1
   end
   return self.cells:render(RENDER_VARIANTS[variant_idx])
end

---Render for fancy tab bar (formatted text with colors)
---@param event_opts Event.TabTitleOptions
---@param is_active boolean
---@param hover boolean
---@return FormatItem[]
function Tab:render_fancy(event_opts, is_active, hover)
   local elements = {}

   -- Determine tab state
   local tab_state = 'default'
   if is_active then
      tab_state = 'active'
   elseif hover then
      tab_state = 'hover'
   end

   -- Add admin/wsl prefix if needed
   if self.is_admin then
      local color = fancy_colors['admin_' .. tab_state]
      table.insert(elements, { Background = { Color = color.bg } })
      table.insert(elements, { Foreground = { Color = color.fg } })
      table.insert(elements, { Text = GLYPH_ADMIN .. ' ' })
   elseif self.is_wsl then
      local color = fancy_colors['wsl_' .. tab_state]
      table.insert(elements, { Background = { Color = color.bg } })
      table.insert(elements, { Foreground = { Color = color.fg } })
      table.insert(elements, { Text = GLYPH_LINUX .. ' ' })
   end

   -- Add colored icon if available
   if self.icon ~= '' then
      local text_color = fancy_colors['text_' .. tab_state]
      table.insert(elements, { Background = { Color = text_color.bg } })
      if self.icon_color then
         table.insert(elements, { Foreground = { Color = self.icon_color } })
      else
         table.insert(elements, { Foreground = { Color = text_color.fg } })
      end
      table.insert(elements, { Text = self.icon .. ' ' })
   end

   -- Add title text
   local text_color = fancy_colors['text_' .. tab_state]
   table.insert(elements, { Background = { Color = text_color.bg } })
   table.insert(elements, { Foreground = { Color = text_color.fg } })
   table.insert(elements, { Attribute = { Intensity = 'Bold' } })
   table.insert(elements, { Text = self.title })

   -- Add unseen output indicator if needed
   if self.unseen_output then
      local unseen_glyph = GLYPH_CIRCLE
      if event_opts.unseen_icon == 'numbered_box' then
         unseen_glyph = GLYPH_UNSEEN_NUMBERED_BOX[self.unseen_output_count]
      elseif event_opts.unseen_icon == 'numbered_circle' then
         unseen_glyph = GLYPH_UNSEEN_NUMBERED_CIRCLE[self.unseen_output_count]
      end
      local unseen_color = fancy_colors['unseen_' .. tab_state]
      table.insert(elements, { Background = { Color = unseen_color.bg } })
      table.insert(elements, { Foreground = { Color = unseen_color.fg } })
      table.insert(elements, { Text = ' ' .. unseen_glyph })
   end

   return elements
end

---@type Tab[]
local tab_list = {}

---@param opts? Event.TabTitleOptions Default: {unseen_icon = 'circle', hide_active_tab_unseen = true}
M.setup = function(opts)
   local valid_opts, err = EVENT_OPTS.validator:validate(opts or {})

   if err then
      wezterm.log_error(err)
   end

   -- CUSTOM EVENT
   -- Event listener to manually update the tab name
   -- Tab name will remain locked until the `reset-tab-title` is triggered
   wezterm.on('tabs.manual-update-tab-title', function(window, pane)
      window:perform_action(
         wezterm.action.PromptInputLine({
            description = wezterm.format({
               { Foreground = { Color = '#FFFFFF' } },
               { Attribute = { Intensity = 'Bold' } },
               { Text = 'Enter new name for tab' },
            }),
            action = wezterm.action_callback(function(_window, _pane, line)
               if line ~= nil then
                  local tab = window:active_tab()
                  local id = tab:tab_id()
                  tab_list[id]:update_and_lock_title(line)
               end
            end),
         }),
         pane
      )
   end)

   -- CUSTOM EVENT
   -- Event listener to unlock manually set tab name
   wezterm.on('tabs.reset-tab-title', function(window, _pane)
      local tab = window:active_tab()
      local id = tab:tab_id()
      tab_list[id].title_locked = false
   end)

   -- CUSTOM EVENT
   -- Event listener to manually update the tab name
   wezterm.on('tabs.toggle-tab-bar', function(window, _pane)
      local effective_config = window:effective_config()
      window:set_config_overrides({
         enable_tab_bar = not effective_config.enable_tab_bar,
         background = effective_config.background,
      })
   end)

   -- BUILTIN EVENT
   wezterm.on('format-tab-title', function(tab, _tabs, _panes, _config, hover, max_width)
      if not tab_list[tab.tab_id] then
         tab_list[tab.tab_id] = Tab:new()
         tab_list[tab.tab_id]:set_info(valid_opts, tab, max_width)

         if valid_opts.use_fancy_tab_bar then
            -- Fancy tab bar: return formatted text with state-based colors
            return tab_list[tab.tab_id]:render_fancy(valid_opts, tab.is_active, hover)
         else
            -- Custom tab bar: use cells-based rendering
            tab_list[tab.tab_id]:create_cells()
            return tab_list[tab.tab_id]:render()
         end
      end

      tab_list[tab.tab_id]:set_info(valid_opts, tab, max_width)

      if valid_opts.use_fancy_tab_bar then
         -- Fancy tab bar: return formatted text with state-based colors
         return tab_list[tab.tab_id]:render_fancy(valid_opts, tab.is_active, hover)
      else
         -- Custom tab bar: use cells-based rendering
         tab_list[tab.tab_id]:update_cells(valid_opts, tab.is_active, hover)
         return tab_list[tab.tab_id]:render()
      end
   end)
end

return M
