local function shell_quote(value)
	-- Only used for simple one-argument shell commands. Keep commands built
	-- with this helper narrow and avoid piping untrusted strings through sh.
	return "'" .. tostring(value):gsub("'", [['"'"']]) .. "'"
end

-- Hyprland Lua does not expose the wallpaper directly, so auto mode reads the
-- small amount of shell/system state needed to identify the active background.
local function read_command(command)
	local handle = io.popen(command)
	if not handle then
		return nil
	end

	local output = handle:read("*a")
	handle:close()
	return output ~= "" and output or nil
end

local function basename(path)
	return path and path:match("([^/]+)$") or nil
end

local function resolve_path(path)
	if not path or path == "" then
		return nil
	end

	-- Resolve symlinks like ~/.config/omarchy/current/background so basename()
	-- sees the actual wallpaper file, not just "background".
	local command = "readlink -f " .. shell_quote(path) .. " 2>/dev/null"
	local resolved = read_command(command)
	return (resolved and resolved:match("([^\n]+)")) or path
end

local function path_exists(path)
	if not path or path == "" then
		return false
	end

	local file = io.open(path, "r")
	if file then
		file:close()
		return true
	end

	return false
end

local function resolve_existing_path(path)
	local resolved = resolve_path(path)
	return path_exists(resolved) and resolved or nil
end

local function swaybg_background()
	-- Omarchy and JoboWalls both end up launching swaybg for static wallpapers.
	-- Reading the live process catches cases where their state files disagree.
	local processes = read_command("pgrep -af swaybg 2>/dev/null")
	if not processes then
		return nil
	end

	-- Prefer the last matching process; newer swaybg launches usually win.
	-- The first pattern captures paths containing spaces when followed by -m.
	local path = nil
	for line in processes:gmatch("[^\n]+") do
		path = line:match("%s%-i%s+(.+)%s%-m%s+") or line:match("%s%-i%s+(.+)$") or path
	end

	return resolve_existing_path(path)
end

local function jobowalls_background()
	-- JoboWalls records the selected wallpaper here, but its PID/state can go
	-- stale, so this remains a fallback behind the live swaybg process.
	local file = io.open((os.getenv("HOME") or "") .. "/.local/state/jobowalls/state.json", "r")
	if not file then
		return nil
	end

	local state = file:read("*a")
	file:close()

	return resolve_existing_path(state and state:match([["wallpaper"%s*:%s*"([^"]+)"]]))
end

local function omarchy_background()
	-- Quattro moved current theme state under ~/.local/state/omarchy. Keep the
	-- older ~/.config/omarchy/current path as a fallback for Omarchy 3.8.x.
	local home = os.getenv("HOME") or ""
	return resolve_existing_path(home .. "/.local/state/omarchy/current/background")
		or resolve_existing_path(home .. "/.config/omarchy/current/background")
end

local function current_background()
	-- Order matters: the running compositor wallpaper process is the closest
	-- truth; JoboWalls and Omarchy files are fallbacks that can drift.
	return swaybg_background() or jobowalls_background() or omarchy_background()
end

return {
	basename = basename,
	current_background = current_background,
}
