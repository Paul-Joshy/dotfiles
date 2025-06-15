local M = {}

local function trim(s)
  return s:match("^%s*(.-)%s*$")
end

local function strip_bullet(s)
  return s:gsub("^%s*[-*]%s*", "")
end

function M.import_visual()
  -- Prompt for project
  local project = vim.fn.input("TaskWarrior project (default: personal): ")
  if project == "" then project = "personal" end

  -- Get full visual lines
  local start_pos = vim.fn.getpos("'<")[2]
  local end_pos = vim.fn.getpos("'>")[2]
  local lines = vim.fn.getline(start_pos, end_pos)

  local count = 0
  for _, line in ipairs(lines) do
    local desc = trim(strip_bullet(line))
    if desc ~= "" then
      vim.fn.system(string.format("task add project:%s \"%s\"", project, desc))
      count = count + 1
    end
  end

  vim.notify(string.format("Imported %d tasks to project '%s'", count, project))
end

return M
