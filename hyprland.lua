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
	hl.exec_cmd("hyprpm reload -n &")
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
		blur = {
			enabled = true,
			size = 5,
			passes = 2,
			new_optimizations = true,
			ignore_opacity = true,
			xray = false,
			vibrancy = 0.1696,
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
		animate_manual_resizes = false,
		animate_mouse_windowdragging = false,
	},

	render = {
		direct_scanout = true,
	},
})

-- Curves
hl.curve("wind", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("winIn", { type = "bezier", points = { { 0.1, 1.1 }, { 0.1, 1.1 } } })
hl.curve("winOut", { type = "bezier", points = { { 0.3, -0.3 }, { 0, 1 } } })
hl.curve("liner", { type = "bezier", points = { { 1, 1 }, { 1, 1 } } })

-- New Curves & Springs
hl.curve("snappy", { type = "spring", mass = 1, stiffness = 100, dampening = 15 })
hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.1 } } })
hl.curve("smoothIn", { type = "bezier", points = { { 0.25, 1 }, { 0.5, 1 } } })
hl.curve("smoothOut", { type = "bezier", points = { { 0.36, 0 }, { 0.66, -0.56 } } })

-- New Animations
hl.animation({ leaf = "windows", enabled = true, speed = 5, spring = "snappy", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, bezier = "overshot", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "smoothOut", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, spring = "snappy", style = "slide" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "overshot", style = "slidefade 20%" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5, bezier = "overshot", style = "slidefadevert 10%" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "liner" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "liner" })
hl.animation({ leaf = "fade", enabled = true, speed = 8, bezier = "smoothIn" })

-- Previous Animations (Uncomment to restore)
-- hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "wind", style = "slide" })
-- hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, bezier = "winIn", style = "slide" })
-- hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "winOut", style = "slide" })
-- hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "wind", style = "slide" })
-- hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "liner" })
-- hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "liner" })
-- hl.animation({ leaf = "fade", enabled = true, speed = 8, bezier = "default" })
-- hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "wind" })
-- hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 6, bezier = "default", style = "slidefadevert -50%" })

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
