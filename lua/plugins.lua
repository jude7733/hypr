--------------------
-- ### PLUGINS ###
--------------------

local theme = require("theme")
local wal = _G.wal or theme.load_wal()

local function c(name, fallback)
	return wal[name] or fallback
end

local function alpha(col, a)
	if not col then
		return nil
	end
	return (col:gsub("[%d%.]+%)$", a .. ")"))
end

hl.config({
	plugin = {
		overview = {
			onBottom = true,
			centerAligned = true,
			hideTopLayers = true,
			hideOverlayLayers = true,
			hideRealLayers = true,
			affectStrut = false,
			workspaceBorderSize = 3,
			dragAlpha = 0.6,
			autoDrag = true,
			exitOnClick = true,
			showNewWorkspace = true,
			switchOnDrop = true,
			showEmptyWorkspace = true,

			-- Hyprspace Pywal Theming
			panelColor = alpha(c("background"), 0.8) or "rgba(18,18,16,0.8)",
			panelBorderColor = c("color6", "rgba(33,156,159,1.0)"),
			panelBorderWidth = 2,
			workspaceActiveBorder = c("color10", "rgba(225,167,68,1.0)"),
			workspaceInactiveBorder = alpha(c("color6"), 0.6) or "rgba(33,156,159,0.6)",
			workspaceActiveBackground = alpha(c("color0"), 0.6) or "rgba(18,18,16,0.6)",
			workspaceInactiveBackground = alpha(c("color0"), 0.25) or "rgba(18,18,16,0.25)",
		},

		hyprfocus = {
			enable = true,
			animate_floating = false,
			keyboard_focus_animation = "flash",
			mouse_focus_animation = "flash",
			fade_opacity = 0.75,
		},

		-- NOTE: Disabled or unbuilt plugins in hyprpm are kept commented out
		-- to prevent unknown config key errors.
		--
		-- hyprbars = {
		-- 	bar_height = 20,
		-- 	buttons = {
		-- 		{ color = "rgb(ff4040)", size = 13, icon = "󰖭", command = "hyprctl dispatch killactive" },
		-- 		{ color = "rgb(eeee11)", size = 13, icon = "", command = "hyprctl dispatch fullscreen 1" },
		-- 	},
		-- },
		--
		-- hyprexpo = {
		-- 	columns = 3,
		-- 	gap_size = 5,
		-- 	bg_col = "rgb(111111)",
		-- 	workspace_method = "center current",
		-- },
		--
		-- hyprwinwrap = {
		-- 	class = "kitty-bg",
		-- },
	},
})

-- Dynamic Cursors (Configured per https://github.com/VirtCode/hypr-dynamic-cursors)
-- The guard ensures config parsing does not fail if the plugin is not yet loaded at startup.
if hl.plugin and hl.plugin.dynamic_cursors then
	hl.config({
		plugin = {
			dynamic_cursors = {
				enabled = true,
				mode = "stretch",
				threshold = 2,
				rotate = {
					length = 20,
					offset = 0.0,
				},
				tilt = {
					limit = 5000,
					activation = "negative_quadratic",
					window = 100,
					full = 60,
				},
				stretch = {
					limit = 3000,
					activation = "quadratic",
					window = 100,
				},
				shake = {
					enabled = true,
					threshold = 6.0,
					base = 4.0,
					speed = 4.0,
					influence = 0.0,
					limit = 0.0,
					timeout = 2000,
					effects = false,
					ipc = false,
				},
				hyprcursor = {
					enabled = true,
					nearest = 1,
					resolution = -1,
					fallback = "clientside",
				},
			},
		},
	})
end
