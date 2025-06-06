local wezterm = require("wezterm")
local config = wezterm.config_builder()
local colors = require("colors")

-- disble wayland to prevent resizing issues
config.enable_wayland = false

-- disable exit confirmation message
config.window_close_confirmation = "NeverPrompt"

-- color scheme
-- based on
-- https://github.com/gfguthrie/wezterm-canonical-solarized
colors.apply_to_config(config)
config.color_scheme = "Solarized Dark"

-- font
config.font = wezterm.font("Fira Code Nerd Font")

-- disable fancy tab bar
config.use_fancy_tab_bar = false

-- tab bar at bottom
config.tab_bar_at_bottom = true

-- don't show new-tab button
config.show_new_tab_button_in_tab_bar = false

-- set window paddings
config.window_padding = {
	left = "1cell",
	right = "1cell",
	top = "0.5cell",
	bottom = "0cell",
}

return config
