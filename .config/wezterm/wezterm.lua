local wezterm = require("wezterm")
local config = wezterm.config_builder()
local colors = require("colors")

-- Disble wayland to prevent resizing issues
config.enable_wayland = false

-- Disable exit confirmation message
config.window_close_confirmation = "NeverPrompt"

-- Color scheme based on
--  https://github.com/gfguthrie/wezterm-canonical-solarized
colors.apply_to_config(config)
config.color_scheme = "Solarized Dark"

-- Font
config.font = wezterm.font("Fira Code Nerd Font")

-- Disable fancy tab bar
config.use_fancy_tab_bar = false

-- Tab bar at bottom
config.tab_bar_at_bottom = true

-- Don't show new-tab button
config.show_new_tab_button_in_tab_bar = false

-- Set window padding
config.window_padding = {
	left = "1cell",
	right = "1cell",
	top = "0.5cell",
	bottom = "0cell",
}

return config
