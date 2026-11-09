------------------------
-- ### SUBMODULES ### --
------------------------

package.path = os.getenv("HOME") .. "/.config/hypr/lua/?.lua;" .. package.path

local theme = require("theme")
_G.wal = theme.load_wal()

-- Helper for colors
local function c(name, fallback)
	return _G.wal[name] or fallback
end

----------------------
-- ### MONITORS ### --
----------------------

hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@60",
	position = "0x0",
	scale = "1.2",
})

hl.monitor({
	output = "eDP-1",
	mode = "1920x1200@60",
	position = "1920x0",
	scale = "1",
})

-- Fallback for any other connected display
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

-----------------------
-- ### AUTOSTART ### --
-----------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE")

	-- Core daemons
	hl.exec_cmd("waybar &")
	hl.exec_cmd("swaync & (systemctl --user start hyprpolkitagent 2>/dev/null || /usr/lib/hyprpolkitagent 2>/dev/null || /usr/lib/polkit-kde-authentication-agent-1) &")
	hl.exec_cmd("awww-daemon & waypaper --restore & hypridle &")
	hl.exec_cmd("nm-applet --indicator &")
	hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 22 &")
	hl.exec_cmd("~/.config/hypr/scripts/hyprfocus-init.sh &")
	hl.exec_cmd("sleep 2 && kdeconnect-indicator & hyprsunset &")
	hl.exec_cmd("batsignal -b -w 25 -c 15 -d 10 -f 79 -p &")
	hl.exec_cmd("wl-paste --type text --watch cliphist store &")
	hl.exec_cmd("wl-paste --type image --watch cliphist store &")
end)

-----------------------------------
-- ### ENVIRONMENT VARIABLES ### --
-----------------------------------

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM_PLUGIN_PATH", "/usr/lib/qt/plugins/platforms")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")

hl.env("HYPRSHOT_DIR", "Pictures/Screenshots/")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE", "22")
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "22")
hl.env("GTK_THEME", "Materia-dark-compact")

hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("SDL_VIDEODRIVER", "wayland,x11")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("LIBVA_DRIVER_NAME", "iHD")
hl.env("MOZ_ENABLE_WAYLAND", "1")

---------------------------
-- ### LOOK AND FEEL ### --
---------------------------

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 5,
		border_size = 2,
		col = {
			active_border = { colors = { c("color10"), c("color9"), c("color11") }, angle = 45 },
			inactive_border = c("color6"),
		},
		resize_on_border = true,
		allow_tearing = false,
		layout = "dwindle",
	},

	dwindle = {
		default_split_ratio = 1.1,
		special_scale_factor = 0.95,
		preserve_split = true,
	},

	scrolling = {
		column_width = 0.7,
		fullscreen_on_one_column = true,
	},

	decoration = {
		rounding = 10,
		active_opacity = 0.96,
		inactive_opacity = 0.8,
		dim_inactive = true,
		dim_strength = 0.1,
		dim_special = 0.3,
		dim_modal = true,
	wobble = {
		enabled = true,
		stiffness = 180,
		damping = 18,
		mass = 1.0,
	},
		blur = {
			enabled = true,
			size = 5,
			passes = 2,
			new_optimizations = true,
			ignore_opacity = true,
			xray = false,
			vibrancy = 0.1696,
			popups = true,
			popups_ignorealpha = 0.6,
			special = true,
		},
		shadow = {
			enabled = true,
			range = 10,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
	},

	animations = {
		enabled = true,
	},

	input = {
		kb_layout = "us",
		kb_options = "caps:escape_shifted_capslock",
		follow_mouse = 1,
		sensitivity = 0.8,
		touchpad = {
			natural_scroll = true,
		},
	},

	misc = {
		vrr = 1,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		animate_manual_resizes = true,
		animate_mouse_windowdragging = false,
	},

	render = {
		direct_scanout = true,
	},
})

-------------------------
-- ### ANIMATIONS ### --
-------------------------

-- Curves & Springs
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("quickSnap", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("fastClose", { type = "bezier", points = { { 0.3, 0 }, { 0.7, 0.15 } } })
hl.curve("snappy", { type = "spring", mass = 1, stiffness = 300, damping = 26 })
hl.curve("bouncy", { type = "spring", mass = 1, stiffness = 260, damping = 19 })

-- Windows (Fast, tactile popin on open; instant collapse on close)
hl.animation({ leaf = "windows", enabled = true, speed = 3.2, spring = "snappy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3.0, spring = "bouncy", style = "popin 85%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.8, bezier = "fastClose", style = "popin 80%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3.2, spring = "snappy" })

-- Fade & Focus transitions
hl.animation({ leaf = "fadeIn", enabled = true, speed = 2.5, bezier = "quickSnap" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.8, bezier = "fastClose" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 2.0, bezier = "quickSnap" })
hl.animation({ leaf = "fade", enabled = true, speed = 2.5, bezier = "quickSnap" })

-- Layers (Launchers, SwayNC, Wofi, Waybar popups)
hl.animation({ leaf = "layers", enabled = true, speed = 3.0, spring = "snappy" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 2.8, spring = "bouncy", style = "popin 85%" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.8, bezier = "fastClose", style = "popin 85%" })

-- Workspaces
hl.animation({ leaf = "workspaces", enabled = true, speed = 3.0, spring = "snappy", style = "slidefade 20%" })

-- Scratchpad (Special Workspace)
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3.2, spring = "bouncy", style = "slidefadevert 15%" })

-- Borders
hl.animation({ leaf = "border", enabled = true, speed = 2.0, bezier = "linear" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 25, bezier = "linear", style = "loop" })

--------------------
-- ### DEVICE ### --
--------------------

hl.device({
	name = "elan06c8:00-04f3:320b-touchpad",
	sensitivity = 0.4,
})
hl.device({
	name = "tpps/2-elan-trackpoint",
	sensitivity = -0.3,
})

-- Disable built-in ThinkPad keyboard
hl.device({
	name = "at-translated-set-2-keyboard",
	enabled = false,
})
hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

------------------
-- ### MODULES ###
------------------

require("binds")
require("rules")
require("plugins")
