# Dave's Retro Shaders (R36S)

v1.3 by djparent

A RetroArch shader management tool for the R36S, designed for ArkOS and dArkOS, providing an easy, controller-friendly way to apply and manage curated shader presets per system.

---

## Overview

This script simplifies shader management on the R36S by eliminating manual configuration and providing a clean menu interface to apply or remove shaders across supported systems.

It includes curated presets designed to enhance visuals while maintaining performance on RK3326 hardware.

---

## Features

- B button now functions as back button
- Apply or remove shaders per system or globally
- Two CRT styles:
  - 80’s Television (warm, curved)
  - 90’s Monitor (sharp, bright)
- Handheld LCD simulation shaders:
  - Motion blur
  - Subpixel layout
  - DMG palette (Game Boy)
- Game Boy overlay with custom 4K bezel
- Multi-language support (EN, FR, ES, PT, IT, DE, PL)
- Automatic installation of required shader files
- Legacy shader cleanup from older versions
- Fully controller-driven interface (X / Y toggles)

---

## Supported Systems

### Handhelds

- Nintendo Game Boy  
  DMG palette + LCD grid + motion blur  

- Nintendo Game Boy Color  
  LCD grid + subpixel color + motion blur  

- Nintendo Game Boy Advance  
  LCD grid + color correction + motion blur  

- SEGA Game Gear  
  LCD grid + color correction + motion blur  

- NeoGeo Pocket  
  LCD grid + motion blur  

- NeoGeo Pocket Color  
  LCD grid + subpixel color + motion blur  

- WonderSwan Color  
  LCD grid + color correction  

- Atari Lynx  
  LCD grid + color correction + motion blur  

---

### Consoles (CRT Styles)

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

---

## CRT Styles

### 80’s Television

Shader: crt-retro.glslp

Features:
- Warm tone  
- Scanlines  
- Bloom / glow  
- Color bleed  
- Screen curvature  

---

### 90’s Monitor

Shader: monitor-retro.glslp

Features:
- Sharper image  
- Brighter output  
- Arcade-style presentation  

---

- Active CRT style is shown in the main menu  
- Reapplying shaders will overwrite existing presets with the selected style  

---

## How It Works

### First Run

On first launch, the script will:

- Check for required shader files  
- Install shaders if missing:
  - Copy presets to:

    ~/.config/retroarch/shaders/

  - Build full CRT pipeline:
    - convergence  
    - linearize  
    - glow (X/Y)  
    - CRT-consumer  

  - Create Game Boy overlay:
    - Config file + PNG bezel  

  - Remove legacy shader files  
  - Set correct file ownership  

---

### Applying Shaders

- Writes `.glslp` files to:

  ~/.config/retroarch/config/<CoreName>/

- RetroArch automatically loads shaders per core  
- Writes overlay config when applicable  

---

### Removing Shaders

- Deletes `.glslp` and overlay `.cfg` files  
- Restores default RetroArch behavior  

---

### CRT Style Handling

- Style is selected before applying console shaders  
- Reapplying updates all configs to match selected style  

---

## Installation

1. Copy the script to your R36S Tools Folder

2. Run it

---

## Requirements

- R36S running ArkOS or dArkOS  
- RetroArch (standard install paths)  

Required tools:

- dialog  
- gptokeyb  
- setfont  

---

## File Locations

Shader presets:

~/.config/retroarch/shaders/

Core shader configs:

~/.config/retroarch/config/<CoreName>/

32-bit core configs:

~/.config/retroarch32/config/<CoreName>/

Game Boy overlay:

~/.config/retroarch/overlay/

---

## Notes

- Optimized specifically for R36S hardware  
- Designed for performance-balanced visuals on RK3326  
- Safe to re-run without breaking existing configs  

---

## Credits

- Created by djparent  

---
