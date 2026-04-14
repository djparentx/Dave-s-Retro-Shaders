Dave's Retro Shaders
by djparent

A RetroArch shader management tool for ArkOS and DarkOS handheld devices.

Provides a clean, controller-friendly menu to apply and remove curated shader presets per system — no manual file editing required.

Features

- Apply or remove shaders per system or all at once
- Two CRT styles:
    80’s Television (warm, curved)
    90’s Monitor (sharper, brighter)
- Handheld LCD shaders:
    Motion blur
    Subpixel layout
    DMG palette (Game Boy)
- Game Boy overlay:
    Custom 4K-resolution bezel
- Multilingual support (auto-detected from EmulationStation):
    English, Français, Español, Português, Italiano, Deutsch, Polski
- Self-installing:
    Deploys required shader and overlay files on first run
- Legacy cleanup:
    Removes old shader presets from previous versions
- Fully gamepad navigable:
    X / Y buttons toggle checklist items

Supported Systems:

Handhelds:

- Nintendo Game Boy
    - DMG palette + LCD grid + motion blur
- Nintendo Game Boy Color
    - LCD grid + subpixel color + motion blur
- Nintendo Game Boy Advance
    - LCD grid + GBA color correction + motion blur
- SEGA Game Gear
    - LCD grid + color correction + motion blur
- NeoGeo Pocket
    - LCD grid + motion blur
- NeoGeo Pocket Color
    - LCD grid + subpixel color + motion blur
- WonderSwan Color
    - LCD grid + color correction
- Atari Lynx
    - LCD grid + color correction + motion blur

Consoles (all use selectable CRT style):

- Arcade / MAME
- Atari 2600 / 5200 / 7800
- CAPCOM CPS I / II / III
- Nintendo Entertainment System
- Super Nintendo
- SEGA SG-1000
- SEGA Master System
- SEGA Mega Drive
- SEGA CD
- SEGA 32X
- PC Engine
- PC Engine CD
- NeoGeo
- NeoGeo CD

CRT Styles:

80’s Television:
Shader:  crt-retro.glslp
Features:
  - Warm tone
  - Scanlines
  - Bloom/glow
  - Color bleed
  - Screen curvature

90’s Monitor:
Shader:  monitor-retro.glslp
Features:
  - Sharper image
  - Brighter output
  - Arcade/monitor-style presentation

- Selected style is shown in the main menu
- Changing style and reapplying shaders overwrites existing presets


How It Works:

First Run

- Checks if shader files are installed
- If not, installer will:
    - Copy shader presets to:
    ~/.config/retroarch/shaders/
    - Write full CRT shader pipeline:
        - convergence
        - linearize
        - glow X/Y
        - CRT-consumer
    - Create Game Boy overlay:
        - config file + PNG bezel
    - Remove legacy shader files
    - Set correct file ownership

Applying Shaders

- Writes .glslp file to:
  ~/.config/retroarch/config/<CoreName>/
  RetroArch loads shaders automatically per core
- Writes overlay .cfg when applicable

Removing Shaders

- Deletes .glslp (and .cfg if present)
- Restores default RetroArch behavior

CRT Style Handling

- Style is set before writing console shaders
- Reapplying shaders updates all configs with the selected style

Installation:

- Copy script to device (via Samba or SSH)

Make executable:

- chmod +x Dave_s_Retro_Shaders.sh

Launch:

- From Ports / Tools menu in EmulationStation
- Or run directly in terminal
- Script will request root privileges if needed

Requirements:

- ArkOS or DarkOS (RK3326 devices)
- Examples: R36S, RG351MP, Odroid-Go Advance
- RetroArch (standard install paths)

Required tools:

dialog
gptokeyb
setfont

File Locations:

Shader presets:
~/.config/retroarch/shaders/
Core shader configs
~/.config/retroarch/config/<CoreName>/
32-bit core configs
~/.config/retroarch32/config/<CoreName>/
Game Boy overlay
~/.config/retroarch/overlay/
