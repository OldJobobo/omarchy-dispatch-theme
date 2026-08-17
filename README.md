# Omarchy Dispatch Theme

A tactical dark theme inspired by *Dispatch*: cold teal operations panels, warm sand-colored UI chrome, amber mission markers, and sharp rectangular surfaces. It sits between the quiet control room and the mess on the street—built for a desktop that feels like it is still on comms.

## Preview

![Dispatch lock screen preview](preview-unlock.png)

## Install

Use the Omarchy theme installer:

```bash
omarchy-theme-install https://github.com/OldJobobo/omarchy-dispatch-theme
```

## What's Included

- Quattro-native shell surfaces and a wallpaper-aware Hyprland presentation (`shell.toml`, `hyprland.lua`)
- Four adaptive Hyprland moods with coordinated borders, shadows, blur, and motion
- Omarchy 3.8 compatibility styling for Hyprland, Hyprlock, Waybar, Walker, mako, and SwayOSD
- Terminal palettes for Alacritty, Kitty, Ghostty, Foot, and Warp
- Supporting themes for GTK, Chromium, btop, Neovim/Aether, Zed, Vencord, Zellij, and VS Code
- A Base24 palette and matching lock-screen wordmark
- Twenty static wallpapers plus one optional animated wallpaper

## Adaptive Hyprland Moods

The Quattro Hyprland configuration follows the active wallpaper and selects one of four treatments:

- `ops` — cream HUD chrome and restrained command-center glass
- `night` — cyan focus, deeper blur, and broader separation from dark scenes
- `street` — amber focus, higher contrast, and faster directional motion
- `briefing` — muted rose chrome and steadier movement for team and interior shots

Automatic detection is enabled by default. To pin a treatment, set `wallpaper_mood` in `hyprland/dispatch/settings.lua` to `ops`, `night`, `street`, or `briefing`.

## Wallpapers

<table>
  <tr>
    <td><img src="backgrounds/01-ops-map-active.jpg" width="220" alt="Ops Map Active wallpaper" /><br><sub>Ops Map Active</sub></td>
    <td><img src="backgrounds/02-on-comms.jpg" width="220" alt="On Comms wallpaper" /><br><sub>On Comms</sub></td>
    <td><img src="backgrounds/03-grannys-donuts.jpg" width="220" alt="Granny's Donuts wallpaper" /><br><sub>Granny's Donuts</sub></td>
    <td><img src="backgrounds/04-hacking-grid.jpg" width="220" alt="Hacking Grid wallpaper" /><br><sub>Hacking Grid</sub></td>
  </tr>
  <tr>
    <td><img src="backgrounds/05-aerial-handoff.jpg" width="220" alt="Aerial Handoff wallpaper" /><br><sub>Aerial Handoff</sub></td>
    <td><img src="backgrounds/06-mech-hologram.jpg" width="220" alt="Mech Hologram wallpaper" /><br><sub>Mech Hologram</sub></td>
    <td><img src="backgrounds/07-ops-map-night.jpg" width="220" alt="Ops Map Night wallpaper" /><br><sub>Ops Map Night</sub></td>
    <td><img src="backgrounds/08-swingset.jpg" width="220" alt="Swingset wallpaper" /><br><sub>Swingset</sub></td>
  </tr>
  <tr>
    <td><img src="backgrounds/09-demon-alley.jpg" width="220" alt="Demon Alley wallpaper" /><br><sub>Demon Alley</sub></td>
    <td><img src="backgrounds/10-first-day.jpg" width="220" alt="First Day wallpaper" /><br><sub>First Day</sub></td>
    <td><img src="backgrounds/11-street-lamp.jpg" width="220" alt="Street Lamp wallpaper" /><br><sub>Street Lamp</sub></td>
    <td><img src="backgrounds/12-the-squeeze.jpg" width="220" alt="The Squeeze wallpaper" /><br><sub>The Squeeze</sub></td>
  </tr>
  <tr>
    <td><img src="backgrounds/13-ops-map-returning.jpg" width="220" alt="Ops Map Returning wallpaper" /><br><sub>Ops Map Returning</sub></td>
    <td><img src="backgrounds/14-late-night-brief.jpg" width="220" alt="Late Night Brief wallpaper" /><br><sub>Late Night Brief</sub></td>
    <td><img src="backgrounds/15-hazmat-crate.jpg" width="220" alt="Hazmat Crate wallpaper" /><br><sub>Hazmat Crate</sub></td>
    <td><img src="backgrounds/16-vending-machine.jpg" width="220" alt="Vending Machine wallpaper" /><br><sub>Vending Machine</sub></td>
  </tr>
  <tr>
    <td><img src="backgrounds/17-team-assembled.jpg" width="220" alt="Team Assembled wallpaper" /><br><sub>Team Assembled</sub></td>
    <td><img src="backgrounds/18-break-room.jpg" width="220" alt="Break Room wallpaper" /><br><sub>Break Room</sub></td>
    <td><img src="backgrounds/19-torrance-tribune.jpg" width="220" alt="Torrance Tribune wallpaper" /><br><sub>Torrance Tribune</sub></td>
    <td><img src="backgrounds/20-cast-ensemble.png" width="220" alt="Cast Ensemble wallpaper" /><br><sub>Cast Ensemble</sub></td>
  </tr>
</table>

The pack also includes `backgrounds/with-the-boys-dispatch.3840x2160.mp4` as an optional animated wallpaper for third-party wallpaper tooling.

## Requirements

- Omarchy 4.0 for the Quattro shell and adaptive Lua-based Hyprland treatment
- `GeistMono Nerd Font Propo` for the intended typography
- `Yaru-prussiangreen-dark` for the configured icon theme

Omarchy 3.8 compatibility files are retained for the equivalent legacy surfaces.

## Notes

- The Vencord theme imports [Midnight Discord](https://github.com/refact0r/midnight-discord) and requires a client that supports custom Discord themes.
- The bundled VS Code extension and other optional app integrations may require manual installation or activation; Omarchy does not automatically consume every extra file in a theme directory.
- The animated wallpaper is intentionally optional and is not selected by stock Omarchy wallpaper rotation.

## Attribution

- Inspired by the visual language, characters, and environments of *Dispatch* by AdHoc Studio
- Vencord styling is layered on [Midnight Discord](https://github.com/refact0r/midnight-discord)
- Neovim integration uses [Aether](https://github.com/bjarneo/aether.nvim)
