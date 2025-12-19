-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration
local config = wezterm.config_builder()

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 17

-- Disable the audible bell
config.audible_bell = "Disabled"

-- (Optional) also disable the visual bell flash if you don’t want that either
config.visual_bell = {
  fade_in_duration_ms = 0,
  fade_out_duration_ms = 0,
}

config.use_ime = false

-- keep adding configuration options here
-- config.enable_tab_bar = false

config.window_decorations = "RESIZE"
-- config.color_scheme = 'Tokyo Night'
-- config.color_scheme = 'NvimDark'
config.color_scheme = 'One Half Black (Gogh)'
-- config.color_scheme = 'Material Darker (base16)'
-- config.color_scheme = 'Mikazuki (terminal.sexy)'
-- config.color_scheme = 'Modus Vivendi (Gogh)'
-- config.color_scheme = 'Modus-Vivendi-Tinted'

-- ⌘L -> Ctrl+L  |  ⌘A -> Ctrl+A
config.keys = {
  -- {
  --   key = "l",
  --   mods = "SUPER",
  --   action = wezterm.action.SendKey { key = "l", mods = "CTRL" },
  -- },
  -- {
  --   key = "a",
  --   mods = "SUPER",
  --   action = wezterm.action.SendKey { key = "a", mods = "CTRL" },
  -- },
  -- {
  --   key = "d",
  --   mods = "SUPER",
  --   action = wezterm.action.SendKey { key = "d", mods = "CTRL" },
  -- },
  -- {
  --   key = "t",
  --   mods = "CTRL",
  --   action = wezterm.action.SpawnTab("DefaultDomain"),
  -- },
  {
    key = "w",
    mods = "CTRL",
    action = wezterm.action.CloseCurrentTab { confirm = true },
  },
  {
    key = "c",
    mods = "SUPER",
    action = wezterm.action.CopyTo("Clipboard"),
  },
  {
    key = "c",
    mods = "CTRL",
    action = wezterm.action.SendKey { key = "c", mods = "CTRL" },
  },
  {
    key = "1",
    mods = "CTRL",
    action = wezterm.action.ActivateTab(0),
  },
  {
    key = "2",
    mods = "CTRL",
    action = wezterm.action.ActivateTab(1),
  },
  {
    key = "3",
    mods = "CTRL",
    action = wezterm.action.ActivateTab(2),
  },
  {
    key = "4",
    mods = "CTRL",
    action = wezterm.action.ActivateTab(3),
  },
  {
    key = "5",
    mods = "CTRL",
    action = wezterm.action.ActivateTab(4),
  },
}

wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return config
