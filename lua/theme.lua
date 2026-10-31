local M = {}

function M.load_wal()
	local home = os.getenv("HOME")
	local f = io.open(home .. "/.cache/wal/colors-hyprland.conf", "r")
	if not f then
		-- Fallback to common path
		f = io.open(home .. "/.cache/wal/hyprland.conf", "r")
	end

	if not f then
		return {}
	end

	local colors = {}
	for line in f:lines() do
		local name, val = line:match("%$([%w%d_]+)%s*=%s*(.+)")
		if name and val then
			-- Remove any trailing comments
			val = val:gsub("%s*#.*", "")
			colors[name] = val
		end
	end
	f:close()
	return colors
end

return M
