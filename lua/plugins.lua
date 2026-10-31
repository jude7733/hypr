--------------------
-- ### PLUGINS ###
--------------------

hl.config({
	plugin = {
		hyprbars = {
			bar_height = 20,
			-- Buttons in Lua might be a nested table
			buttons = {
				{ color = "rgb(ff4040)", size = 13, icon = "󰖭", command = "hyprctl dispatch killactive" },
				{ color = "rgb(eeee11)", size = 13, icon = "", command = "hyprctl dispatch fullscreen 1" },
			},
		},

		hyprexpo = {
			columns = 3,
			gap_size = 5,
			bg_col = "rgb(111111)",
			workspace_method = "center current",
		},

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
		},

		hyprwinwrap = {
			class = "kitty-bg",
		},

		hyprfocus = {
			enabled = true,
			keyboard_focus_animation = "shrink",
			mouse_focus_animation = "shrink",
			bezier = {
				bezIn = { 0.5, 0, 1, 0.5 },
				bezOut = { 0, 0.5, 0.5, 1 },
			},
			flash = {
				flash_opacity = 0.7,
				in_bezier = "bezIn",
				in_speed = 0.5,
				out_bezier = "bezOut",
				out_speed = 3,
			},
			shrink = {
				shrink_percentage = 0.8,
				in_bezier = "bezIn",
				in_speed = 0.5,
				out_bezier = "bezOut",
				out_speed = 3,
			},
		},

		["dynamic-cursors"] = {
			enabled = true,
			mode = "stretch",
			threshold = 2,
			rotate = {
				length = 20,
				offset = 0.0,
			},
			tilt = {
				limit = 5000,
				function_type = "negative_quadratic",
				window = 100,
			},
			stretch = {
				limit = 3000,
				function_type = "quadratic",
				window = 100,
			},
			shake = {
				enabled = true,
				nearest = true,
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
				nearest = true,
				enabled = true,
				resolution = -1,
				fallback = "clientside",
			},
		},
	},
})
