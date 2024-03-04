local wezterm = require("wezterm")

local config = wezterm.config_builder()

local color_scheme = {
	"Everforest Dark (Gogh)",
	"Nord (Gogh)",
	"One Dark (Gogh)",
	"Tokyo Night",
	"matrix",
	"nightfox",
}

local randomTheme = function()
	return color_scheme[math.random(1, #color_scheme)]
end

-- Styles
config.hide_tab_bar_if_only_one_tab = true
config.color_scheme = randomTheme()
config.font = wezterm.font("Victor Mono")
config.font_size = 16
config.line_height = 1.1
config.default_cursor_style = "SteadyBlock"

-- Keybindings
config.keys = {
	{
		key = "d",
		mods = "CMD",
		action = wezterm.action.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
	{
		key = "D",
		mods = "CMD",
		action = wezterm.action.SplitPane({
			direction = "Down",
			size = { Percent = 50 },
		}),
	},
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "k",
		mods = "CMD",
		action = wezterm.action.ActivateCommandPalette
	},
	{
		key = 'c',
		mods = 'CMD|SHIFT',
		action = wezterm.action.QuickSelect
	}
}

return config
