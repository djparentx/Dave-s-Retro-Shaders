# Dave's Retro Shaders 2.0

A RetroArch shader management tool for the R36S, designed for ArkOS and dArkOS, providing an easy, controller-friendly way to apply and manage curated shader presets per system. These shaders are custom lightweight versions of shaders already found in Retroarch. They have been modified for performance on the rk3326 platform.

[<img width="300" height="150" alt="ChatGPT Image Aug 11, 2026, 10_52_38 AM" src="https://github.com/user-attachments/assets/8680b713-26ad-4d3a-90ea-da1b27a0fe93" />](https://ko-fi.com/O8Z424G15Y)

---

## Screenshots

<p align="center">
  <img width="320" height="240" alt="crt80" src="https://github.com/user-attachments/assets/b56f0676-9d7a-40d1-89a0-216ad908d948" />
  <img width="320" height="240" alt="crt90" src="https://github.com/user-attachments/assets/59260240-5ee4-41b3-a2a5-dcc39b6bfbf9" />
  <img width="320" height="240" alt="gameboy" src="https://github.com/user-attachments/assets/9c6689ea-28b9-49c4-b88c-920936b11700" />
  <img width="320" height="240" alt="gbc" src="https://github.com/user-attachments/assets/16844231-a83a-457b-b1ac-554591a0170b" />
  <img width="320" height="240" alt="gba" src="https://github.com/user-attachments/assets/405e8450-4f2b-4f9d-ae84-fe59e1c48d2f" />
  <img width="320" height="240" alt="gamegear" src="https://github.com/user-attachments/assets/c8fbb59e-7387-4cce-8784-0d7e8b062e38" />
  <img width="320" height="240" alt="lynx" src="https://github.com/user-attachments/assets/3d087ddc-d71a-4f3e-a019-8f0359a102c6" />
  <img width="320" height="240" alt="ngp" src="https://github.com/user-attachments/assets/f77f5e20-9507-48f0-bbad-c430f77ff4df" />
  <img width="320" height="240" alt="ngpc" src="https://github.com/user-attachments/assets/5f1d71f5-bdfa-4a1f-b680-c7faeecc92d6" />
  <img width="320" height="240" alt="wsc" src="https://github.com/user-attachments/assets/4c0a0884-ef57-4178-b2a2-68b03b468774" />
</p>

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
