--- @sync entry
local function entry()
	ya.notify({ title = "Debug", content = "Plugin works", timeout = 2 })
end

return { entry = entry }
