-- Each mood describes the whole focused-window treatment for one wallpaper
-- family: chrome color, shadow shape, glass tuning, and motion language.
--
-- Tuning notes:
--   border.active is the main readable signal; keep it high contrast.
--   shadow alpha/range changes the perceived glow more than render_power.
--   blur.brightness below 0.8 makes panels feel heavier and more nocturnal.
--   blur.vibrancy above ~0.4 gets colorful fast, especially over street shots.
--   motion should stay directional; Dispatch should feel like panels moving.
return {
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

	-- Character/team/interior shots: muted rose chrome and steadier motion.
	briefing = {
		border = {
			-- Rose separates briefing from the cream ops frame while staying
			-- warmer and more conversational than the night cyan.
			active = "rgb(c44b8f)",
			inactive = "rgba(c44b8f44)",
		},
		shadow = {
			-- Briefing uses contact depth, not a colored halo. Keep the shadow
			-- dark and tight so warm interior wallpapers do not bloom.
			active = "rgba(141d2338)",
			inactive = "rgba(141d2318)",
			range = 6,
			render_power = 4,
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
