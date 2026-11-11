--- @sync entry
local function entry(self, args)
	local h = cx.active.current.hovered
	if not h then
		return
	end

	local url = tostring(h.url)
	-- Remove file:// prefix if present
	url = url:gsub("^file://", "")
	local cmd = os.getenv("HOME") .. "/.local/bin/wallpaper '" .. url:gsub("'", "'\\''") .. "'"
	local ok, status = os.execute(cmd)
	if ya and ya.notify and (not ok or status ~= 0) then
		ya.notify({
			title = "Wallpaper",
			content = "Failed to set wallpaper",
			level = "error",
			timeout = 3,
		})
	elseif ya and ya.notify then
		ya.notify({
			title = "Wallpaper",
			content = "Set wallpaper",
			level = "info",
			timeout = 2,
		})
	end
end

return { entry = entry }
