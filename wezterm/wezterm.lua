local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- ============================================================================
-- =                                 STYLE                                    =
-- ============================================================================

-- Other cool options:
-- Black Metal (Mayhem) (base16) -- Similar to Burzum but with more contrast
-- City Streets (terminal.sexy) -- Dark and muted
-- Dark Violet (base16) -- Very purple
-- darkmoss (base16) -- Warm with a bit of nice colors
-- Embers (dark) (terminal.sexy) -- Dark colors, warm
-- Grayscale (dark) (terminal.sexy)
-- Grayscale (light) (terminal.sexy)
-- Hardcore (Gogh) -- dark, strong neon colors
-- Paper (Gogh) -- light, yellowish with darker colors
-- Red Planet -- Dark with industrial, muted colors
config.color_scheme = "Black Metal (Burzum) (base16)"
config.font = wezterm.font("Iosevka Nerd Font")
config.font_size = 10.5

config.freetype_load_target = "Light"

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.animation_fps = 1
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- disable ligatures
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

-- ============================================================================
-- =                                FEATURE                                   =
-- ============================================================================
config.default_prog = { "fish", "-l" }
config.launch_menu = {
	{
		label = "bash",
		args = { "bash", "-l" },
	},
	{
		label = "zsh",
		args = { "zsh", "-l" },
	},
}

-- ============================================================================
-- =                                KEYBINDS                                  =
-- ============================================================================
config.keys = {
	{
		key = "b",
		mods = "CTRL",
		action = wezterm.action.ShowLauncher,
	},
	{
		key = "b",
		mods = "CTRL",
		action = wezterm.action.Nop,
	},
}

return config
