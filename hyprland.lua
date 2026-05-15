-- Dispatch Hyprland theme.
--
-- The theme can either use a fixed mood or infer one from the active
-- wallpaper. Auto mode checks the real wallpaper process first, then falls
-- back through JoboWalls and Omarchy state.

local wallpaper_mood = "auto"
local fallback_mood = "ops"
local poll_interval_ms = 1500

-- Set wallpaper_mood to "ops", "night", "street", or "briefing" to pin one
-- treatment while tuning. Leave it as "auto" for wallpaper-aware switching.
--
-- Colors use Hyprland's rgb()/rgba() strings. rgba() is RRGGBBAA, so the last
-- two hex digits are alpha: 22 is subtle, 55 is visible, aa is strong.

-- Each mood describes the whole focused-window treatment for one wallpaper
-- family: chrome color, shadow shape, glass tuning, and motion language.
--
-- Tuning notes:
--   border.active is the main readable signal; keep it high contrast.
--   shadow alpha/range changes the perceived glow more than render_power.
--   blur.brightness below 0.8 makes panels feel heavier and more nocturnal.
--   blur.vibrancy above ~0.4 gets colorful fast, especially over street shots.
--   motion should stay directional; Dispatch should feel like panels moving.
local moods = {
	-- Cold tactical map screens: cream HUD chrome over smoked blue-green glass.
	ops = {
		border = {
			-- Active border should stay calmer than amber here; it reads as HQ
			-- display trim instead of an alert state.
			active = "rgb(d8c7b0)",
			inactive = "rgba(8a7b68bb)",
		},
		shadow = {
			-- Teal-tinted depth without turning every focused window into a glow.
			active = "rgba(25505166)",
			inactive = "rgba(25505133)",
			range = 8,
			render_power = 3,
		},
		blur = {
			-- Calm command-center glass: dark enough for terminal readability.
			size = 8,
			passes = 2,
			noise = 0.02,
			brightness = 0.85,
			contrast = 0.78,
			vibrancy = 0.16,
			vibrancy_darkness = 0.22,
			popups_ignorealpha = 0.78,
		},
		motion = {
			-- Straight slide keeps the ops-map mood procedural and mechanical.
			window = "slide",
			window_out = "slide",
			workspace = "slide",
			window_speed = 3,
			workspace_speed = 4,
		},
	},

	-- Late-night map and streetlamp shots: deeper blur and cyan focus.
	night = {
		border = {
			active = "rgb(93c5b3)",
			inactive = "rgba(255051aa)",
		},
		shadow = {
			-- Broader than ops because night scenes need more separation from
			-- dark wallpaper material. Alpha stays restrained.
			active = "rgba(63bba555)",
			inactive = "rgba(141d2333)",
			range = 14,
			render_power = 3,
		},
		blur = {
			-- Night scenes can take a larger blur radius and more darkness.
			size = 10,
			passes = 3,
			noise = 0.015,
			brightness = 0.74,
			contrast = 0.9,
			vibrancy = 0.28,
			vibrancy_darkness = 0.45,
			popups_ignorealpha = 0.72,
		},
		motion = {
			-- slidefade gives workspace moves a softer night-shift feel without
			-- using bounce/spring motion.
			window = "slide",
			window_out = "slide",
			workspace = "slidefade 18%",
			window_speed = 3.4,
			workspace_speed = 4.5,
		},
	},

	-- Warm street/action shots: amber focus, higher contrast, contained shadow.
	street = {
		border = {
			-- Amber is intentionally loud here; shadow is kept short to prevent
			-- the whole desktop from reading as orange.
			active = "rgb(e6c93a)",
			inactive = "rgba(8a7b68bb)",
		},
		shadow = {
			-- Keep this short; amber bloom becomes loud very quickly.
			active = "rgba(f096312e)",
			inactive = "rgba(25505122)",
			range = 7,
			render_power = 3,
		},
		blur = {
			-- Warmer and punchier than ops, but not full neon glass.
			size = 7,
			passes = 2,
			noise = 0.035,
			brightness = 0.9,
			contrast = 1.08,
			vibrancy = 0.42,
			vibrancy_darkness = 0.18,
			popups_ignorealpha = 0.82,
		},
		motion = {
			-- Pop-in suits street/action stills, but keep percentages high so
			-- windows do not feel like they jump from tiny thumbnails.
			window = "popin 92%",
			window_out = "slide bottom",
			workspace = "slidefade 22%",
			window_speed = 3.8,
			workspace_speed = 4.8,
		},
	},

	-- Character/team/interior shots: quieter tan chrome and steadier motion.
	briefing = {
		border = {
			-- Cream/tan keeps team and interior shots readable without pushing
			-- danger/alert semantics.
			active = "rgb(cdb79c)",
			inactive = "rgba(8a7b68cc)",
		},
		shadow = {
			-- Moderate framed-panel depth. This should feel like room lighting,
			-- not a HUD glow.
			active = "rgba(d8c7b044)",
			inactive = "rgba(8a7b6822)",
			range = 10,
			render_power = 3,
		},
		blur = {
			-- Interior/team shots should recede behind text and window chrome.
			size = 9,
			passes = 2,
			noise = 0.01,
			brightness = 0.75,
			contrast = 0.84,
			vibrancy = 0.1,
			vibrancy_darkness = 0.28,
			popups_ignorealpha = 0.76,
		},
		motion = {
			-- Slower, steadier movement keeps briefing/interior wallpapers from
			-- feeling like combat/action scenes.
			window = "popin 96%",
			window_out = "popin 96%",
			workspace = "slide",
			window_speed = 2.8,
			workspace_speed = 3.6,
		},
	},
}

