-- Dispatch Hyprland theme.
--
-- The theme can either use a fixed mood or infer one from the active
-- wallpaper. Auto mode checks the real wallpaper process first, then falls
-- back through JoboWalls and Omarchy state.

-- Set wallpaper_mood in hyprland/dispatch/settings.lua to "ops", "night",
-- "street", or "briefing" to pin one treatment while tuning. Leave it as
-- "auto" for wallpaper-aware switching.
--
-- Colors use Hyprland's rgb()/rgba() strings. rgba() is RRGGBBAA, so the last
-- two hex digits are alpha: 22 is subtle, 55 is visible, aa is strong.

local source = debug.getinfo(1, "S").source
local theme_dir = source:sub(1, 1) == "@" and (source:sub(2):match("(.*/)") or "") or nil
if theme_dir then
	package.path = theme_dir .. "hyprland/?.lua;" .. theme_dir .. "hyprland/?/init.lua;" .. package.path
end

for name in pairs(package.loaded) do
	if name:match("^dispatch%.") then
		package.loaded[name] = nil
	end
end

local settings = require("dispatch.settings")
local moods = require("dispatch.moods")
local wallpaper_moods = require("dispatch.wallpaper_moods")
local wallpaper = require("dispatch.wallpaper")
local apply = require("dispatch.apply")
local runtime = require("dispatch.runtime")

-- Shared curve for Dispatch panel motion: crisp, directional, not bouncy.
hl.curve("dispatch", { type = "bezier", points = { { 0.25, 0.1 }, { 0.25, 1.0 } } })

runtime.start(settings, moods, wallpaper_moods, wallpaper, apply)
