--- @sync entry
local function entry()
	local h = (cx.active or cx.tab).current.hovered
	if not h then
		return ya.notify({ title = "Wallpaper", content = "No file", timeout = 2 })
	end
	local path = tostring(h.url):gsub("^file://", "")
	os.execute(string.format("%s/.local/bin/wallpaper-wal %q", os.getenv("HOME"), path))
	ya.notify({ title = "Wallpaper+Pywal", content = "Done", timeout = 2 })
end

return { entry = entry }
