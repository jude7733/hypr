local mainMod = "SUPER"

-- Programs
local terminal = "kitty"
local fileManager = "thunar"
local menu = "wofi --show drun"
local browser = "zen-browser"

----------------------
-- ### KEYBINDINGS ###
----------------------

-- Core
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("kitty --title 'yazi' -e 'yazi'"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("zen-browser"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = 0, action = "toggle" }))
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = 1, action = "toggle" }))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("[workspace 4;] kitty --title 'btop' -e 'btop'"))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("wlogout --protocol layer-shell"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exit())

-- Move focus
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Resize window
hl.bind(mainMod .. " + right", hl.dsp.window.resize({ x = 20, y = 0, relative = true }))
hl.bind(mainMod .. " + left", hl.dsp.window.resize({ x = -20, y = 0, relative = true }))
hl.bind(mainMod .. " + up", hl.dsp.window.resize({ x = 0, y = -20, relative = true }))
hl.bind(mainMod .. " + down", hl.dsp.window.resize({ x = 0, y = 20, relative = true }))

-- Move window
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.layout("swapcol l"))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Traverse workspace (Relative)
hl.bind("CTRL + ALT + right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("CTRL + ALT + left", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("CTRL + ALT + L", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("CTRL + ALT + H", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ workspace = "e+1" }))

-- Cycle tabs
hl.bind("ALT + TAB", hl.dsp.window.cycle_next())
hl.bind("ALT + TAB", hl.dsp.layout("cyclenext"))
hl.bind("ALT + TAB", hl.dsp.window.bring_to_top())

-- Workspace Overview (Hyprexpo)
hl.bind(mainMod .. " + TAB", hl.dsp.exec_cmd("hyprctl dispatch hyprexpo:expo toggle"))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Zoom in / out / reset
hl.bind(
	mainMod .. " + SHIFT + mouse_down",
	hl.dsp.exec_cmd(
		"hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.25')"
	)
)
hl.bind(
	mainMod .. " + SHIFT + mouse_up",
	hl.dsp.exec_cmd(
		"hyprctl keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq 'if (.float * 0.8) < 1 then 1 else (.float * 0.8) end')"
	)
)
hl.bind(mainMod .. " + SHIFT + mouse:274", hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor 1"))

-- Screenshots
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind(mainMod .. " + F12", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind(mainMod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + SHIFT + F12", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + ALT + PRINT", hl.dsp.exec_cmd("~/.config/hypr/scripts/ss-share.sh"))
hl.bind(mainMod .. " + ALT + F12", hl.dsp.exec_cmd("~/.config/hypr/scripts/ss-share.sh"))
hl.bind(mainMod .. " + CTRL + F12", hl.dsp.exec_cmd("slurp | grim -g - - | tesseract stdin stdout | wl-copy"))

-- Tesseract
hl.bind("SUPER + CTRL + PRINT", hl.dsp.exec_cmd("slurp | grim -g - - | tesseract stdin stdout | wl-copy"))

-- Clipboard
hl.bind(
	mainMod .. " + P",
	hl.dsp.exec_cmd(
		"cliphist list | wofi --dmenu --pre-display-cmd \"echo '%s' | cut -f 2\" | cliphist decode | wl-copy"
	)
)

-- Wallpaper
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("waypaper --random"))

-- GameMode
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("~/.config/hypr/scripts/gameMode.sh"))

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Media and Brightness
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("playerctl next"))

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
