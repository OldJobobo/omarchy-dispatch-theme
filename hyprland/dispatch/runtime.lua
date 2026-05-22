local M = {}

local active_mood_name = nil

local function mood_name_for_background(settings, moods, wallpaper_moods, wallpaper, path)
	if settings.wallpaper_mood ~= "auto" then
		-- Fixed moods are useful while tuning one look across many wallpapers.
		return moods[settings.wallpaper_mood] and settings.wallpaper_mood or settings.fallback_mood
	end

	return wallpaper_moods[wallpaper.basename(path) or ""] or settings.fallback_mood
end

local function refresh_mood(settings, moods, wallpaper_moods, wallpaper, apply)
	local next_mood_name = mood_name_for_background(
		settings,
		moods,
		wallpaper_moods,
		wallpaper,
		wallpaper.current_background()
	)

	if next_mood_name ~= active_mood_name then
		-- Store the requested name, not the resolved fallback, so unknown names do
		-- not repeatedly reapply the same fallback on every timer tick.
		active_mood_name = next_mood_name

		-- Avoid reapplying hl.config every poll; only update on mood changes.
		apply.apply_mood(moods, settings.fallback_mood, next_mood_name)
	end
end

function M.start(settings, moods, wallpaper_moods, wallpaper, apply)
	local function refresh()
		refresh_mood(settings, moods, wallpaper_moods, wallpaper, apply)
	end

	refresh()

	if settings.wallpaper_mood == "auto" then
		if _G.dispatchMoodTimer then
			-- Hyprland reloads this Lua file in-process; keep only one watcher.
			pcall(function()
				_G.dispatchMoodTimer:set_enabled(false)
			end)
		end

		_G.dispatchMoodTimer = hl.timer(refresh, {
			timeout = settings.poll_interval_ms,
			type = "repeat",
		})
	end
end

return M
