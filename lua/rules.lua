-- Helper for colors
local function c(name, fallback)
	return _G.wal[name] or fallback
end

----------------------------------
-- ### WINDOWS AND WORKSPACES ###
----------------------------------

-- Suppress maximize event for all windows
hl.window_rule({
	name = "suppress-maximize",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Set bordercolor to purple if window is fullscreen
hl.window_rule({
	name = "fullscreen-bordercolor",
	match = { fullscreen = 1 },
	border_color = { colors = { c("color13", "rgb(b48ead)"), c("color14", "rgb(d08770)") }, angle = 45 },
})

-- Opacity rules
local opacity_rules = {
	{ class = "kitty", opacity = 1.0 },
	{ class = "antigravity", opacity = 0.95 },
	{ class = "zen", opacity = 0.99999 },
	{ title = "Mozilla Firefox", opacity = 0.9 },
	{ fullscreen = 1, opacity = 1.0 },
	{ class = "thunar", opacity = 0.8 },
	{ title = "Telegram", opacity = 0.95 },
	{ class = "discord", opacity = 0.96 },
}

for _, rule in ipairs(opacity_rules) do
	local match = {}
	if rule.class then
		match.class = "^(" .. rule.class .. ")$"
	end
	if rule.title then
		match.title = "^(" .. rule.title .. ")$"
	end
	if rule.fullscreen then
		match.fullscreen = rule.fullscreen
	end

	hl.window_rule({
		name = (rule.class or rule.title or "fullscreen") .. "-opacity",
		match = match,
		opacity = rule.opacity,
	})
end

-- Layer rules
hl.layer_rule({
	name = "logout-blur",
	match = { namespace = "logout_dialog" },
	blur = true,
})

-- Float rules
local float_apps = {
	{ class = "wofi" },
	{ class = "waypaper" },
	{ class = "org.gnome.Calculator" },
	{ class = "(org.pulseaudio.pavucontrol|pavucontrol)" },
	{ title = "File Operation Progress" },
	{ title = "Picture in picture" },
	{ class = "brave", title = "Save File" },
	{ class = "brave", title = "Open File" },
	{ class = "LibreWolf", title = "Picture-in-Picture" },
	{ class = "blueman-manager" },
	{ class = "xdg-desktop-portal-hyprland" },
	{ class = "org.kde.polkit-kde-authentication-agent-1" },
	{ class = "zenity" },
	{ title = "Steam - Self Updater" },
	{ class = "Safeeyes" },
}

for _, app in ipairs(float_apps) do
	hl.window_rule({
		name = "float-" .. (app.class or app.title),
		match = app,
		float = true,
	})
end

-- Sized/Positioned Float Rules
hl.window_rule({
	name = "pip-size-position",
	match = { title = "^(Picture-in-Picture)$" },
	size = { 960, 540 }, -- Fixed to 2 elements
	move = { 20, 20 }, -- Fixed to 2 elements for vec2
	float = true,
})

-- Workspace assignments
hl.window_rule({
	name = "btop-workspace",
	match = { title = "^(btop)$" },
	workspace = 4,
})

-- Fix XWayland drag-and-drop issues
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

---------------------------
-- ### WORKSPACE RULES ###
---------------------------

hl.workspace_rule({
	workspace = 1,
	monitor = "eDP-1",
	default = true,
	layout = "scrolling",
})

hl.workspace_rule({
	workspace = 2,
	monitor = "eDP-1",
	default_name = "coding",
	gaps_out = 2,
	layout = "monocle",
})

hl.workspace_rule({
	workspace = 3,
	monitor = "HDMI-A-1",
	default = true,
})

hl.workspace_rule({
	workspace = 4,
	monitor = "HDMI-A-1",
	layout = "master",
})

hl.workspace_rule({
	workspace = 5,
	on_created_empty = "firefox",
	layout = "scrolling",
})

hl.workspace_rule({
	workspace = 8,
	border_size = 8,
	default_name = "ext",
	gaps_out = 8,
	layout = "monocle",
})

hl.workspace_rule({
	workspace = "special:magic",
	on_created_empty = "kitty",
})
