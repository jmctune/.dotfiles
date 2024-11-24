local wezterm = require 'wezterm'

local act = wezterm.action
local config = wezterm.config_builder()
local mod = {}

-- https://wezfurlong.org/wezterm/config/lua/config/index.html
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  mod.SUPER = 'ALT'
  mod.SUPER_REV = 'ALT|SHIFT'

  config.font = wezterm.font('MesloLGS Nerd Font Mono')
  config.default_prog = { 'pwsh.exe', '-NoLogo' }
  config.window_decorations = 'INTEGRATED_BUTTONS'
  config.integrated_title_button_color = 'grey'
end

if wezterm.target_triple == 'aarch64-apple-darwin' then
  mod.SUPER = 'SUPER'
  mod.SUPER_REV = 'SUPER|SHIFT'

  config.font = wezterm.font('Menlo')
  config.default_prog = { '/bin/zsh' }
  config.window_decorations = 'RESIZE'
end

config.color_scheme = 'Ef-Maris-Dark'
config.font_size = 16
config.enable_tab_bar = true
config.bold_brightens_ansi_colors = true
config.enable_scroll_bar = true
config.initial_cols = 120
config.initial_rows = 30
config.prefer_to_spawn_tabs = true
config.quote_dropped_files = 'WindowsAlwaysQuoted'
config.show_tab_index_in_tab_bar = false
config.treat_east_asian_ambiguous_width_as_wide = true
config.use_fancy_tab_bar = false
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 800
config.animation_fps = 60

config.keys = {
  {
    -- creates a new tab
    mods = mod.SUPER,
    key = 'n',
    action = act.SpawnTab 'CurrentPaneDomain',
  },
  {
    -- creates a new pane vertically
    mods = mod.SUPER,
    key = 'd',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    -- creates a new pane horizontally
    mods = mod.SUPER_REV,
    key = 'D',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    -- navigates active pane to the left
    mods = mod.SUPER,
    key = '[',
    action = act.ActivatePaneDirection 'Prev',
  },
  {
    -- navigates active pane to the right
    mods = mod.SUPER,
    key = ']',
    action = act.ActivatePaneDirection 'Next',
  },
  {
    -- navigate active tab to the left
    mods = mod.SUPER_REV,
    key = '{',
    action = act.ActivateTabRelative(-1)
  },
  {
    -- navigate active tab to the right
    mods = mod.SUPER_REV,
    key = '}',
    action = act.ActivateTabRelative(1)
  }
}

config.mouse_bindings = {
  {
    -- right-click selected text to copy, right-click nothing to paste
    event = { Down = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = wezterm.action_callback(function(window, pane)
    local has_selection = window:get_selection_text_for_pane(pane) ~= ""
      if has_selection then
        window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
        window:perform_action(act.ClearSelection, pane)
      else
        window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
      end
    end),
  }
}

return config
