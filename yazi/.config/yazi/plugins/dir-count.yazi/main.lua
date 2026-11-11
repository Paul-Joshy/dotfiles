-- dir-count.yazi
-- Show the number of files inside each folder on the right side of the file
-- list, next to the size of regular files (set `linemode = "size_count"` in
-- yazi.toml).
--
-- Counts are collected by a small background shell worker that writes
-- `count<TAB>path` lines to a temp file, so Yazi never blocks, even on slow
-- mounts. Workers are kicked off when the list changes and lazily from
-- rendering via the event loop, which is what counts the very first
-- directory right after startup.

--- Drop the cached counts for the direct children of the current directory.
--- Sync context only.
local refresh = ya.sync(function(st)
	if cx == nil then
		return
	end

	local cwd = tostring(cx.active.current.cwd)
	if cwd:sub(-1) ~= "/" then
		cwd = cwd .. "/"
	end

	for url in pairs(st.counts) do
		if url:sub(1, #cwd) == cwd and not url:find("/", #cwd + 1, true) then
			st.counts[url] = nil
		end
	end
end)

--- Spawn a worker for the subfolders of the current directory that haven't
--- been counted yet. Sync context only.
local sweep = ya.sync(function(st)
	if st.worker or cx == nil then
		return
	end

	local urls = {}
	for _, f in ipairs(cx.active.current.files) do
		local url = tostring(f.url):gsub("/+$", "")
		if f.cha.is_dir and st.counts[url] == nil then
			urls[#urls + 1] = url
		end
	end
	if #urls == 0 then
		return
	end

	st.sweep_seq = (st.sweep_seq or 0) + 1
	local out = (os.getenv("TMPDIR") or "/tmp")
		.. "/yazi-dir-count." .. ya.hash(urls[1]) .. "." .. st.sweep_seq .. ".out"

	local f = io.open(out .. ".urls", "w")
	for _, url in ipairs(urls) do
		f:write(url, "\n")
	end
	f:close()

	-- `n` is the number of direct children (hidden items included). The final
	-- DONE line tells the harvester the worker is complete.
	local s = io.open(out .. ".sh", "w")
	s:write(
		"out=", ya.quote(out), "\n",
		'while IFS= read -r d || [ -n "$d" ]; do\n',
		'  n=$(/bin/ls -1A "$d" 2>/dev/null | /usr/bin/wc -l | /usr/bin/tr -d " ")\n',
		'  printf \'%s\\t%s\\n\' "$n" "$d" >> "$out"\n',
		"done < ", ya.quote(out .. ".urls"), "\n",
		'echo DONE >> "$out"\n'
	)
	s:close()

	st.worker = out
	st.deadline = ya.time() + 30 -- hidden worker got lost, respin after this
	os.execute("/bin/sh " .. ya.quote(out .. ".sh") .. " >/dev/null 2>&1 &")
end)

--- Merge the worker's output into the counts; clears st.worker once DONE.
--- Sync context only; must not call other ya.sync functions, keep it flat.
local harvest = ya.sync(function(st)
	local work = st.worker
	if not work then
		return true
	end

	local h = io.open(work)
	if not h then
		-- Either the worker is starting up or it got lost; after the deadline
		-- release the slot so sweeps can continue.
		if ya.time() > (st.deadline or 0) then
			os.remove(work)
			os.remove(work .. ".urls")
			os.remove(work .. ".sh")
			st.worker = nil
		end
		return false
	end

	local patch, finished = {}, false
	for line in h:lines() do
		if line == "DONE" then
			finished = true
			break
		end
		local n, url = line:match("^(%d+)\t(.*)$")
		if n and url and url:sub(1, 1) == "/" then
			patch[url] = tonumber(n)
		end
	end
	h:close()

	-- Merging before DONE is safe: a count is final as soon as its line has
	-- been written.
	for url, count in pairs(patch) do
		st.counts[url] = count or false -- `false` marks unreadable folders, so they aren't retried
	end

	if finished then
		os.remove(work)
		os.remove(work .. ".urls")
		os.remove(work .. ".sh")
		st.worker = nil
	end
	if next(patch) then
		ui.render()
	end
	return finished
end)

--- Harvest a running worker, or start a new sweep if none. Sync context.
local react = ya.sync(function(st)
	if st.worker then
		harvest()
	else
		sweep()
	end
end)

-- Reacts to state changes: harvest a running worker, or start a new sweep.
-- Deferred to the event loop with ya.emit, so it is safe to call from
-- rendering. The frequent `hover` events usually get there first; this
-- mostly covers directory entry right after startup.

---@param st State
---@param opts Options
local function setup(st, opts)
	---@cast st State
	st.counts = {}
	st.worker = nil

	opts = opts or {}
	opts.empty_sign = opts.empty_sign or "0"

	-- Called by Linemode:solo() for every visible row, because yazi.toml
	-- sets `linemode = "size_count"`: folders show their file count, files
	-- show their size. Piggybacked on it is the render-hook kick that keeps
	-- sweeps alive while uncounted folders appear on screen.
	Linemode.size_count = function(self)
		local f = self._file
		if not f.in_current then
			return ""
		elseif f.cha.is_dir then
			local count = st.counts[tostring(f.url):gsub("/+$", "")]
			if count == nil and cx ~= nil then
				-- Uncounted dir on screen: keep the sweep chain alive. Each
				-- merge re-renders the list, which kicks again, until every
				-- dir has a count and the loop stops by itself.
				ya.emit("plugin", { "dir-count" })
			end
			if count then
				return count == 0 and opts.empty_sign or tostring(count)
			end
			-- Not counted yet: fall back to the entry of a folder you've visited
			local folder = cx.active:history(f.url)
			return folder and tostring(#folder.files) or ""
		elseif not f.cha.is_dummy then
			local size = f:size()
			return size and ya.readable_size(size) or ""
		end
		return ""
	end

	-- Harvest every time the cursor moves (this is what slots counts into
	-- the display while a worker drains), and recount/sweep whenever the
	-- list changes.
	ps.sub("hover", react)
	ps.sub("load", function()
		refresh()
		react()
	end)
	ps.sub("cd", function()
		refresh()
		react()
	end)
	ps.sub("delete", function()
		refresh()
		react()
	end)
	ps.sub("trash", function()
		refresh()
		react()
	end)
	ps.sub("move", function()
		refresh()
		react()
	end)
	ps.sub("rename", function()
		refresh()
		react()
	end)
end

--- Deferred sweep entry point for `plugin dir-count`.
local function entry()
	react()
end

return { setup = setup, entry = entry }