-- Wallpaper filenames are intentionally grouped by visual mood, not by numeric
-- order. Moving a filename here changes which mood auto mode chooses.
--
-- This is deliberately not image analysis. Filename mapping is predictable,
-- cheap, and safe inside a theme file.
--
-- If a wallpaper "looks wrong", change its value here first. Only change the
-- mood tables when the whole mood family needs different treatment.
local wallpaper_moods = {
	["01-ops-map-active.jpg"] = "ops",
	["04-hacking-grid.jpg"] = "ops",
	["05-aerial-handoff.jpg"] = "ops",
	["06-mech-hologram.jpg"] = "ops",
	["13-ops-map-returning.jpg"] = "ops",

	["07-ops-map-night.jpg"] = "night",
	["11-street-lamp.jpg"] = "night",
	["14-late-night-brief.jpg"] = "night",

	["03-grannys-donuts.jpg"] = "street",
	["08-swingset.jpg"] = "street",
	["09-demon-alley.jpg"] = "street",
	["10-first-day.jpg"] = "briefing",
	["12-the-squeeze.jpg"] = "briefing",
	["15-hazmat-crate.jpg"] = "street",
	["16-vending-machine.jpg"] = "street",
	["19-torrance-tribune.jpg"] = "briefing",

	["02-on-comms.jpg"] = "briefing",
	["17-team-assembled.jpg"] = "briefing",
	["18-break-room.jpg"] = "briefing",
	["20-cast-ensemble.png"] = "briefing",
}

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

	return resolve_path(path)
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

	return state and state:match([["wallpaper"%s*:%s*"([^"]+)"]]) or nil
end

local function omarchy_background()
	-- Stock Omarchy background switching maintains this symlink. It is the
	-- final fallback because JoboWalls can render a different image.
	local home = os.getenv("HOME") or ""
	return resolve_path(home .. "/.config/omarchy/current/background")
end

local function current_background()
	-- Order matters: the running compositor wallpaper process is the closest
	-- truth; JoboWalls and Omarchy files are fallbacks that can drift.
	return swaybg_background() or jobowalls_background() or omarchy_background()
end

local function mood_name_for_background(path)
	if wallpaper_mood ~= "auto" then
		-- Fixed moods are useful while tuning one look across many wallpapers.
		return moods[wallpaper_mood] and wallpaper_mood or fallback_mood
	end

	return wallpaper_moods[basename(path) or ""] or fallback_mood
end

local active_mood_name = nil

-- Static visual configuration can be changed at runtime with hl.config().
local function apply_config(mood)
	hl.config({
		general = {
			-- Border/gap values are intentionally mood-invariant; the mood
			-- changes color and depth, not the core window geometry.
			border_size = 5,
			gaps_in = 10,
			gaps_out = 20,
			col = {
				active_border = mood.border.active,
				inactive_border = mood.border.inactive,
			},
		},

		decoration = {
			rounding = 0,
			blur = {
				-- These keys are Hyprland 0.55 Lua config names. Keep snake_case
				-- fields like vibrancy_darkness and popups_ignorealpha as-is.
				enabled = true,
				size = mood.blur.size,
				passes = mood.blur.passes,
				noise = mood.blur.noise,
				brightness = mood.blur.brightness,
				contrast = mood.blur.contrast,
				vibrancy = mood.blur.vibrancy,
				vibrancy_darkness = mood.blur.vibrancy_darkness,
				new_optimizations = true,
				popups = true,
				popups_ignorealpha = mood.blur.popups_ignorealpha,
				special = true,
				xray = false,
			},
			shadow = {
				-- render_power controls falloff shape. Keep it >= 3 by preference;
				-- use range and alpha for most day-to-day tuning.
				enabled = true,
				range = mood.shadow.range,
				render_power = mood.shadow.render_power,
				color = mood.shadow.active,
				color_inactive = mood.shadow.inactive,
			},
		},

		animations = {
			enabled = true,
		},

		group = {
			col = {
				border_active = mood.border.active,
				border_inactive = mood.border.inactive,
			},
		},
	})
end

-- Animation leaves are set separately so the mood table stays semantic.
local function apply_motion(mood)
	hl.animation({
		-- "windows" is the parent leaf for open/move behavior unless a more
		-- specific leaf overrides it.
		leaf = "windows",
		enabled = true,
		speed = mood.motion.window_speed,
		bezier = "dispatch",
		style = mood.motion.window,
	})

	hl.animation({
		-- Closing can be more directional than opening; street uses bottom exit.
		leaf = "windowsOut",
		enabled = true,
		speed = 2,
		bezier = "dispatch",
		style = mood.motion.window_out,
	})

	hl.animation({
		-- Fade stays shared so opacity changes do not compete with mood motion.
		leaf = "fade",
		enabled = true,
		speed = 3,
		bezier = "dispatch",
	})

	hl.animation({
		-- Workspace motion is where the wallpaper mood is most noticeable.
		leaf = "workspaces",
		enabled = true,
		speed = mood.motion.workspace_speed,
		bezier = "dispatch",
		style = mood.motion.workspace,
	})
end

local function apply_mood(mood_name)
	local mood = moods[mood_name] or moods[fallback_mood]

	-- Store the requested name, not the resolved fallback, so unknown names do
	-- not repeatedly reapply the same fallback on every timer tick.
	active_mood_name = mood_name
	apply_config(mood)
	apply_motion(mood)
end

local function refresh_mood()
	local next_mood_name = mood_name_for_background(current_background())
	if next_mood_name ~= active_mood_name then
		-- Avoid reapplying hl.config every poll; only update on mood changes.
		apply_mood(next_mood_name)
	end
end

-- Shared curve for Dispatch panel motion: crisp, directional, not bouncy.
hl.curve("dispatch", { type = "bezier", points = { { 0.25, 0.1 }, { 0.25, 1.0 } } })

refresh_mood()

if wallpaper_mood == "auto" then
	if _G.dispatchMoodTimer then
		-- Hyprland reloads this Lua file in-process; keep only one watcher.
		pcall(function()
			_G.dispatchMoodTimer:set_enabled(false)
		end)
	end

	_G.dispatchMoodTimer = hl.timer(refresh_mood, {
		timeout = poll_interval_ms,
		type = "repeat",
	})
end
