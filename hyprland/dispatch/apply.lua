local M = {}

-- Static visual configuration can be changed at runtime with hl.config().
function M.apply_config(mood)
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
function M.apply_motion(mood)
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

function M.apply_mood(moods, fallback_mood, mood_name)
	local mood = moods[mood_name] or moods[fallback_mood]
	M.apply_config(mood)
	M.apply_motion(mood)
end

return M
