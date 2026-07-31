# Dave's Retro Shaders 2.0

A RetroArch shader management tool for the R36S, designed for ArkOS and dArkOS, providing an easy, controller-friendly way to apply and manage curated shader presets per system. These shaders are custom lightweight versions of shaders already found in Retroarch. They have been modified for performance on the rk3326 platform.

---

## Overview

This script simplifies shader management on the R36S by eliminating manual configuration and providing a clean menu interface to apply or remove shaders across supported systems.

It includes curated presets designed to enhance visuals while maintaining performance on RK3326 hardware.

---

## Features

- Sets necessary RetroArch settings
- Apply or remove shaders per system or globally
- Use X or Y to toggle systems
- Two CRT styles:
  - 80’s Television (warm, curved)
  - 90’s Monitor (sharp, bright)
  - setting is persistent
- Handheld LCD simulation shaders:
  - Motion blur
  - Subpixel layout
  - BGR pixel simulation
- Game Boy, Gameboy Color, Gameboy Advance, NGP, and NGPC bezel overlays
- Sets RetroArch Aspect Ratio to Core Provided
- Multi-language support (EN, FR, ES, PT, IT, DE, PL)
- Automatic installation of custom shader files
- Legacy shader cleanup from older versions
- delete flag file at /home/ark/.retro_shaders_* to reinstall files

---

## Applied Shaders/Overlays

### Handhelds

- Nintendo Game Boy  
  Overlay + DMG palette + motion blur  

- Nintendo Game Boy Color  
  Overlay + GBC color + motion blur  

- Nintendo Game Boy Advance  
  Overlay + GBA color + motion blur  

- SEGA Game Gear  
  LCD grid shader + BGR pixels + motion blur  

- NeoGeo Pocket  
  Overlay + motion blur  

- NeoGeo Pocket Color  
  Overlay + motion blur  

- WonderSwan Color  
  LCD grid shader + GBC color  

- Atari Lynx  
  LCD grid + BGR Pixel + GBC color + motion blur  

---

### Consoles (CRT)

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

  - Install shaders to:
    
    ~/.config/retroarch/shaders/shadersglsl/
    
  - Install overlays to:
    
    ~/.config/retroarch/overlay/

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

- Style is selected *before* applying console shaders  
- Reapplying updates all configs to match selected style  

---

## Installation

1. Copy the script to your R36S Tools Folder

2. Run it

---

## Requirements

- 4:3 screen ratio
- R36S or variant running ArkOS or dArkOS  
- RetroArch (standard install paths)  

---

## File Locations

---

## Credits

- Created by djparent  

---

<img width="1280" height="960" alt="gb_grid" src="https://github.com/user-attachments/assets/20674cab-9db1-456e-b291-e112acfee2d3" />

---

<img width="1280" height="960" alt="gbc_grid" src="https://github.com/user-attachments/assets/7f4d2948-d07a-4df1-bb0e-2f8adda91c6e" />

---

<img width="1280" height="960" alt="gba_grid" src="https://github.com/user-attachments/assets/6d9781d8-550b-4451-9c1e-0f205a3be654" />

---

<img width="1280" height="960" alt="ngpc_grid" src="https://github.com/user-attachments/assets/05050f78-8c12-4126-919e-92d23610a4f6" />

---
