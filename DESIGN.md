# Dispatch — Theme Design Document

## Concept

Based on the game *Dispatch*. The primary reference is the tactical operations map screen — dark teal city grid, cyan wireframe buildings, warm tan/gold UI chrome — the room where someone is running the operation. Layered against that is the street level: amber-lit diners, blood, rain, pulpy anime violence.

The theme lives in the tension between those two spaces. You're on comms between the cold HQ and the warm street. Neither fully wins.

---

## Design Language

**Field & HQ Split** — cold tactical base, warm ambient accents.

- The background and structural surfaces read as the ops room: deep navy, dark teal panels
- The text and UI chrome reads as the tan/sand of the HQ display borders
- Amber/orange is the primary accent — street-level warmth bleeding into the terminal, mission markers, retro fill color
- Teal is the tactical relief — map wireframes, data highlights, cool counterpoint to the amber
- Purple is present but quiet — a character color (jacket, neon), not a room color
- Red is hard alarm only — danger, errors, blood
- Pink/magenta is street texture — a secondary character note, not structural

---

## Color Roles

| Role | Hex | Usage |
|---|---|---|
| Background | `#141d23` | Base surface, ops room dark |
| Foreground | `#b69f80` | Primary text, warm readable UI text |
| Muted Chrome | `#8a7b68` | Subdued tan borders, inactive chrome, secondary labels |
| Amber | `#e6c93a` | Primary accent, mission markers, retro fills |
| Teal | `#63bba5` | Tactical highlights, data, cool relief |
| Teal Dark | `#255051` | Deep surface panels, HUD backgrounds |
| Teal Light | `#93c5b3` | Bright data, active indicators |
| Cream | `#d8c7b0` | Bright foreground, high-contrast labels |
| Purple | `#7c49e0` | Secondary accent, character color |
| Pink | `#c44b8f` | Street texture accent |
| Red | `#d61f20` | Alarm, error, danger only |

---

## Typography

- **Preferred font**: GeistMono Nerd Font Propo
- Pure geometric sans-serif, no pseudo-serifs — matches the clean rectangular language of the game UI
- Use across terminals, Waybar, and any UI surface where font is configurable

---

## Surface Rules

### Terminal (foot, alacritty, kitty, ghostty)
- Background: `#141d23`
- Foreground: `#b69f80`
- Amber (`#e6c93a`) as selection and cursor highlight
- Teal as syntax/data color

### SwayOSD
- Background: deep teal — `#255051`
- Foreground: bright cyan — `#93c5b3`
- Border: tan — `#8a7b68`
- Progress fill: amber — `#e6c93a` — retro terminal bar, warm against the cold panel

### Waybar
- Base bar: near-black with teal undertone
- Active/focused: amber
- Indicators and clocks: tan foreground, teal on data modules

### Notifications (mako)
- Background: dark navy
- Border: tan for info, amber for warnings, red for urgent
- Text: cream on dark

### Hyprland

**Borders**
The border is the primary windowing signal — it should read as HQ display chrome, the same tan/cream frame language as the ops map UI.

- Active border: cream `#d8c7b0` — bright, high-contrast, the lit edge of a focused panel. Currently set in `hyprland.conf`.
- Inactive border: tan `#8a7b68` with transparency (`bb`) — recedes into the background, present but not competing
- Border size: 5 — chunky enough to feel like a physical frame, consistent with the game's panel aesthetic
- Group borders follow the same active/inactive split

Amber `#e6c93a` is an alternative for active if more visual punch is wanted — it reads more "alert" than "chrome". Current cream is the calmer, more HQ-aligned choice.

**Decorations**
- Rounding: 0 — the game UI is all hard rectangular panels, no softening.
- Shadows: subtle, teal-tinted (`#255051` base) — gives windows the floating panel quality of the ops HUD without heavy drop shadows
- Blur: optional but appropriate — frosted glass reads as a layered HUD surface, consistent with the tactical map overlays

**Animations**
Keep animations crisp and directional — nothing bouncy or organic. The ops room doesn't have personality animations. Slide or fade transitions at moderate speed. Window open/close should feel like a panel engaging, not a window bouncing into place.

---

## Wallpaper Direction

Reference images establish two moods — the street (warm amber, rain, action) and the ops map (cold teal, isometric, clinical). Final wallpapers should lean ops-map: top-down city grid aesthetic, dark teal with cyan outlines, possibly with warm amber light sources bleeding in from below. The current reference shots are character/action stills and won't land as desktop wallpapers — need something with more negative space and the right tonal balance.

---

## What to Avoid

- Don't let purple dominate — it's a supporting color pulled from character design, not the environment
- Don't go full monochrome teal — the amber tension is what makes this distinct from a straight terminal theme
- Keep red rare — it should only appear where something is actually wrong
