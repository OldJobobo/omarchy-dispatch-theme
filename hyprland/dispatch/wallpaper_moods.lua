-- Wallpaper filenames are intentionally grouped by visual mood, not by numeric
-- order. Moving a filename here changes which mood auto mode chooses.
--
-- This is deliberately not image analysis. Filename mapping is predictable,
-- cheap, and safe inside a theme file.
--
-- If a wallpaper "looks wrong", change its value here first. Only change the
-- mood tables when the whole mood family needs different treatment.
return {
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
