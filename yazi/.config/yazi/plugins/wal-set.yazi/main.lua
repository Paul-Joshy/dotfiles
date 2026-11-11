--- @sync entry
local function entry()
	local tab = cx.active
	local hovered = tab.current.hovered
	if hovered then
		local path = tostring(hovered.url)
		-- Strip file://
		if path:sub(1,7) == "file://" then
			path = path:sub(8)
		end
		ya.emit("shell", { "$HOME/.local/bin/wallpaper-wal " .. ya.quote(path), block = true })
	end
end

return { entry = entry }
