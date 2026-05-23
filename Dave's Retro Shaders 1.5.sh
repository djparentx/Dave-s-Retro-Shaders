#!/bin/bash

# =======================================
# Dave's Retro Shaders v1.5
# by djparent
# =======================================

# Copyright (c) 2026 djparent
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# ============================================================
# Root privileges check
# ============================================================
if [ "$(id -u)" -ne 0 ]; then
    exec sudo -- "$0" "$@"
fi

# ============================================================
# Initialization
# ============================================================
export TERM=linux
GPTOKEYB_PID=""
CURR_TTY="/dev/tty1"
TMP_KEYS="/tmp/keys.gptk.$$"
FLAG="/home/ark/.retroshaders"
TV_FLAG="/home/ark/.crt-retro"
MON_FLAG="/home/ark/.monitor-retro"
SHADERPATH="/home/ark/.config/retroarch/shaders"
CONFIGPATH="/home/ark/.config/retroarch/config"
CONFIG32PATH="/home/ark/.config/retroarch32/config"
ES_CFG="/etc/emulationstation/es_systems.cfg"
ES_CONF="/home/ark/.emulationstation/es_settings.cfg"

if [ -f "$ES_CONF" ]; then
    ES_DETECTED=$(grep "name=\"Language\"" "$ES_CONF" | grep -o 'value="[^"]*"' | cut -d '"' -f 2)
    [ -n "$ES_DETECTED" ] && SYSTEM_LANG="$ES_DETECTED"
fi
# -------------------------------------------------------
# Default configuration : EN
# -------------------------------------------------------
T_BACKTITLE="Dave's Retro Shaders by djparent"
T_MAINTITLE="Main Menu"
T_HHTITLE="Handhelds"
T_CONTITLE="Consoles"
T_APPLY="Choose Retro Shaders to be applied."
T_REMOVE="Choose Retro Shaders to be removed."
T_CONTROLS="Use X or Y to toggle choices:"
T_SELECT="Make a selection:"
T_APPLY_MENU="Apply Retro Shaders"
T_REMOVE_MENU="Remove Retro Shaders"
T_APPLY_ALL="Apply All"
T_REMOVE_ALL="Remove All"
T_DEPEND="Dependencies"
T_INSTALL="Installing necessary files."
T_APPLIED="Shaders applied."
T_REMOVED="Shaders removed"
T_STARTING="Starting Dave's Retro Shaders,\nPlease wait ..."
T_CRT_STYLE="CRT Style"
T_80S="80's television"
T_90S="90's monitor"
T_EXIT="Exit"
T_BACK="Back"

# --- FRANÇAIS (FR) --- 
if [[ "$SYSTEM_LANG" == *"fr"* ]]; then
T_BACKTITLE="Dave s Retro Shaders par djparent"
T_MAINTITLE="Menu principal"
T_HHTITLE="Portables"
T_CONTITLE="Consoles"
T_APPLY="Choisissez les Retro Shaders a appliquer."
T_REMOVE="Choisissez les Retro Shaders a supprimer."
T_CONTROLS="Utilisez X ou Y pour changer la selection :"
T_SELECT="Faites une selection :"
T_APPLY_MENU="Appliquer Retro Shaders"
T_REMOVE_MENU="Supprimer Retro Shaders"
T_APPLY_ALL="Tout appliquer"
T_REMOVE_ALL="Tout supprimer"
T_DEPEND="Dependances"
T_INSTALL="Installation des fichiers necessaires."
T_APPLIED="Shaders appliques."
T_REMOVED="Shaders supprimes"
T_STARTING="Demarrage de Dave's Retro Shaders,\nVeuillez patienter ..."
T_CRT_STYLE="Style CRT"
T_80S="Television des annees 80"
T_90S="Moniteur des annees 90"
T_EXIT="Quitter"
T_BACK="Retour"

# --- ESPAÑOL (ES) ---
elif [[ "$SYSTEM_LANG" == *"es"* ]]; then
T_BACKTITLE="Dave s Retro Shaders por djparent"
T_MAINTITLE="Menu principal"
T_HHTITLE="Portatiles"
T_CONTITLE="Consolas"
T_APPLY="Elija los Retro Shaders a aplicar."
T_REMOVE="Elija los Retro Shaders a eliminar."
T_CONTROLS="Use X o Y para cambiar la seleccion:"
T_SELECT="Haga una seleccion:"
T_APPLY_MENU="Aplicar Retro Shaders"
T_REMOVE_MENU="Eliminar Retro Shaders"
T_APPLY_ALL="Aplicar todo"
T_REMOVE_ALL="Eliminar todo"
T_DEPEND="Dependencias"
T_INSTALL="Instalando archivos necesarios."
T_APPLIED="Shaders aplicados."
T_REMOVED="Shaders eliminados"
T_STARTING="Iniciando Dave's Retro Shaders,\nPor favor espere ..."
T_CRT_STYLE="Estilo CRT"
T_80S="Television de los anos 80"
T_90S="Monitor de los anos 90"
T_EXIT="Salir"
T_BACK="Atras"

# --- PORTUGUÊS (PT) ---
elif [[ "$SYSTEM_LANG" == *"pt"* ]]; then
T_BACKTITLE="Dave s Retro Shaders por djparent"
T_MAINTITLE="Menu principal"
T_HHTITLE="Portateis"
T_CONTITLE="Consolas"
T_APPLY="Escolha os Retro Shaders a aplicar."
T_REMOVE="Escolha os Retro Shaders a remover."
T_CONTROLS="Use X ou Y para alternar a selecao:"
T_SELECT="Faca uma selecao:"
T_APPLY_MENU="Aplicar Retro Shaders"
T_REMOVE_MENU="Remover Retro Shaders"
T_APPLY_ALL="Aplicar tudo"
T_REMOVE_ALL="Remover tudo"
T_DEPEND="Dependencias"
T_INSTALL="Instalando ficheiros necessarios."
T_APPLIED="Shaders aplicados."
T_REMOVED="Shaders removidos"
T_STARTING="Iniciando Dave's Retro Shaders,\nPor favor aguarde ..."
T_CRT_STYLE="Estilo CRT"
T_80S="Televisao dos anos 80"
T_90S="Monitor dos anos 90"
T_EXIT="Sair"
T_BACK="Voltar"

# --- ITALIANO (IT) ---
elif [[ "$SYSTEM_LANG" == *"it"* ]]; then
T_BACKTITLE="Dave s Retro Shaders di djparent"
T_MAINTITLE="Menu principale"
T_HHTITLE="Portatili"
T_CONTITLE="Console"
T_APPLY="Scegli i Retro Shaders da applicare."
T_REMOVE="Scegli i Retro Shaders da rimuovere."
T_CONTROLS="Usa X o Y per cambiare selezione:"
T_SELECT="Fai una selezione:"
T_APPLY_MENU="Applica Retro Shaders"
T_REMOVE_MENU="Rimuovi Retro Shaders"
T_APPLY_ALL="Applica tutto"
T_REMOVE_ALL="Rimuovi tutto"
T_DEPEND="Dipendenze"
T_INSTALL="Installazione dei file necessari."
T_APPLIED="Shaders applicati."
T_REMOVED="Shaders rimossi"
T_STARTING="Avvio di Dave's Retro Shaders,\nAttendere prego ..."
T_CRT_STYLE="Stile CRT"
T_80S="Televisore anni 80"
T_90S="Monitor anni 90"
T_EXIT="Esci"
T_BACK="Indietro"

# --- DEUTSCH (DE) ---
elif [[ "$SYSTEM_LANG" == *"de"* ]]; then
T_BACKTITLE="Dave s Retro Shaders von djparent"
T_MAINTITLE="Hauptmenu"
T_HHTITLE="Handhelds"
T_CONTITLE="Konsolen"
T_APPLY="Waehlen Sie Retro Shaders zum Anwenden."
T_REMOVE="Waehlen Sie Retro Shaders zum Entfernen."
T_CONTROLS="Verwenden Sie X oder Y zum Umschalten:"
T_SELECT="Treffen Sie eine Auswahl:"
T_APPLY_MENU="Retro Shaders anwenden"
T_REMOVE_MENU="Retro Shaders entfernen"
T_APPLY_ALL="Alle anwenden"
T_REMOVE_ALL="Alle entfernen"
T_DEPEND="Abhaengigkeiten"
T_INSTALL="Installiere notwendige Dateien."
T_APPLIED="Shaders angewendet."
T_REMOVED="Shaders entfernt"
T_STARTING="Dave's Retro Shaders wird gestartet,\nBitte warten ..."
T_CRT_STYLE="CRT Stil"
T_80S="Fernseher der 80er Jahre"
T_90S="Monitor der 90er Jahre"
T_EXIT="Beenden"
T_BACK="Zuruck"

# --- POLSKI (PL) ---
elif [[ "$SYSTEM_LANG" == *"pl"* ]]; then
T_BACKTITLE="Dave s Retro Shaders przez djparent"
T_MAINTITLE="Menu glowne"
T_HHTITLE="Urzadzenia przenosne"
T_CONTITLE="Konsole"
T_APPLY="Wybierz Retro Shaders do zastosowania."
T_REMOVE="Wybierz Retro Shaders do usuniecia."
T_CONTROLS="Uzyj X lub Y aby zmienic wybor:"
T_SELECT="Dokonaj wyboru:"
T_APPLY_MENU="Zastosuj Retro Shaders"
T_REMOVE_MENU="Usun Retro Shaders"
T_APPLY_ALL="Zastosuj wszystko"
T_REMOVE_ALL="Usun wszystko"
T_DEPEND="Zaleznosci"
T_INSTALL="Instalowanie wymaganych plikow."
T_APPLIED="Shaders zastosowane."
T_REMOVED="Shaders usuniete"
T_STARTING="Uruchamianie Dave's Retro Shaders,\nProsze czekac ..."
T_CRT_STYLE="Styl CRT"
T_80S="Telewizor z lat 80"
T_90S="Monitor z lat 90"
T_EXIT="Wyjscie"
T_BACK="Wstecz"
fi

# ============================================================
# Start gamepad input
# ============================================================
start_gptkeyb() {
    pkill -9 -f gptokeyb 2>/dev/null || true
    if [ -n "${GPTOKEYB_PID:-}" ]; then
        kill "$GPTOKEYB_PID" 2>/dev/null
    fi
    sleep 0.1
	/opt/inttools/gptokeyb -1 "$0" -c "$TMP_KEYS" > /dev/null 2>&1 &
    GPTOKEYB_PID=$!
}

# ============================================================
# Stop gamepad input
# ============================================================
stop_gptkeyb() {
    if [ -n "${GPTOKEYB_PID:-}" ]; then
        kill "$GPTOKEYB_PID" 2>/dev/null
        GPTOKEYB_PID=""
    fi
}

# ============================================================
# Font Selection
# ============================================================
original_font=$(setfont -v 2>&1 | grep -o '/.*\.psf.*')
setfont /usr/share/consolefonts/Lat7-TerminusBold22x11.psf.gz

# ============================================================
# Display Management
# ============================================================
printf "\e[?25l" > "$CURR_TTY"
dialog --clear
stop_gptkeyb
pgrep -f osk.py | xargs kill -9
printf "\033[H\033[2J" > "$CURR_TTY"
printf "$T_STARTING" > "$CURR_TTY"
sleep 0.5

# ============================================================
# Exit the script
# ============================================================
exit_menu() {
	trap - EXIT
    printf "\033[H\033[2J" > "$CURR_TTY"
    printf "\e[?25h" > "$CURR_TTY"
	stop_gptkeyb
    rm -f "$TMP_KEYS"
    if [[ ! -e "/dev/input/by-path/platform-odroidgo2-joypad-event-joystick" ]]; then
        [ -n "$original_font" ] && setfont "$original_font"
    fi

    exit 0
}

# ==============================================
# Set important RetroArch Settings
# ==============================================
set_ra() {
	# --- set necessary RetroArch settings ---
	set_cfg() {
		local key="$1" val="$2" file="$3"
		if grep -q "^${key} =" "$file"; then
			sed -i "s/^${key} = .*/${key} = \"${val}\"/" "$file"
		else
			echo "${key} = \"${val}\"" >> "$file"
		fi
		sleep 0.1
	}

	CONFIGS=(
		/home/ark/.config/retroarch/retroarch.cfg
		/home/ark/.config/retroarch32/retroarch.cfg
	)

	declare -A SETTINGS=(
		[config_save_on_exit]="true"
		[aspect_ratio_index]="22"
		[video_frame_delay_auto]="true"
	)

	for cfg in "${CONFIGS[@]}"; do
		for key in "${!SETTINGS[@]}"; do
			set_cfg "$key" "${SETTINGS[$key]}" "$cfg"
		done
	done
}

# ==============================================
# Config File Creation
# ==============================================
create_gbglslp() {
# --- Create GameBoy shader config file ---
mkdir -p $CONFIGPATH/Gambatte
	cat > $CONFIGPATH/Gambatte/gb.glslp << 'EOF'
#reference "../../shaders/gb-retro.glslp"
EOF

cat > $CONFIGPATH/Gambatte/gb.cfg << 'EOF'
input_overlay = "~/.config/retroarch/overlay/gb_sd.cfg"
input_overlay_opacity = "1.000000"
EOF

chown -R ark:ark $CONFIGPATH/Gambatte
}

create_gbcglslp() {
# --- Create GameBoy Color shader config file ---
mkdir -p $CONFIGPATH/Gambatte
	cat > $CONFIGPATH/Gambatte/gbc.glslp << 'EOF'
#reference "../../shaders/gbc-retro.glslp"
EOF

mkdir -p $CONFIGPATH/Gambatte
	cat > $CONFIGPATH/Gambatte/gbc.cfg << 'EOF'
input_overlay = "~/.config/retroarch/overlay/gbc_sd.cfg"
input_overlay_opacity = "1.000000"
EOF

chown -R ark:ark $CONFIGPATH/Gambatte
}

create_gbaglslp() {
# --- Create GameBoy Advance shader config file ---
mkdir -p $CONFIGPATH/mGBA
	cat > $CONFIGPATH/mGBA/gba.glslp << 'EOF'
#reference "../../shaders/gba-retro.glslp"
EOF

mkdir -p $CONFIGPATH/mGBA
	cat > $CONFIGPATH/mGBA/gba.cfg << 'EOF'
input_overlay = "~/.config/retroarch/overlay/gba_sd.cfg"
input_overlay_opacity = "1.000000"
EOF

chown -R ark:ark $CONFIGPATH/mGBA
}

create_ggglslp() {
# --- Create GameGear shader config file ---
mkdir -p $CONFIGPATH/Genesis\ Plus\ GX
	cat > $CONFIGPATH/Genesis\ Plus\ GX/gamegear.glslp << 'EOF'
#reference "../../shaders/gamegear-retro.glslp"
EOF

chown -R ark:ark $CONFIGPATH/Genesis\ Plus\ GX
}

create_ngpglslp() {
# --- Create NeoGeo Pocket shader config file ---
mkdir -p $CONFIGPATH/Beetle\ NeoPop
	cat > $CONFIGPATH/Beetle\ NeoPop/ngp.glslp << 'EOF'
#reference "../../shaders/ngp-retro.glslp"
EOF

cat > $CONFIGPATH/Beetle\ NeoPop/ngp.cfg << 'EOF'
input_overlay = "~/.config/retroarch/overlay/gb-4k.cfg"
input_overlay_aspect_adjust_landscape = "0.005000"
input_overlay_opacity = "0.3"
EOF

chown -R ark:ark $CONFIGPATH/Beetle\ NeoPop
}	

create_ngpcglslp() {
# --- Create NeoGeo Pocket Color shader config file ---
mkdir -p $CONFIGPATH/Beetle\ NeoPop
	cat > $CONFIGPATH/Beetle\ NeoPop/ngpc.glslp << 'EOF'
#reference "../../shaders/ngpc-retro.glslp"
EOF

cat > $CONFIGPATH/Beetle\ NeoPop/ngpc.cfg << 'EOF'
input_overlay = "~/.config/retroarch/overlay/gb-4k.cfg"
input_overlay_aspect_adjust_landscape = "0.005000"
input_overlay_opacity = "0.3"
EOF

chown -R ark:ark $CONFIGPATH/Beetle\ NeoPop
}

create_wscglslp() {
# --- Create WonderSwan Color shader config file ---
mkdir -p $CONFIGPATH/Beetle\ WonderSwan
	cat > $CONFIGPATH/Beetle\ WonderSwan/wonderswancolor.glslp << 'EOF'
#reference "../../shaders/wsc-retro.glslp"
EOF

chown -R ark:ark $CONFIGPATH/Beetle\ WonderSwan
}

create_lynxglslp() {
# --- Create Lynx shader config file ---
mkdir -p $CONFIG32PATH/Handy
	cat > $CONFIG32PATH/Handy/atarilynx.glslp << 'EOF'
#reference "~/.config/retroarch/shaders/lynx-retro.glslp"
EOF

chown -R ark:ark $CONFIG32PATH/Handy
}

create_arcadeglslp() {
# --- Create Arcade/MAME shader config files ---
mkdir -p $CONFIGPATH/FinalBurn\ Neo
	cat > $CONFIGPATH/FinalBurn\ Neo/arcade.glslp << EOF
$CRT_REF
EOF

chown -R ark:ark $CONFIGPATH/FinalBurn\ Neo
}

create_atariglslp() {
# --- Create Atari shader config files ---
mkdir -p $CONFIGPATH/Stella\ 2014
mkdir -p $CONFIGPATH/a5200
mkdir -p $CONFIGPATH/ProSystem
	cat > $CONFIGPATH/Stella\ 2014/atari2600.glslp << EOF
$CRT_REF
EOF

cat > $CONFIGPATH/a5200/atari5200.glslp << EOF
$CRT_REF
EOF

cat > $CONFIGPATH/ProSystem/atari7800.glslp << EOF
$CRT_REF
EOF

chown -R ark:ark $CONFIGPATH/Stella\ 2014
chown -R ark:ark $CONFIGPATH/a5200
chown -R ark:ark $CONFIGPATH/ProSystem
}

create_capcomglslp() {
# --- Create CAPCOM shader config files ---
mkdir -p $CONFIGPATH/FinalBurn\ Neo
	cat > $CONFIGPATH/FinalBurn\ Neo/cps1.glslp << EOF
$CRT_REF
EOF

cat > $CONFIGPATH/FinalBurn\ Neo/cps2.glslp << EOF
$CRT_REF
EOF

cat > $CONFIGPATH/FinalBurn\ Neo/cps3.glslp << EOF
$CRT_REF
EOF

chown -R ark:ark $CONFIGPATH/FinalBurn\ Neo
}

create_nesglslp() {
# --- Create NES shader config file ---
mkdir -p $CONFIGPATH/Nestopia
	cat > $CONFIGPATH/Nestopia/nes.glslp << EOF
$CRT_REF
EOF

chown -R ark:ark $CONFIGPATH/Nestopia
}

create_snesglslp() {
# --- Create SNES shader config file ---
mkdir -p $CONFIGPATH/Snes9x
	cat > $CONFIGPATH/Snes9x/snes.glslp << EOF
$CRT_REF
EOF

chown -R ark:ark $CONFIGPATH/Snes9x
}

create_sg1000glslp() {
# --- Create SG1000 shader config file ---
mkdir -p $CONFIGPATH/Genesis\ Plus\ GX
	cat > $CONFIGPATH/Genesis\ Plus\ GX/sg-1000.glslp << EOF
$CRT_REF
EOF

chown -R ark:ark $CONFIGPATH/Genesis\ Plus\ GX
}

create_msglslp() {
# --- Create MasterSystem shader config file ---
mkdir -p $CONFIGPATH/Genesis\ Plus\ GX
	cat > $CONFIGPATH/Genesis\ Plus\ GX/mastersystem.glslp << EOF
$CRT_REF
EOF

chown -R ark:ark $CONFIGPATH/Genesis\ Plus\ GX
}

create_mdglslp() {
# --- Create Mega Drive shader config file ---
mkdir -p $CONFIGPATH/Genesis\ Plus\ GX
	cat > $CONFIGPATH/Genesis\ Plus\ GX/megadrive.glslp << EOF
$CRT_REF
EOF

chown -R ark:ark $CONFIGPATH/Genesis\ Plus\ GX
}

create_segacdglslp() {
# --- Create SEGA CD shader config file ---
mkdir -p $CONFIGPATH/Genesis\ Plus\ GX
	cat > $CONFIGPATH/Genesis\ Plus\ GX/segacd.glslp << EOF
$CRT_REF
EOF

chown -R ark:ark $CONFIGPATH/Genesis\ Plus\ GX
}

create_sega32xglslp() {
# --- Create SEGA 32x shader config file ---
mkdir -p $CONFIGPATH/PicoDrive
	cat > $CONFIGPATH/PicoDrive/sega32x.glslp << EOF
$CRT_REF
EOF

chown -R ark:ark $CONFIGPATH/PicoDrive
}

create_pcengineglslp() {
# --- Create PC Engine shader config file ---
mkdir -p $CONFIGPATH/Beetle\ PCE\ Fast
	cat > $CONFIGPATH/Beetle\ PCE\ Fast/pcengine.glslp << EOF
$CRT_REF
EOF

chown -R ark:ark $CONFIGPATH/Beetle\ PCE\ Fast
}

create_pcenginecdglslp() {
# --- Create PC Engine CD shader config file ---
mkdir -p $CONFIGPATH/Beetle\ PCE\ Fast
	cat > $CONFIGPATH/Beetle\ PCE\ Fast/pcenginecd.glslp << EOF
$CRT_REF
EOF

chown -R ark:ark $CONFIGPATH/Beetle\ PCE\ Fast
}

create_neogeoglslp() {
# --- Create NeoGeo shader config file ---
mkdir -p $CONFIGPATH/FinalBurn\ Neo
	cat > $CONFIGPATH/FinalBurn\ Neo/neogeo.glslp << EOF
$CRT_REF
EOF

chown -R ark:ark $CONFIGPATH/FinalBurn\ Neo
}

create_neogeocdglslp() {
# --- Create NeoGeo CD shader config file ---
mkdir -p $CONFIGPATH/NeoCD
	cat > $CONFIGPATH/NeoCD/neogeocd.glslp << EOF
$CRT_REF
EOF

chown -R ark:ark $CONFIGPATH/NeoCD
}

# ==============================================
# Config File Deletion
# ==============================================
delete_gbglslp() {
# --- Delete GameBoy shader config file ---
rm -f $CONFIGPATH/Gambatte/gb.glslp
rm -f $CONFIGPATH/Gambatte/gb.cfg
}

delete_gbcglslp() {
# --- Delete GameBoy Color shader config file ---
rm -f $CONFIGPATH/Gambatte/gbc.glslp
rm -f $CONFIGPATH/Gambatte/gbc.cfg
}

delete_gbaglslp() {
# --- Delete GameBoy Advance shader config file ---
rm -f $CONFIGPATH/mGBA/gba.glslp
}

delete_ggglslp() {
# --- Delete GameGear shader config file ---
rm -f $CONFIGPATH/Genesis\ Plus\ GX/gamegear.glslp
}

delete_ngpglslp() {
# --- Delete NeoGeo Pocket shader config file ---
rm -f $CONFIGPATH/Beetle\ NeoPop/ngp.glslp
rm -f $CONFIGPATH/Beetle\ NeoPop/ngp.cfg
}	

delete_ngpcglslp() {
# --- Delete NeoGeo Pocket Color shader config file ---
rm -f $CONFIGPATH/Beetle\ NeoPop/ngpc.glslp
rm -f $CONFIGPATH/Beetle\ NeoPop/ngpc.cfg
}

delete_wscglslp() {
# --- Delete WonderSwan Color shader config file ---
rm -f $CONFIGPATH/Beetle\ WonderSwan/wonderswancolor.glslp
}

delete_lynxglslp() {
# --- Delete Lynx shader config file ---
rm -f $CONFIG32PATH/Handy/atarilynx.glslp
}

delete_arcadeglslp() {
# --- Delete Arcade/Mame shader config files ---
rm -f $CONFIGPATH/FinalBurn\ Neo/arcade.glslp
}

delete_atariglslp() {
# --- Delete Atari shader config files ---
rm -f $CONFIGPATH/Stella\ 2014/atari2600.glslp
rm -f $CONFIGPATH/a5200/atari5200.glslp
rm -f $CONFIGPATH/ProSystem/atari7800.glslp
}

delete_capcomglslp() {
# --- Delete CAPCOM shader config files ---
rm -f $CONFIGPATH/FinalBurn\ Neo/cps1.glslp
rm -f $CONFIGPATH/FinalBurn\ Neo/cps2.glslp
rm -f $CONFIGPATH/FinalBurn\ Neo/cps3.glslp
}

delete_nesglslp() {
# --- Delete NES shader config file ---
rm -f $CONFIGPATH/Nestopia/nes.glslp
}

delete_snesglslp() {
# --- Delete SNES shader config file ---
rm -f $CONFIGPATH/Snes9x/snes.glslp
}

delete_sg1000glslp() {
# --- Delete SG-1000 shader config file ---
rm -f $CONFIGPATH/Genesis\ Plus\ GX/sg-1000.glslp
}

delete_msglslp() {
# --- Delete MasterSystem shader config file ---
rm -f $CONFIGPATH/Genesis\ Plus\ GX/mastersystem.glslp
}

delete_mdglslp() {
# --- Delete Mega Drive shader config file ---
rm -f $CONFIGPATH/Genesis\ Plus\ GX/megadrive.glslp
}

delete_segacdglslp() {
# --- Delete SEGA CD shader config file ---
rm -f $CONFIGPATH/Genesis\ Plus\ GX/segacd.glslp
}

delete_sega32xglslp() {
# --- Delete SEGA 32x shader config file ---
rm -f $CONFIGPATH/PicoDrive/sega32x.glslp
}

delete_pcengineglslp() {
# --- Delete PC Engine shader config file ---
rm -f $CONFIGPATH/Beetle\ PCE\ Fast/pcengine.glslp
}

delete_pcenginecdglslp() {
# --- Delete PC Engine CD shader config file ---
rm -f $CONFIGPATH/Beetle\ PCE\ Fast/pcenginecd.glslp
}

delete_neogeoglslp() {
# --- Delete NeoGeo shader config file ---
rm -f $CONFIGPATH/FinalBurn\ Neo/neogeo.glslp
}

delete_neogeocdglslp() {
# --- Delete NeoGeo CD shader config file ---
rm -f $CONFIGPATH/NeoCD/neogeocd.glslp
}

# ============================================================
# Remove All
# ============================================================
remove_all() {
	delete_gbglslp
	delete_gbcglslp
	delete_gbaglslp
	delete_ggglslp
	delete_ngpglslp
	delete_ngpcglslp
	delete_wscglslp
	delete_lynxglslp
	delete_arcadeglslp
	delete_atariglslp
	delete_capcomglslp
	delete_nesglslp
	delete_snesglslp
	delete_sg1000glslp
	delete_msglslp
	delete_mdglslp
	delete_segacdglslp
	delete_sega32xglslp
	delete_pcengineglslp
	delete_pcenginecdglslp
	delete_neogeoglslp
	delete_neogeocdglslp
	
	dialog --backtitle "$T_BACKTITLE" --title "$T_REMOVE_ALL" --msgbox "\n $T_REMOVED" 7 40 > "$CURR_TTY"
}

# ============================================================
# Apply All
# ============================================================
apply_all() {
	create_gbglslp
	create_gbcglslp
	create_gbaglslp
	create_ggglslp
	create_ngpglslp
	create_ngpcglslp
	create_wscglslp
	create_lynxglslp
	create_arcadeglslp
	create_atariglslp
	create_capcomglslp
	create_nesglslp
	create_snesglslp
	create_sg1000glslp
	create_msglslp
	create_mdglslp
	create_segacdglslp
	create_sega32xglslp
	create_pcengineglslp
	create_pcenginecdglslp
	create_neogeoglslp
	create_neogeocdglslp
	set_ra
	
	dialog --backtitle "$T_BACKTITLE" --title "$T_APPLY_ALL" --msgbox "\n $T_APPLIED" 7 40 > "$CURR_TTY"
}

# ============================================================
# Handheld Remove Menu
# ============================================================
handheld_remove_menu() {
	CHOICES=$(dialog --backtitle "$T_BACKTITLE" \
					 --title "$T_HHTITLE" \
					 --cancel-label "$T_BACK" \
					 --no-tags \
					 --checklist "$T_REMOVE\n$T_CONTROLS" 16 40 14 \
					 "1" "Nintendo GameBoy" "off" \
					 "2" "Nintendo GameBoy Color" "off" \
					 "3" "Nintendo GameBoy Advance" "off" \
					 "4" "SEGA GameGear" "off" \
					 "5" "NeoGeo Pocket" "off" \
					 "6" "NeoGeo Pocket Color" "off" \
					 "7" "WonderSwan Color" "off" \
					 "8" "Atari Lynx" "off" \
					 2>&1 > "$CURR_TTY")
					 
		EXIT_CODE=$?
		[[ $EXIT_CODE -ne 0 ]] && return
	
	for i in {1..8}; do
		if echo "$CHOICES" | grep -qw "$i"; then
			case "$i" in
				1) delete_gbglslp ;;
				2) delete_gbcglslp ;;
				3) delete_gbaglslp ;;
				4) delete_ggglslp ;;
				5) delete_ngpglslp ;;
				6) delete_ngpcglslp ;;
				7) delete_wscglslp ;;
				8) delete_lynxglslp ;;
			esac
		fi
	done
	
	dialog --backtitle "$T_BACKTITLE" --title "$T_HHTITLE" --msgbox "\n $T_REMOVED" 7 40 > "$CURR_TTY"
}

# ============================================================
# Handheld Apply Menu
# ============================================================
handheld_apply_menu() {
	CHOICES=$(dialog --backtitle "$T_BACKTITLE" \
					 --title "$T_HHTITLE" \
					 --cancel-label "$T_BACK" \
					 --no-tags \
					 --checklist "$T_APPLY\n$T_CONTROLS" 16 40 14 \
					 "1" "Nintendo GameBoy" "off" \
					 "2" "Nintendo GameBoy Color" "off" \
					 "3" "Nintendo GameBoy Advance" "off" \
					 "4" "SEGA GameGear" "off" \
					 "5" "NeoGeo Pocket" "off" \
					 "6" "NeoGeo Pocket Color" "off" \
					 "7" "WonderSwan Color" "off" \
					 "8" "Atari Lynx" "off" \
					 2>&1 > "$CURR_TTY")
					 
		EXIT_CODE=$?
		[[ $EXIT_CODE -ne 0 ]] && return
	
	for i in {1..8}; do
		if echo "$CHOICES" | grep -qw "$i"; then
			case "$i" in
				1) create_gbglslp ;;
				2) create_gbcglslp ;;
				3) create_gbaglslp ;;
				4) create_ggglslp ;;
				5) create_ngpglslp ;;
				6) create_ngpcglslp ;;
				7) create_wscglslp ;;
				8) create_lynxglslp ;;
			esac
		fi
	done
	
	[[ -n "$CHOICES" ]] && set_ra
	
	dialog --backtitle "$T_BACKTITLE" --title "$T_HHTITLE" --msgbox "\n $T_APPLIED" 7 40 > "$CURR_TTY"
}


# ============================================================
# Console Remove Menu
# ============================================================
console_remove_menu() {
	CHOICES=$(dialog --backtitle "$T_BACKTITLE" \
					 --title "$T_CONTITLE" \
					 --cancel-label "$T_BACK" \
					 --no-tags \
					 --checklist "$T_REMOVE\n$T_CONTROLS" 16 40 14 \
					 "1" "Arcade/MAME" "off" \
					 "2" "Atari (2600/5200/7800)" "off" \
					 "3" "CAPCOM (I/II/III)" "off" \
					 "4" "Nintendo Entertainment System" "off" \
					 "5" "Super Nintendo ES" "off" \
					 "6" "SEGA SG-1000" "off" \
					 "7" "SEGA MasterSystem" "off" \
					 "8" "SEGA Mega Drive" "off" \
					 "9" "SEGA CD" "off" \
					 "10" "SEGA 32X" "off" \
					 "11" "PC Engine" "off" \
					 "12" "PC Engine CD" "off" \
					 "13" "NeoGeo" "off" \
					 "14" "NeoGeo CD" "off" \
					 2>&1 > "$CURR_TTY")
					 
		EXIT_CODE=$?
		[[ $EXIT_CODE -ne 0 ]] && return

	for i in {1..14}; do
		if echo "$CHOICES" | grep -qw "$i"; then
			case "$i" in
				1) delete_arcadeglslp ;;
				2) delete_atariglslp ;;
				3) delete_capcomglslp ;;
				4) delete_nesglslp ;;
				5) delete_snesglslp ;;
				6) delete_sg1000glslp ;;
				7) delete_msglslp ;;
				8) delete_mdglslp ;;
				9) delete_segacdglslp ;;
				10) delete_sega32xglslp ;;
				11) delete_pcengineglslp ;;
				12) delete_pcenginecdglslp ;;
				13) delete_neogeoglslp ;;
				14) delete_neogeocdglslp ;;
			esac
		fi
	done

	dialog --backtitle "$T_BACKTITLE" --title "$T_CONTITLE" --msgbox "\n $T_REMOVED" 7 40 > "$CURR_TTY"
}

# ============================================================
# Console Apply Menu
# ============================================================
console_apply_menu() {
	CHOICES=$(dialog --backtitle "$T_BACKTITLE" \
					 --title "$T_CONTITLE" \
					 --cancel-label "$T_BACK" \
					 --no-tags \
					 --checklist "$T_APPLY\n$T_CONTROLS" 16 40 14 \
					 "1" "Arcade/MAME" "off" \
					 "2" "Atari (2600/5200/7800)" "off" \
					 "3" "CAPCOM (I/II/III)" "off" \
					 "4" "Nintendo Entertainment System" "off" \
					 "5" "Super Nintendo ES" "off" \
					 "6" "SEGA SG-1000" "off" \
					 "7" "SEGA MasterSystem" "off" \
					 "8" "SEGA Mega Drive" "off" \
					 "9" "SEGA CD" "off" \
					 "10" "SEGA 32X" "off" \
					 "11" "PC Engine" "off" \
					 "12" "PC Engine CD" "off" \
					 "13" "NeoGeo" "off" \
					 "14" "NeoGeo CD" "off" \
					 2>&1 > "$CURR_TTY")
					 
		EXIT_CODE=$?
		[[ $EXIT_CODE -ne 0 ]] && return

	for i in {1..14}; do
		if echo "$CHOICES" | grep -qw "$i"; then
			case "$i" in
				1) create_arcadeglslp ;;
				2) create_atariglslp ;;
				3) create_capcomglslp ;;
				4) create_nesglslp ;;
				5) create_snesglslp ;;
				6) create_sg1000glslp ;;
				7) create_msglslp ;;
				8) create_mdglslp ;;
				9) create_segacdglslp ;;
				10) create_sega32xglslp ;;
				11) create_pcengineglslp ;;
				12) create_pcenginecdglslp ;;
				13) create_neogeoglslp ;;
				14) create_neogeocdglslp ;;
			esac
		fi
	done
	
	[[ -n "$CHOICES" ]] && set_ra

	dialog --backtitle "$T_BACKTITLE" --title "$T_CONTITLE" --msgbox "\n $T_APPLIED" 7 40 > "$CURR_TTY"
}

# ============================================================
# Remove Shaders Menu
# ============================================================
remove_shaders_menu() {
    while true; do
        local CHOICE
        CHOICE=$(dialog --clear \
						--cancel-label "$T_BACK" \
						--backtitle "$T_BACKTITLE" \
						--title "$T_REMOVE_MENU" \
						--menu "$T_SELECT" \
						10 40 6 \
						"1" "$T_HHTITLE" \
						"2" "$T_CONTITLE" \
						"3" "$T_REMOVE_ALL" \
						2>&1 > "$CURR_TTY")

        [[ $? -ne 0 ]] && return

        case "$CHOICE" in
            1) handheld_remove_menu ;;
            2) console_remove_menu ;;
			3) remove_all ;;
        esac
    done
}

# ============================================================
# Apply Shaders Menu
# ============================================================
apply_shaders_menu() {
	while true; do
        local CHOICE
        CHOICE=$(dialog --clear \
						--cancel-label "$T_BACK" \
						--backtitle "$T_BACKTITLE" \
						--title "$T_APPLY_MENU" \
						--menu "$T_SELECT" \
						10 40 6 \
						"1" "$T_HHTITLE" \
						"2" "$T_CONTITLE" \
						"3" "$T_APPLY_ALL" \
						2>&1 > "$CURR_TTY")

        [[ $? -ne 0 ]] && return

        case "$CHOICE" in
            1) handheld_apply_menu ;;
            2) console_apply_menu ;;
			3) apply_all ;;
        esac
    done
}

# ==============================================
# CRT Style Chooser
# ==============================================
crt_style() {
    while true; do
		
		[[ -f "$MON_FLAG" ]] && CRT="$T_90S" || CRT="$T_80S"
        
		local CHOICE
        CHOICE=$(dialog --clear \
						--colors \
						--cancel-label "$T_BACK" \
						--backtitle "$T_BACKTITLE" \
						--title "$T_CRT_STYLE" \
						--menu "$T_CRT_STYLE: \Z4$CRT\Zn\n$T_SELECT" \
						10 40 6 \
						"1" "$T_80S" \
						"2" "$T_90S" \
						2>&1 > "$CURR_TTY")

        [[ $? -ne 0 ]] && return

        case "$CHOICE" in
            1)	
				CRT="$T_80S"
				CRT_REF='#reference "../../shaders/crt-retro.glslp"'
				touch "$TV_FLAG"
				rm -f "$MON_FLAG"
				return
				;;
            2) 	
				CRT="$T_90S"
				CRT_REF='#reference "../../shaders/monitor-retro.glslp"'
				touch "$MON_FLAG"
				rm -f "$TV_FLAG"
				return
				;;
        esac
    done
}

# ============================================================
# Main Menu
# ============================================================
main_menu() {
    while true; do
        local CHOICE
        CHOICE=$(dialog --clear \
						--colors \
						--cancel-label "$T_EXIT" \
						--backtitle "$T_BACKTITLE" \
						--title "$T_MAINTITLE" \
						--menu "$T_CRT_STYLE: \Z4$CRT\Zn\n$T_SELECT" \
						11 40 6 \
						"1" "$T_APPLY_MENU" \
						"2" "$T_REMOVE_MENU" \
						"3" "$T_CRT_STYLE" \
						2>&1 > "$CURR_TTY")

        [[ $? -ne 0 ]] && exit_menu

        case "$CHOICE" in
            1) apply_shaders_menu ;;
            2) remove_shaders_menu ;;
			3) crt_style ;;
        esac
    done
}

# =======================================================
# Legacy File Cleanup
# =======================================================
delete_files() {
	rm -f $SHADERPATH/gb.glslp
	rm -f $SHADERPATH/gbc.glslp
	rm -f $SHADERPATH/gba.glslp
	rm -f $SHADERPATH/gamegear.glslp
	rm -f $SHADERPATH/lynx.glslp
	rm -f $SHADERPATH/ngp.glslp
	rm -f $SHADERPATH/ngpc.glslp
	rm -f $SHADERPATH/wsc.glslp
	rm -f $SHADERPATH/crt.glslp
}

# ==============================================
# Shader File Creation
# ==============================================
create_files() {

dialog --backtitle "$T_BACKTITLE" --title "$T_DEPEND" --infobox "\n $T_INSTALL" 7 40 > "$CURR_TTY"

[[ -f "$SHADERPATH/gb.glslp" ]] && delete_files

# --- Create GameBoy shader file ---
	cat > $SHADERPATH/gb-retro.glslp << 'EOF'
shaders = "3"
feedback_pass = "0"
shader0 = "shaders_glsl/handheld/shaders/gb-palette/gb-palette.glsl"
alias0 = ""
wrap_mode0 = "clamp_to_border"
mipmap_input0 = "false"
filter_linear0 = "false"
float_framebuffer0 = "false"
srgb_framebuffer0 = "false"
scale_type_x0 = "source"
scale_x0 = "1.000000"
scale_type_y0 = "source"
scale_y0 = "1.000000"
shader1 = "shaders_glsl/motionblur/shaders/response-time.glsl"
alias1 = ""
wrap_mode1 = "clamp_to_border"
mipmap_input1 = "false"
filter_linear1 = "false"
float_framebuffer1 = "false"
srgb_framebuffer1 = "false"
scale_type_x1 = "source"
scale_x1 = "1.000000"
scale_type_y1 = "source"
scale_y1 = "1.000000"
shader2 = "shaders_glsl/handheld/shaders/lcd-cgwg/lcd-grid-v2.glsl"
alias2 = ""
wrap_mode2 = "clamp_to_border"
mipmap_input2 = "false"
filter_linear2 = "false"
float_framebuffer2 = "false"
srgb_framebuffer2 = "false"
scale_type_x2 = "viewport"
scale_x2 = "1.000000"
scale_type_y2 = "viewport"
scale_y2 = "1.000000"
response_time = "0.222000"
RSUBPIX_R = "0.450000"
RSUBPIX_G = "0.650000"
GSUBPIX_R = "0.450000"
GSUBPIX_G = "0.650000"
BSUBPIX_R = "0.450000"
BSUBPIX_G = "0.650000"
BSUBPIX_B = "0.000000"
gamma = "2.400000"
outgamma = "1.600000"
blacklevel = "0.100000"
ambient = "0.050000"
textures = "COLOR_PALETTE"
COLOR_PALETTE = "shaders_glsl/handheld/shaders/gb-palette/resources/palette-dmg.png"
COLOR_PALETTE_mipmap = "false"
COLOR_PALETTE_wrap_mode = "clamp_to_border"
EOF

# --- Create GameBoy Advance shader file --
	cat > $SHADERPATH/gba-retro.glslp << 'EOF'
#reference "shaders_glsl/handheld/lcd-grid-v2-gba-color-motionblur.glslp"
response_time = "0.222000"
RSUBPIX_R = "0.800000"
GSUBPIX_G = "0.800000"
BSUBPIX_B = "0.800000"
gain = "1.400000"
gamma = "2.400000"
outgamma = "1.800000"
blacklevel = "0.100000"
ambient = "0.050000"
darken_screen = "0.650000"
EOF

# --- Create GameBoy Color shader file ---
	cat > $SHADERPATH/gbc-retro.glslp << 'EOF'
#reference "shaders_glsl/handheld/lcd-grid-v2-gbc-color-motionblur.glslp"
response_time = "0.222000"
RSUBPIX_R = "0.850000"
GSUBPIX_G = "0.850000"
BSUBPIX_B = "0.850000"
gain = "1.250000"
gamma = "2.400000"
outgamma = "1.800000"
BGR = "1.000000"
lighten_screen = "0.450000"
EOF

# --- Create GameGear shader file ---
	cat > $SHADERPATH/gamegear-retro.glslp << 'EOF'
#reference "shaders_glsl/handheld/lcd-grid-v2-motionblur.glslp"
response_time = "0.222000"
RSUBPIX_R = "1.000000"
GSUBPIX_G = "1.000000"
BSUBPIX_B = "1.000000"
gain = "1.350000"
gamma = "2.500000"
outgamma = "1.500000"
blacklevel = "0.150000"
ambient = "0.030000"
BGR = "1.000000"
EOF

# --- Create Lynx shader file ---
	cat > $SHADERPATH/lynx-retro.glslp << 'EOF'
#reference "shaders_glsl/handheld/lcd-grid-v2-gbc-color-motionblur.glslp"
response_time = "0.222000"
gain = "1.750000"
gamma = "2.400000"
outgamma = "1.800000"
blacklevel = "0.100000"
ambient = "0.050000"
lighten_screen = "0.250000"
EOF

# --- Create NeoGeo Pocket shader file ---
	cat > $SHADERPATH/ngp-retro.glslp << 'EOF'
#reference "shaders_glsl/handheld/lcd-grid-v2-motionblur.glslp"
response_time = "0.111000"
gain = "1.250000"
gamma = "2.400000"
outgamma = "1.800000"
blacklevel = "0.100000"
ambient = "0.020000"
EOF

# --- Create NeoGeo Pocket Color shader file ---
	cat > $SHADERPATH/ngpc-retro.glslp << 'EOF'
#reference "shaders_glsl/handheld/lcd-grid-v2-gba-color-motionblur.glslp"
response_time = "0.222000"
RSUBPIX_R = "0.850000"
GSUBPIX_G = "0.850000"
BSUBPIX_B = "0.850000"
gain = "1.150000"
gamma = "2.500000"
outgamma = "1.800000"
blacklevel = "0.100000"
ambient = "0.030000"
BGR = "0.000000"
darken_screen = "-0.000000"
EOF

# --- Create Wonderswan Color shader file ---
	cat > $SHADERPATH/wsc-retro.glslp << 'EOF'
#reference "gbc.glslp"
gain = "1.000000"
blacklevel = "0.100000"
ambient = "0.020000"
BGR = "0.000000"
lighten_screen = "0.500000"
EOF

# --- Create CRT-Monitor shader file ---
	cat > $SHADERPATH/monitor-retro.glslp << 'EOF'
#reference "shaders_glsl/crt/crt-nobody.glslp"
SCAN_SIZE = "0.900000"
COLOR_BOOST = "1.000000"
InputGamma = "2.500000"
OutputGamma = "2.000000"
EOF

# --- Create CRT-TV shader file ---
	cat > $SHADERPATH/crt-retro.glslp << 'EOF'
#reference "shaders_glsl/crt/crt-consumer.glslp"
beamlow = "0.650000"
beamhigh = "0.600000"
EOF

# --- Create CRT-Consumer shader file ---
	cat > $SHADERPATH/shaders_glsl/crt/crt-consumer.glslp << 'EOF'
shaders = "5"
feedback_pass = "0"
shader0 = "../misc/shaders/convergence.glsl"
filter_linear0 = "true"
shader1 = "../crt/shaders/crt-consumer/linearize.glsl"
filter_linear1 = "false"
shader2 = "../crt/shaders/crt-consumer/glow_x.glsl"
filter_linear2 = "false"
shader3 = "../crt/shaders/crt-consumer/glow_y.glsl"
filter_linear3 = "false"
shader4 = "../crt/shaders/crt-consumer/crt-consumer.glsl"
filter_linear4 = "true"
EOF


# --- Create Convergence shader file ---
	cat > $SHADERPATH/shaders_glsl/misc/shaders/convergence.glsl << 'EOF'
#version 110

/*
convergence pass DariusG 2023. 
Run in Linear, BEFORE actual shader pass
*/

#pragma parameter C_STR "Convergence Overall Strength" 0.0 0.0 0.5 0.05
#pragma parameter Rx "Convergence Red Horiz." 0.0 -5.0 5.0 0.05
#pragma parameter Ry "Convergence Red Vert." 0.0 -5.0 5.0 0.05
#pragma parameter Gx "Convergence Green Horiz." 0.0 -5.0 5.0 0.05
#pragma parameter Gy "Convergence Green Vert." 0.0 -5.0 5.0 0.05
#pragma parameter Bx "Convergence Blue Horiz." 0.0 -5.0 5.0 0.05
#pragma parameter By "Convergence Blue Vert." 0.0 -5.0 5.0 0.05

#define pi 3.1415926535897932384626433

#if defined(VERTEX)

#if __VERSION__ >= 130
#define COMPAT_VARYING out
#define COMPAT_ATTRIBUTE in
#define COMPAT_TEXTURE texture
#else
#define COMPAT_VARYING varying 
#define COMPAT_ATTRIBUTE attribute 
#define COMPAT_TEXTURE texture2D
#endif

#ifdef GL_ES
#define COMPAT_PRECISION mediump
#else
#define COMPAT_PRECISION
#endif

COMPAT_ATTRIBUTE vec4 VertexCoord;
COMPAT_ATTRIBUTE vec4 COLOR;
COMPAT_ATTRIBUTE vec4 TexCoord;
COMPAT_VARYING vec4 COL0;
COMPAT_VARYING vec4 TEX0;


vec4 _oPosition1; 
uniform mat4 MVPMatrix;
uniform COMPAT_PRECISION int FrameDirection;
uniform COMPAT_PRECISION int FrameCount;
uniform COMPAT_PRECISION vec2 OutputSize;
uniform COMPAT_PRECISION vec2 TextureSize;
uniform COMPAT_PRECISION vec2 InputSize;

// compatibility #defines
#define vTexCoord TEX0.xy
#define SourceSize vec4(TextureSize, 1.0 / TextureSize) //either TextureSize or InputSize
#define OutSize vec4(OutputSize, 1.0 / OutputSize)

#ifdef PARAMETER_UNIFORM
uniform COMPAT_PRECISION float SIZE;

#else
#define SIZE     1.0      
   
#endif

void main()
{
    gl_Position = MVPMatrix * VertexCoord;
    TEX0.xy = TexCoord.xy;

}

#elif defined(FRAGMENT)

#if __VERSION__ >= 130
#define COMPAT_VARYING in
#define COMPAT_TEXTURE texture
out vec4 FragColor;
#else
#define COMPAT_VARYING varying
#define FragColor gl_FragColor
#define COMPAT_TEXTURE texture2D
#endif

#ifdef GL_ES
#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif
#define COMPAT_PRECISION mediump
#else
#define COMPAT_PRECISION
#endif

uniform COMPAT_PRECISION int FrameDirection;
uniform COMPAT_PRECISION int FrameCount;
uniform COMPAT_PRECISION vec2 OutputSize;
uniform COMPAT_PRECISION vec2 TextureSize;
uniform COMPAT_PRECISION vec2 InputSize;
uniform sampler2D Texture;
COMPAT_VARYING vec4 TEX0;


// compatibility #defines
#define Source Texture
#define vTexCoord TEX0.xy

#define SourceSize vec4(TextureSize, 1.0 / TextureSize) //either TextureSize or InputSize
#define OutSize vec4(OutputSize, 1.0 / OutputSize)

#ifdef PARAMETER_UNIFORM
uniform COMPAT_PRECISION float C_STR;
uniform COMPAT_PRECISION float Rx;
uniform COMPAT_PRECISION float Ry;
uniform COMPAT_PRECISION float Gx;
uniform COMPAT_PRECISION float Gy;
uniform COMPAT_PRECISION float Bx;
uniform COMPAT_PRECISION float By;
#else
#define C_STR 0.0
#define Rx  0.0      
#define Ry  0.0      
#define Gx  0.0      
#define Gy  0.0      
#define Bx  0.0      
#define By  0.0      
    
#endif


void main()
{
vec2 dx = vec2(SourceSize.z,0.0);
vec2 dy = vec2(0.0,SourceSize.w);
vec2 pos = vTexCoord;
vec3 res0 = COMPAT_TEXTURE(Source,pos).rgb;
float resr = COMPAT_TEXTURE(Source,pos + dx*Rx + dy*Ry).r;
float resg = COMPAT_TEXTURE(Source,pos + dx*Gx + dy*Gy).g;
float resb = COMPAT_TEXTURE(Source,pos + dx*Bx + dy*By).b;

vec3 res = vec3(  res0.r*(1.0-C_STR) +  resr*C_STR,
                  res0.g*(1.0-C_STR) +  resg*C_STR,
                  res0.b*(1.0-C_STR) +  resb*C_STR 
                   );
FragColor.rgb = res;    
}
#endif
EOF


# --- Create Linearize shader file ---
	cat > $SHADERPATH/shaders_glsl/crt/shaders/crt-consumer/linearize.glsl << 'EOF'
#version 110

#pragma parameter g_in "Gamma In" 2.4 1.0 4.0 0.05

#define pi 3.1415926535897932384626433

#if defined(VERTEX)

#if __VERSION__ >= 130
#define COMPAT_VARYING out
#define COMPAT_ATTRIBUTE in
#define COMPAT_TEXTURE texture
#else
#define COMPAT_VARYING varying 
#define COMPAT_ATTRIBUTE attribute 
#define COMPAT_TEXTURE texture2D
#endif

#ifdef GL_ES
#define COMPAT_PRECISION mediump
#else
#define COMPAT_PRECISION
#endif

COMPAT_ATTRIBUTE vec4 VertexCoord;
COMPAT_ATTRIBUTE vec4 COLOR;
COMPAT_ATTRIBUTE vec4 TexCoord;
COMPAT_VARYING vec4 COL0;
COMPAT_VARYING vec4 TEX0;


vec4 _oPosition1; 
uniform mat4 MVPMatrix;
uniform COMPAT_PRECISION int FrameDirection;
uniform COMPAT_PRECISION int FrameCount;
uniform COMPAT_PRECISION vec2 OutputSize;
uniform COMPAT_PRECISION vec2 TextureSize;
uniform COMPAT_PRECISION vec2 InputSize;

// compatibility #defines
#define vTexCoord TEX0.xy
#define SourceSize vec4(TextureSize, 1.0 / TextureSize) //either TextureSize or InputSize
#define OutSize vec4(OutputSize, 1.0 / OutputSize)

#ifdef PARAMETER_UNIFORM
uniform COMPAT_PRECISION float SIZE;

#else
#define SIZE     1.0      
   
#endif

void main()
{
    gl_Position = MVPMatrix * VertexCoord;
    TEX0.xy = TexCoord.xy;

}

#elif defined(FRAGMENT)

#if __VERSION__ >= 130
#define COMPAT_VARYING in
#define COMPAT_TEXTURE texture
out vec4 FragColor;
#else
#define COMPAT_VARYING varying
#define FragColor gl_FragColor
#define COMPAT_TEXTURE texture2D
#endif

#ifdef GL_ES
#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif
#define COMPAT_PRECISION mediump
#else
#define COMPAT_PRECISION
#endif

uniform COMPAT_PRECISION int FrameDirection;
uniform COMPAT_PRECISION int FrameCount;
uniform COMPAT_PRECISION vec2 OutputSize;
uniform COMPAT_PRECISION vec2 TextureSize;
uniform COMPAT_PRECISION vec2 InputSize;
uniform sampler2D Texture;
COMPAT_VARYING vec4 TEX0;


// compatibility #defines
#define Source Texture
#define vTexCoord TEX0.xy

#define SourceSize vec4(TextureSize, 1.0 / TextureSize) //either TextureSize or InputSize
#define OutSize vec4(OutputSize, 1.0 / OutputSize)

#ifdef PARAMETER_UNIFORM
uniform COMPAT_PRECISION float g_in;

#else
#define g_in 2.4     
    
#endif


void main()
{
vec3 res = COMPAT_TEXTURE(Source,vTexCoord).rgb;
res = pow(res,vec3(g_in));
FragColor.rgb = res;    
}
#endif
EOF


# --- Create Glow_X shader file ---
	cat > $SHADERPATH/shaders_glsl/crt/shaders/crt-consumer/glow_x.glsl << 'EOF'
#version 110


#define pi 3.1415926535897932384626433

#if defined(VERTEX)

#if __VERSION__ >= 130
#define COMPAT_VARYING out
#define COMPAT_ATTRIBUTE in
#define COMPAT_TEXTURE texture
#else
#define COMPAT_VARYING varying 
#define COMPAT_ATTRIBUTE attribute 
#define COMPAT_TEXTURE texture2D
#endif

#ifdef GL_ES
#define COMPAT_PRECISION mediump
#else
#define COMPAT_PRECISION
#endif

COMPAT_ATTRIBUTE vec4 VertexCoord;
COMPAT_ATTRIBUTE vec4 COLOR;
COMPAT_ATTRIBUTE vec4 TexCoord;
COMPAT_VARYING vec4 COL0;
COMPAT_VARYING vec4 TEX0;


vec4 _oPosition1; 
uniform mat4 MVPMatrix;
uniform COMPAT_PRECISION int FrameDirection;
uniform COMPAT_PRECISION int FrameCount;
uniform COMPAT_PRECISION vec2 OutputSize;
uniform COMPAT_PRECISION vec2 TextureSize;
uniform COMPAT_PRECISION vec2 InputSize;

// compatibility #defines
#define vTexCoord TEX0.xy
#define SourceSize vec4(TextureSize, 1.0 / TextureSize) //either TextureSize or InputSize
#define OutSize vec4(OutputSize, 1.0 / OutputSize)

#ifdef PARAMETER_UNIFORM
uniform COMPAT_PRECISION float SIZE;

#else
#define SIZE     1.0      
   
#endif

void main()
{
    gl_Position = MVPMatrix * VertexCoord;
    TEX0.xy = TexCoord.xy;

}

#elif defined(FRAGMENT)

#if __VERSION__ >= 130
#define COMPAT_VARYING in
#define COMPAT_TEXTURE texture
out vec4 FragColor;
#else
#define COMPAT_VARYING varying
#define FragColor gl_FragColor
#define COMPAT_TEXTURE texture2D
#endif

#ifdef GL_ES
#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif
#define COMPAT_PRECISION mediump
#else
#define COMPAT_PRECISION
#endif

uniform COMPAT_PRECISION int FrameDirection;
uniform COMPAT_PRECISION int FrameCount;
uniform COMPAT_PRECISION vec2 OutputSize;
uniform COMPAT_PRECISION vec2 TextureSize;
uniform COMPAT_PRECISION vec2 InputSize;
uniform sampler2D Texture;
COMPAT_VARYING vec4 TEX0;


// compatibility #defines
#define Source Texture
#define vTexCoord TEX0.xy

#define SourceSize vec4(TextureSize, 1.0 / TextureSize) //either TextureSize or InputSize
#define OutSize vec4(OutputSize, 1.0 / OutputSize)

#ifdef PARAMETER_UNIFORM
uniform COMPAT_PRECISION float glow;

#else
#define glow 0.1    
    
#endif

#define psx vec2(SourceSize.z,0.0)

void main()
{

vec3 res = COMPAT_TEXTURE(Source,vTexCoord).rgb;

vec3 res0 = COMPAT_TEXTURE(Source,vTexCoord).rgb*0.468;
res0 += COMPAT_TEXTURE(Source,vTexCoord+psx).rgb*0.236;
res0 += COMPAT_TEXTURE(Source,vTexCoord-psx).rgb*0.236;
res0 += COMPAT_TEXTURE(Source,vTexCoord-2.0*psx).rgb*0.03;
res0 += COMPAT_TEXTURE(Source,vTexCoord+2.0*psx).rgb*0.03;


FragColor.rgb = res+glow*res0;    
}
#endif
EOF


# --- Create Glow_Y shader file ---
	cat > $SHADERPATH/shaders_glsl/crt/shaders/crt-consumer/glow_y.glsl << 'EOF'
#version 110

#pragma parameter glow "Glow strength" 0.08 0.0 1.0 0.01

#define pi 3.1415926535897932384626433

#if defined(VERTEX)

#if __VERSION__ >= 130
#define COMPAT_VARYING out
#define COMPAT_ATTRIBUTE in
#define COMPAT_TEXTURE texture
#else
#define COMPAT_VARYING varying 
#define COMPAT_ATTRIBUTE attribute 
#define COMPAT_TEXTURE texture2D
#endif

#ifdef GL_ES
#define COMPAT_PRECISION mediump
#else
#define COMPAT_PRECISION
#endif

COMPAT_ATTRIBUTE vec4 VertexCoord;
COMPAT_ATTRIBUTE vec4 COLOR;
COMPAT_ATTRIBUTE vec4 TexCoord;
COMPAT_VARYING vec4 COL0;
COMPAT_VARYING vec4 TEX0;


vec4 _oPosition1; 
uniform mat4 MVPMatrix;
uniform COMPAT_PRECISION int FrameDirection;
uniform COMPAT_PRECISION int FrameCount;
uniform COMPAT_PRECISION vec2 OutputSize;
uniform COMPAT_PRECISION vec2 TextureSize;
uniform COMPAT_PRECISION vec2 InputSize;

// compatibility #defines
#define vTexCoord TEX0.xy
#define SourceSize vec4(TextureSize, 1.0 / TextureSize) //either TextureSize or InputSize
#define OutSize vec4(OutputSize, 1.0 / OutputSize)

#ifdef PARAMETER_UNIFORM
uniform COMPAT_PRECISION float SIZE;

#else
#define SIZE     1.0      
   
#endif

void main()
{
    gl_Position = MVPMatrix * VertexCoord;
    TEX0.xy = TexCoord.xy;

}

#elif defined(FRAGMENT)

#if __VERSION__ >= 130
#define COMPAT_VARYING in
#define COMPAT_TEXTURE texture
out vec4 FragColor;
#else
#define COMPAT_VARYING varying
#define FragColor gl_FragColor
#define COMPAT_TEXTURE texture2D
#endif

#ifdef GL_ES
#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif
#define COMPAT_PRECISION mediump
#else
#define COMPAT_PRECISION
#endif

uniform COMPAT_PRECISION int FrameDirection;
uniform COMPAT_PRECISION int FrameCount;
uniform COMPAT_PRECISION vec2 OutputSize;
uniform COMPAT_PRECISION vec2 TextureSize;
uniform COMPAT_PRECISION vec2 InputSize;
uniform sampler2D Texture;
COMPAT_VARYING vec4 TEX0;


// compatibility #defines
#define Source Texture
#define vTexCoord TEX0.xy

#define SourceSize vec4(TextureSize, 1.0 / TextureSize) //either TextureSize or InputSize
#define OutSize vec4(OutputSize, 1.0 / OutputSize)

#ifdef PARAMETER_UNIFORM
uniform COMPAT_PRECISION float glow;

#else
#define glow 0.1     
    
#endif

#define psy vec2(0.0,SourceSize.w)
#define size_x int(glow)

void main()
{

vec3 res = COMPAT_TEXTURE(Source,vTexCoord).rgb;
vec3 res0 = COMPAT_TEXTURE(Source,vTexCoord).rgb*0.468;
res0 += COMPAT_TEXTURE(Source,vTexCoord+psy).rgb*0.236;
res0 += COMPAT_TEXTURE(Source,vTexCoord-psy).rgb*0.236;
res0 += COMPAT_TEXTURE(Source,vTexCoord-2.0*psy).rgb*0.03;
res0 += COMPAT_TEXTURE(Source,vTexCoord+2.0*psy).rgb*0.03;


FragColor.rgb = res+glow*res0;    
}
#endif
EOF


# --- Create CRT-Consumer shader config file ---
	cat > $SHADERPATH/shaders_glsl/crt/shaders/crt-consumer/crt-consumer.glsl << 'EOF'
#version 110

/* 
crt-consumer by DariusG 2022-2023


This program is free software; you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the Free
Software Foundation; either version 2 of the License, or (at your option)
any later version.
*/

// Parameter lines go here:
#pragma parameter bogus0 " [ CRT-CONSUMER ] " 0.0 0.0 0.0 0.0
#pragma parameter sharpx "Sharpness Horizontal" 2.0 1.0 5.0 0.1
#pragma parameter sharpy "Sharpness Vertical" 3.0 1.0 5.0 0.1
#pragma parameter bogus_geo " [ GEOMETRY ] " 0.0 0.0 0.0 0.0
#pragma parameter warpx "Curvature X" 0.03 0.0 0.12 0.01
#pragma parameter warpy "Curvature Y" 0.04 0.0 0.12 0.01
#pragma parameter corner "Corner size" 0.03 0.0 0.10 0.01
#pragma parameter smoothness "Border Smoothness" 600.0 25.0 600.0 5.0
#pragma parameter vignette "Vignette On/Off" 1.0 0.0 1.0 1.0
#pragma parameter bogus_scan " [ SCANLINES/MASKS ] " 0.0 0.0 0.0 0.0
#pragma parameter scanlow "Beam low" 6.0 1.0 15.0 1.0
#pragma parameter scanhigh "Beam high" 8.0 1.0 15.0 1.0
#pragma parameter inter "Interlacing Toggle" 1.0 0.0 1.0 1.0
#pragma parameter scan_type "Scanline Type, pronounced/soft"  2.0 2.0 3.0 1.0 
#pragma parameter beamlow "Scanlines dark" 1.35 0.5 2.5 0.05 
#pragma parameter beamhigh "Scanlines bright" 0.9 0.5 2.5 0.05 
#pragma parameter Shadowmask "Mask Type" 0.0 -1.0 8.0 1.0 
#pragma parameter masksize "Mask Size" 1.0 1.0 2.0 1.0
#pragma parameter MaskDark "Mask dark" 0.5 0.0 2.0 0.1
#pragma parameter MaskLight "Mask light" 1.5 0.0 2.0 0.1
#pragma parameter slotmask "Slot Mask Strength" 0.0 0.0 1.0 0.05
#pragma parameter slotwidth "Slot Mask Width" 2.0 1.0 6.0 0.5
#pragma parameter double_slot "Slot Mask Height: 2x1 or 4x1" 1.0 1.0 2.0 1.0
#pragma parameter slotms "Slot Mask Size" 1.0 1.0 2.0 1.0
#pragma parameter bogus_col " [ COLORS ] " 0.0 0.0 0.0 0.0
#pragma parameter GAMMA_OUT "Gamma Out" 2.2 0.0 4.0 0.05
#pragma parameter crt_lum "CRT Luminances On/Off" 1.0 0.0 1.0 1.0
#pragma parameter brightboost1 "Bright boost dark pixels" 1.3 0.0 3.0 0.05
#pragma parameter brightboost2 "Bright boost bright pixels" 1.05 0.0 3.0 0.05
#pragma parameter sat "Saturation" 1.0 0.0 2.0 0.05
#pragma parameter contrast "Contrast, 1.0:Off" 1.0 0.00 2.00 0.05
#pragma parameter nois "Noise" 0.0 0.0 1.0 0.01
#pragma parameter WP "Color Temperature %" 0.0 -100.0 100.0 5.0 
#pragma parameter sawtooth "Sawtooth Effect" 1.0 0.0 1.0 1.0
#pragma parameter bleed "Color Bleed Effect" 1.0 0.0 1.0 1.0
#pragma parameter bl_size "Color Bleed Size, less is more" 1.5 0.1 4.0 0.05
#pragma parameter alloff "Switch off shader" 0.0 0.0 1.0 1.0
#define pi 6.28318

#if defined(VERTEX)

#if __VERSION__ >= 130
#define COMPAT_VARYING out
#define COMPAT_ATTRIBUTE in
#define COMPAT_TEXTURE texture
#else
#define COMPAT_VARYING varying 
#define COMPAT_ATTRIBUTE attribute 
#define COMPAT_TEXTURE texture2D
#endif

#ifdef GL_ES
#define COMPAT_PRECISION mediump
#else
#define COMPAT_PRECISION
#endif

COMPAT_ATTRIBUTE vec4 VertexCoord;
COMPAT_ATTRIBUTE vec4 COLOR;
COMPAT_ATTRIBUTE vec4 TexCoord;
COMPAT_VARYING vec2 TEX0;
COMPAT_VARYING vec2 scale;
COMPAT_VARYING vec2 maskpos;

vec4 _oPosition1; 
uniform mat4 MVPMatrix;
uniform COMPAT_PRECISION int FrameDirection;
uniform COMPAT_PRECISION int FrameCount;
uniform COMPAT_PRECISION vec2 OutputSize;
uniform COMPAT_PRECISION vec2 TextureSize;
uniform COMPAT_PRECISION vec2 InputSize;

void main()
{
    gl_Position = MVPMatrix * VertexCoord;
    TEX0.xy = TexCoord.xy * 1.0001;
    scale = TextureSize.xy/InputSize.xy;
    maskpos = TEX0.xy*OutputSize.xy*scale;
}

#elif defined(FRAGMENT)

#if __VERSION__ >= 130
#define COMPAT_VARYING in
#define COMPAT_TEXTURE texture
out vec4 FragColor;
#else
#define COMPAT_VARYING varying
#define FragColor gl_FragColor
#define COMPAT_TEXTURE texture2D
#endif

#ifdef GL_ES
#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif
#define COMPAT_PRECISION mediump
#else
#define COMPAT_PRECISION
#endif

uniform COMPAT_PRECISION int FrameDirection;
uniform COMPAT_PRECISION int FrameCount;
uniform COMPAT_PRECISION vec2 OutputSize;
uniform COMPAT_PRECISION vec2 TextureSize;
uniform COMPAT_PRECISION vec2 InputSize;
uniform sampler2D Texture;
COMPAT_VARYING vec2 TEX0;
COMPAT_VARYING vec2 scale;
COMPAT_VARYING vec2 maskpos;

// compatibility #defines
#define Source Texture
#define vTexCoord TEX0.xy
#define iChannel0 Texture
#define iTime (float(FrameCount) / 2.0)
#define iTimer (float(FrameCount) / 60.0)
#define Timer (float(FrameCount) * 60.0)

#define SourceSize vec4(TextureSize, 1.0 / TextureSize) //either TextureSize or InputSize
#define OutputSize vec4(OutputSize, 1.0 / OutputSize)

#ifdef PARAMETER_UNIFORM
// All parameter floats need to have COMPAT_PRECISION in front of them

uniform COMPAT_PRECISION float warpx;
uniform COMPAT_PRECISION float warpy;
uniform COMPAT_PRECISION float corner;
uniform COMPAT_PRECISION float smoothness;
uniform COMPAT_PRECISION float scanlow;
uniform COMPAT_PRECISION float scanhigh;
uniform COMPAT_PRECISION float beamlow;
uniform COMPAT_PRECISION float beamhigh;
uniform COMPAT_PRECISION float scan_type;
uniform COMPAT_PRECISION float brightboost1;
uniform COMPAT_PRECISION float brightboost2;
uniform COMPAT_PRECISION float Shadowmask;
uniform COMPAT_PRECISION float masksize;
uniform COMPAT_PRECISION float MaskDark;
uniform COMPAT_PRECISION float MaskLight;
uniform COMPAT_PRECISION float slotmask;
uniform COMPAT_PRECISION float slotwidth;
uniform COMPAT_PRECISION float double_slot;
uniform COMPAT_PRECISION float slotms;
uniform COMPAT_PRECISION float GAMMA_OUT;
uniform COMPAT_PRECISION float sat;
uniform COMPAT_PRECISION float contrast;
uniform COMPAT_PRECISION float nois;
uniform COMPAT_PRECISION float WP;
uniform COMPAT_PRECISION float inter;
uniform COMPAT_PRECISION float vignette;
uniform COMPAT_PRECISION float alloff;
uniform COMPAT_PRECISION float sawtooth;
uniform COMPAT_PRECISION float bleed;
uniform COMPAT_PRECISION float bl_size;
uniform COMPAT_PRECISION float sharpx;
uniform COMPAT_PRECISION float sharpy;
uniform COMPAT_PRECISION float crt_lum;

#else
  
#define warpx  0.0    
#define warpy  0.0    
#define corner 0.0    
#define smoothness 300.0    
#define scanlow  6.0    
#define scanhigh  8.0    
#define beamlow  1.35    
#define beamhigh  1.05 
#define scan_type 2.0   
#define brightboost1 1.45    
#define brightboost2 1.1    
#define Shadowmask 0.0    
#define masksize 1.0    
#define MaskDark 0.5  
#define MaskLight 1.5 
#define slotmask     0.00     // Slot Mask ON/OFF
#define slotwidth    2.00     // Slot Mask Width
#define double_slot  1.00     // Slot Mask Height
#define slotms       1.00     // Slot Mask Size 
#define GAMMA_OUT 2.2
#define sat 1.0 
#define contrast  1.0   
#define nois 0.0
#define WP  0.0
#define inter 1.0
#define vignette 1.0
#define alloff 0.0
#define sawtooth 0.0
#define bleed 0.0
#define bl_size 1.0
#define sharpx 2.0
#define sharpy 3.0
#define crt_lum 1.0 

#endif


vec2 Warp(vec2 pos)
{
    pos  = pos*2.0-1.0;    
    pos *= vec2(1.0 + (pos.y*pos.y)*warpx, 1.0 + (pos.x*pos.x)*warpy);
    return pos*0.5 + 0.5;
} 


float sw (float y,float l, float x)
{
    float scan = mix(scanlow,scanhigh,y);
    float beam = mix(beamlow,beamhigh,l);
    float ex = y*(beam+x);
    return exp2(-scan*pow(ex,scan_type));
}

vec3 mask(vec2 x,vec3 col,float l)
{
    x = floor(x/masksize);        
  

    if (Shadowmask == 0.0)
    {
    float m =fract(x.x*0.4999);

    if (m<0.4999) return vec3(1.0,MaskDark,1.0);
    else return vec3(MaskDark,1.0,MaskDark);
    }
   
    else if (Shadowmask == 1.0)
    {
        vec3 Mask = vec3(MaskDark);

        float line = MaskLight;
        float odd  = 0.0;

        if (fract(x.x/6.0) < 0.5)
            odd = 1.0;
        if (fract((x.y + odd)/2.0) < 0.5)
            line = MaskDark;

        float m = fract(x.x/3.0);
    
        if      (m< 0.333)  Mask.b = MaskLight;
        else if (m < 0.666) Mask.g = MaskLight;
        else                Mask.r = MaskLight;
        
        Mask*=line; 
        return Mask; 
    } 
    

    else if (Shadowmask == 2.0)
    {
    float m =fract(x.x*0.3333);

    if (m<0.3333) return vec3(MaskDark,MaskDark,MaskLight);
    if (m<0.6666) return vec3(MaskDark,MaskLight,MaskDark);
    else return vec3(MaskLight,MaskDark,MaskDark);
    }

    if (Shadowmask == 3.0)
    {
    float m =fract(x.x*0.5);

    if (m<0.5) return vec3(1.0);
    else return vec3(MaskDark);
    }
   

    else if (Shadowmask == 4.0)
    {   
        vec3 Mask = vec3(col.rgb);
        float line = MaskLight;
        float odd  = 0.0;

        if (fract(x.x/4.0) < 0.5)
            odd = 1.0;
        if (fract((x.y + odd)/2.0) < 0.5)
            line = MaskDark;

        float m = fract(x.x/2.0);
    
        if  (m < 0.5) {Mask.r = 1.0; Mask.b = 1.0;}
                else  Mask.g = 1.0;   

        Mask*=line;  
        return Mask;
    } 

	else if (Shadowmask == 5.0)

    {
        vec3 Mask = vec3(1.0);

        if (fract(x.x/4.0)<0.5)   
            {if (fract(x.y/3.0)<0.666)  {if (fract(x.x/2.0)<0.5) Mask=vec3(1.0,MaskDark,1.0); else Mask=vec3(MaskDark,1.0,MaskDark);}
            else Mask*=l;}
        else if (fract(x.x/4.0)>=0.5)   
            {if (fract(x.y/3.0)>0.333)  {if (fract(x.x/2.0)<0.5) Mask=vec3(1.0,MaskDark,1.0); else Mask=vec3(MaskDark,1.0,MaskDark);}
            else Mask*=l;}

    return Mask;
    }

    else if (Shadowmask == 6.0)

    {
        vec3 Mask = vec3(MaskDark);
        if (fract(x.x/6.0)<0.5)   
            {if (fract(x.y/4.0)<0.75)  {if (fract(x.x/3.0)<0.3333) Mask.r=MaskLight; else if (fract(x.x/3.0)<0.6666) Mask.g=MaskLight; else Mask.b=MaskLight;}
            else Mask*l*0.9;}
        else if (fract(x.x/6.0)>=0.5)   
            {if (fract(x.y/4.0)>=0.5 || fract(x.y/4.0)<0.25 )  {if (fract(x.x/3.0)<0.3333) Mask.r=MaskLight; else if (fract(x.x/3.0)<0.6666) Mask.g=MaskLight; else Mask.b=MaskLight;}
            else Mask*l*0.9;}

    return Mask;

    }


    else if (Shadowmask == 7.0)
    {
    float m =fract(x.x*0.3333);

    if (m<0.3333) return vec3(MaskDark,MaskLight,MaskLight*col.b);  //Cyan
    if (m<0.6666) return vec3(MaskLight*col.r,MaskDark,MaskLight);  //Magenta
    else return vec3(MaskLight,MaskLight*col.g,MaskDark);           //Yellow
    }

  
     else if (Shadowmask == 8.0)
    {
        vec3 Mask = vec3(MaskDark);

        float bright = MaskLight;
        float left  = 0.0;
      

        if (fract(x.x/6.0) < 0.5)
            left = 1.0;
             
        float m = fract(x.x/3.0);
    
        if      (m < 0.333) Mask.b = 0.9;
        else if (m < 0.666) Mask.g = 0.9;
        else                Mask.r = 0.9;
        
        if      (mod(x.y,2.0)==1.0 && left == 1.0 || mod(x.y,2.0)==0.0 && left == 0.0 ) Mask*=bright; 
      
        return Mask; 
    } 
    
    else return vec3(1.0);
}

float SlotMask(vec2 pos, vec3 c)
{
    if (slotmask == 0.0) return 1.0;
    
    pos = floor(pos/slotms);
    float mx = pow(max(max(c.r,c.g),c.b),1.33);
    float mlen = slotwidth*2.0;
    float px = fract(pos.x/mlen);
    float py = floor(fract(pos.y/(2.0*double_slot))*2.0*double_slot);
    float slot_dark = mix(1.0-slotmask, 1.0-0.80*slotmask, mx);
    float slot = 1.0 + 0.7*slotmask*(1.0-mx);
    if (py == 0.0 && px <  0.5) slot = slot_dark; else
    if (py == double_slot && px >= 0.5) slot = slot_dark;       
    
    return slot;
}


mat4 contrastMatrix( float contrast )
{
    
	float t = ( 1.0 - contrast ) / 2.0;
    
    return mat4( contrast, 0, 0, 0,
                 0, contrast, 0, 0,
                 0, 0, contrast, 0,
                 t, t, t, 1 );

}


vec3 saturation (vec3 Color, float l, vec3 lweight)
{
    float lum=l;
    
    if (lum<0.5) lweight=(lweight*lweight) + (lweight*lweight);

    float luminance = dot(Color, lweight);
    vec3 greyScaleColor = vec3(luminance);

    vec3 res = vec3(mix(greyScaleColor, Color, sat));
    return res;
}


float noise(vec2 co)
{
return fract(sin(iTimer * dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

float corner0(vec2 coord)
{
                coord *= TextureSize / InputSize;
                coord = (coord - vec2(0.5)) * 1.0 + vec2(0.5);
                coord = min(coord, vec2(1.0)-coord) * vec2(1.0, InputSize.y/InputSize.x);
                vec2 cdist = vec2(corner);
                coord = (cdist - min(coord,cdist));
                float dist = sqrt(dot(coord,coord));
                return clamp((cdist.x-dist)*smoothness,0.0, 1.0);
}  

const mat3 D65_to_XYZ = mat3 (
           0.4306190,  0.2220379,  0.0201853,
           0.3415419,  0.7066384,  0.1295504,
           0.1783091,  0.0713236,  0.9390944);

const mat3 XYZ_to_D65 = mat3 (
           3.0628971, -0.9692660,  0.0678775,
          -1.3931791,  1.8760108, -0.2288548,
          -0.4757517,  0.0415560,  1.0693490);
           
const mat3 D50_to_XYZ = mat3 (
           0.4552773,  0.2323025,  0.0145457,
           0.3675500,  0.7077956,  0.1049154,
           0.1413926,  0.0599019,  0.7057489);
           
const mat3 XYZ_to_D50 = mat3 (
           2.9603944, -0.9787684,  0.0844874,
          -1.4678519,  1.9161415, -0.2545973,
          -0.4685105,  0.0334540,  1.4216174);         

float RGB2Y(vec3 _rgb) {
    return dot(_rgb, vec3(0.29900, 0.58700, 0.11400));
}

float RGB2U(vec3 _rgb) {
   return dot(_rgb, vec3(-0.14713, -0.28886, 0.43600));
}

float RGB2V(vec3 _rgb) {
   return dot(_rgb, vec3(0.61500, -0.51499, -0.10001));
}



float YUV2R(vec3 _yuv) {
   return dot(_yuv, vec3(1, 0.00000, 1.13983));
}

float YUV2G(vec3 _yuv) {
   return dot(_yuv, vec3(1.0, -0.39465, -0.58060));
}

float YUV2B(vec3 _yuv) {
    return dot(_yuv, vec3(1.0, 2.03211, 0.00000));
}

vec3 YUV2RGB(vec3 _yuv) {
    vec3 _rgb;
    _rgb.r = YUV2R(_yuv);
    _rgb.g = YUV2G(_yuv);
    _rgb.b = YUV2B(_yuv);

   return _rgb;
}

void main()
{


 float a_kernel[5];
    a_kernel[0] = 2.0; 
    a_kernel[1] = 4.0; 
    a_kernel[2] = 1.0; 
    a_kernel[3] = 4.0; 
    a_kernel[4] = 2.0; 
    
	vec2 pos = Warp(vTexCoord.xy*scale)/scale;
    vec2 tex_size = SourceSize.xy;	
    
    if (inter < 0.5 && InputSize.y >400.0) tex_size*=0.5;
  vec2 ogl2pos = pos*TextureSize.xy;
  vec2 p = ogl2pos+0.5;
  vec2 i = floor(p);
  vec2 f = p - i;        // -0.5 to 0.5
       f.x = pow(f.x,sharpx);
       f.y = pow(f.y,sharpy);
       
       p = (i + f-0.5)*SourceSize.zw;
	vec2 pC4 = p;
	vec2 fp = fract(pos*tex_size.xy);
    
    if (inter >0.5 && InputSize.y >400.0) fp.y=1.0; 
    
    vec4 res = vec4(1.0);
    
    if (alloff == 1.0) {res= COMPAT_TEXTURE(Source,pC4); 
        res = pow(res,vec4(1.0/GAMMA_OUT));
}
        else
            {
	       vec3 sample2 = COMPAT_TEXTURE(Source,pC4).rgb;
	
	vec3 color = sample2;
   //sawtooth effect
float t = sin(float(FrameCount));  
if (sawtooth == 1.0){
    if( mod( floor(pC4.y*SourceSize.y*1.0), 2.0 ) == 0.0 ) {
        color += COMPAT_TEXTURE( Source, pC4 + vec2(SourceSize.z*0.2*t, 0.0) ).rgb;
    } else {
        color += COMPAT_TEXTURE( Source, pC4 - vec2(SourceSize.z*0.2*t, 0.0) ).rgb;
    }
    color /= 2.0;}
//end of sawtooth

//color bleeding
if (bleed == 1.0){
    vec3 yuv = vec3(0.0);
    float px = 0.0;
    for( int x = -2; x <= 2; x++ ) {
        px = float(x)/bl_size * SourceSize.z - SourceSize.w * 0.5;
        yuv.g += RGB2U( COMPAT_TEXTURE( Source, pC4 + vec2(px, 0.0)).rgb ) * a_kernel[x + 2];
        yuv.b += RGB2V( COMPAT_TEXTURE( Source, pC4 + vec2(px, 0.0)).rgb ) * a_kernel[x + 2];
    }
    
    yuv.r = RGB2Y(color.rgb);
    yuv.g /= 10.0;
    yuv.b /= 10.0;


    color.rgb = (color.rgb)*0.5 + (YUV2RGB(yuv) * 1.0)*0.5;

// fix for gles half screen turning black
color =clamp(color, 0.0,1.0);
//end of color bleeding
} 
    //COLOR TEMPERATURE FROM GUEST.R-DR.VENOM
    if (WP !=0.0)
    {
    vec3 warmer = D50_to_XYZ*color;
    warmer = XYZ_to_D65*warmer; 
    vec3 cooler = D65_to_XYZ*color;
    cooler = XYZ_to_D50*cooler;
    float m = abs(WP)*0.01;
    vec3 comp = (WP < 0.0) ? cooler : warmer;
    comp=clamp(comp,0.0,1.0);   
    color = vec3(mix(color, comp, m));
    }

    vec3 lumWeighting = vec3(0.22,0.7,0.08);
	float lum=dot(color,lumWeighting);
	
    float f = fp.y;
    float x=0.0;

 if ( vignette == 1.0)   
  {  // vignette  
  x = (vTexCoord.x*SourceSize.x/InputSize.x-0.5);  // range -0.5 to 0.5, 0.0 being center of screen
  x = x*x*1.5;    // curved response: higher values (more far from center) get higher results.
}
    color = color*sw(f,lum,x) + color*sw(1.0-f,lum,x);
    
    color*=mix(mask(maskpos.xy*1.0001,color,lum), vec3(1.0),lum*0.9);
    if (slotmask !=0.0) color*=SlotMask(maskpos.xy*1.0001,color);
    
    color*=mix(brightboost1, brightboost2, lum);    
if (crt_lum == 1.0){

    // 0.29/0.24, 0.6/0.69, 0.11/0.07
     color *= vec3(1.208,0.8695,1.5714); 
   }
    color=pow(color,vec3(1.0/GAMMA_OUT));

    if (sat != 1.0) color = saturation(color, lum, lumWeighting);
    
    if (corner!=0.0) color *= corner0(pC4);
    if (nois != 0.0) color *= 1.0+noise(pC4)*nois;
	
	res = vec4(color,1.0);
	if (contrast !=1.0) res = contrastMatrix(contrast)*res;
    if (inter >0.5 && InputSize.y >400.0 && fract(iTime)<0.5) res=res*0.95; else res;
}
#if defined GL_ES
    // hacky clamp fix for GLES
    vec2 bordertest = (pC4);
    if ( bordertest.x > 0.0001 && bordertest.x < 0.9999 && bordertest.y > 0.0001 && bordertest.y < 0.9999)
        res = res;
    else
        res = vec4(0.0);
#endif

    FragColor = res;
} 
#endif
EOF

chown -R ark:ark $SHADERPATH

mkdir -p /home/ark/.config/retroarch/overlay

# --- Create GameBoy overlay config files ---
	cat > /home/ark/.config/retroarch/overlay/gb_sd.cfg << 'EOF'
overlays = 1
overlay0_overlay = gb_sd.png
overlay0_full_screen = true
overlay0_descs = 0
EOF

	cat > /home/ark/.config/retroarch/overlay/gbc_sd.cfg << 'EOF'
overlays = 1
overlay0_overlay = gbc_sd.png
overlay0_full_screen = true
overlay0_descs = 0
EOF

	cat > /home/ark/.config/retroarch/overlay/gba_sd.cfg << 'EOF'
overlays = 1
overlay0_overlay = gba_sd.png
overlay0_full_screen = true
overlay0_descs = 0
EOF

# --- Create GameBoy overlay PNG files ---
base64 -d << 'EOF' > /home/ark/.config/retroarch/overlay/gb_sd.png
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AIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAA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gAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUJgAAAAABQmAAIAAAAAIUNHvcE+L70Dn08agAAAAC8n6O6gsZQgAC4fpok/STDI8YiSXcwAAAAAB6kye2eMMi9jaF/MFhjAuD6Wd2YvSSjJJtJZknmB6M79DoBEAAAADhKP8lGkvHB2DwYG9nvDqsQaBXgGhMA108/+zdgP7fD3yzJMvvBb7U0dxABEAAAADjaqjOcSHIy90bAjQiAa08AXD9N9m/CZfbj3zK341+yf0Ou4qAACAAAABzl7gB48uDzVQhcRUABcI0JgOtnkNsBcJGkPRir1X/9g9cIgAAAAMD7uXsL8IncDoCHVwOyxgTA9XM4ALYH11bbfpvcfmCnAAgAAAC8n9UKwFXsW8W/wyFwM/vNgTUlAK6ffvZvvtWqv+R2AFzdtLMIgAAAAMD762d/IdFG7gyAh1cA2gK85gTA9TPInQHw7tV/qwC4iAAIAAAAHK3JfgAc5fZ2383cGQFHj212/EAIgOtndWMuc3u77yK3twQffhagAAgAAAAc5fCColH2O8NqDHK7PVgBuMYEwPVzJsnfy37sW630mx+MRe49GAQAAADgQZqDsTpUdBX8Vh9Hh66zpvznrZ+PHgwAAAAAeF//H3PMOOvFTVx2AAAAAElFTkSuQmCC
EOF

base64 -d << 'EOF' > /home/ark/.config/retroarch/overlay/gbc_sd.png
iVBORw0KGgoAAAANSUhEUgAABQAAAAPACAYAAABq3NR5AAAABGdBTUEAALGPC/xhBQAACklpQ0NQc1JHQiBJRUM2MTk2Ni0yLjEAAEiJnVN3WJP3Fj7f92UPVkLY8LGXbIEAIiOsCMgQWaIQkgBhhBASQMWFiApWFBURnEhVxILVCkidiOKgKLhnQYqIWotVXDjuH9yntX167+3t+9f7vOec5/zOec8PgBESJpHmomoAOVKFPDrYH49PSMTJvYACFUjgBCAQ5svCZwXFAADwA3l4fnSwP/wBr28AAgBw1S4kEsfh/4O6UCZXACCRAOAiEucLAZBSAMguVMgUAMgYALBTs2QKAJQAAGx5fEIiAKoNAOz0ST4FANipk9wXANiiHKkIAI0BAJkoRyQCQLsAYFWBUiwCwMIAoKxAIi4EwK4BgFm2MkcCgL0FAHaOWJAPQGAAgJlCLMwAIDgCAEMeE80DIEwDoDDSv+CpX3CFuEgBAMDLlc2XS9IzFLiV0Bp38vDg4iHiwmyxQmEXKRBmCeQinJebIxNI5wNMzgwAABr50cH+OD+Q5+bk4eZm52zv9MWi/mvwbyI+IfHf/ryMAgQAEE7P79pf5eXWA3DHAbB1v2upWwDaVgBo3/ldM9sJoFoK0Hr5i3k4/EAenqFQyDwdHAoLC+0lYqG9MOOLPv8z4W/gi372/EAe/tt68ABxmkCZrcCjg/1xYW52rlKO58sEQjFu9+cj/seFf/2OKdHiNLFcLBWK8ViJuFAiTcd5uVKRRCHJleIS6X8y8R+W/QmTdw0ArIZPwE62B7XLbMB+7gECiw5Y0nYAQH7zLYwaC5EAEGc0Mnn3AACTv/mPQCsBAM2XpOMAALzoGFyolBdMxggAAESggSqwQQcMwRSswA6cwR28wBcCYQZEQAwkwDwQQgbkgBwKoRiWQRlUwDrYBLWwAxqgEZrhELTBMTgN5+ASXIHrcBcGYBiewhi8hgkEQcgIE2EhOogRYo7YIs4IF5mOBCJhSDSSgKQg6YgUUSLFyHKkAqlCapFdSCPyLXIUOY1cQPqQ28ggMor8irxHMZSBslED1AJ1QLmoHxqKxqBz0XQ0D12AlqJr0Rq0Hj2AtqKn0UvodXQAfYqOY4DRMQ5mjNlhXIyHRWCJWBomxxZj5Vg1Vo81Yx1YN3YVG8CeYe8IJAKLgBPsCF6EEMJsgpCQR1hMWEOoJewjtBK6CFcJg4Qxwicik6hPtCV6EvnEeGI6sZBYRqwm7iEeIZ4lXicOE1+TSCQOyZLkTgohJZAySQtJa0jbSC2kU6Q+0hBpnEwm65Btyd7kCLKArCCXkbeQD5BPkvvJw+S3FDrFiOJMCaIkUqSUEko1ZT/lBKWfMkKZoKpRzame1AiqiDqfWkltoHZQL1OHqRM0dZolzZsWQ8ukLaPV0JppZ2n3aC/pdLoJ3YMeRZfQl9Jr6Afp5+mD9HcMDYYNg8dIYigZaxl7GacYtxkvmUymBdOXmchUMNcyG5lnmA+Yb1VYKvYqfBWRyhKVOpVWlX6V56pUVXNVP9V5qgtUq1UPq15WfaZGVbNQ46kJ1Bar1akdVbupNq7OUndSj1DPUV+jvl/9gvpjDbKGhUaghkijVGO3xhmNIRbGMmXxWELWclYD6yxrmE1iW7L57Ex2Bfsbdi97TFNDc6pmrGaRZp3mcc0BDsax4PA52ZxKziHODc57LQMtPy2x1mqtZq1+rTfaetq+2mLtcu0W7eva73VwnUCdLJ31Om0693UJuja6UbqFutt1z+o+02PreekJ9cr1Dund0Uf1bfSj9Rfq79bv0R83MDQINpAZbDE4Y/DMkGPoa5hpuNHwhOGoEctoupHEaKPRSaMnuCbuh2fjNXgXPmasbxxirDTeZdxrPGFiaTLbpMSkxeS+Kc2Ua5pmutG003TMzMgs3KzYrMnsjjnVnGueYb7ZvNv8jYWlRZzFSos2i8eW2pZ8ywWWTZb3rJhWPlZ5VvVW16xJ1lzrLOtt1ldsUBtXmwybOpvLtqitm63Edptt3xTiFI8p0in1U27aMez87ArsmuwG7Tn2YfYl9m32zx3MHBId1jt0O3xydHXMdmxwvOuk4TTDqcSpw+lXZxtnoXOd8zUXpkuQyxKXdpcXU22niqdun3rLleUa7rrStdP1o5u7m9yt2W3U3cw9xX2r+00umxvJXcM970H08PdY4nHM452nm6fC85DnL152Xlle+70eT7OcJp7WMG3I28Rb4L3Le2A6Pj1l+s7pAz7GPgKfep+Hvqa+It89viN+1n6Zfgf8nvs7+sv9j/i/4XnyFvFOBWABwQHlAb2BGoGzA2sDHwSZBKUHNQWNBbsGLww+FUIMCQ1ZH3KTb8AX8hv5YzPcZyya0RXKCJ0VWhv6MMwmTB7WEY6GzwjfEH5vpvlM6cy2CIjgR2yIuB9pGZkX+X0UKSoyqi7qUbRTdHF09yzWrORZ+2e9jvGPqYy5O9tqtnJ2Z6xqbFJsY+ybuIC4qriBeIf4RfGXEnQTJAntieTE2MQ9ieNzAudsmjOc5JpUlnRjruXcorkX5unOy553PFk1WZB8OIWYEpeyP+WDIEJQLxhP5aduTR0T8oSbhU9FvqKNolGxt7hKPJLmnVaV9jjdO31D+miGT0Z1xjMJT1IreZEZkrkj801WRNberM/ZcdktOZSclJyjUg1plrQr1zC3KLdPZisrkw3keeZtyhuTh8r35CP5c/PbFWyFTNGjtFKuUA4WTC+oK3hbGFt4uEi9SFrUM99m/ur5IwuCFny9kLBQuLCz2Lh4WfHgIr9FuxYji1MXdy4xXVK6ZHhp8NJ9y2jLspb9UOJYUlXyannc8o5Sg9KlpUMrglc0lamUycturvRauWMVYZVkVe9ql9VbVn8qF5VfrHCsqK74sEa45uJXTl/VfPV5bdra3kq3yu3rSOuk626s91m/r0q9akHV0IbwDa0b8Y3lG19tSt50oXpq9Y7NtM3KzQM1YTXtW8y2rNvyoTaj9nqdf13LVv2tq7e+2Sba1r/dd3vzDoMdFTve75TsvLUreFdrvUV99W7S7oLdjxpiG7q/5n7duEd3T8Wej3ulewf2Re/ranRvbNyvv7+yCW1SNo0eSDpw5ZuAb9qb7Zp3tXBaKg7CQeXBJ9+mfHvjUOihzsPcw83fmX+39QjrSHkr0jq/dawto22gPaG97+iMo50dXh1Hvrf/fu8x42N1xzWPV56gnSg98fnkgpPjp2Snnp1OPz3Umdx590z8mWtdUV29Z0PPnj8XdO5Mt1/3yfPe549d8Lxw9CL3Ytslt0utPa49R35w/eFIr1tv62X3y+1XPK509E3rO9Hv03/6asDVc9f41y5dn3m978bsG7duJt0cuCW69fh29u0XdwruTNxdeo94r/y+2v3qB/oP6n+0/rFlwG3g+GDAYM/DWQ/vDgmHnv6U/9OH4dJHzEfVI0YjjY+dHx8bDRq98mTOk+GnsqcTz8p+Vv9563Or59/94vtLz1j82PAL+YvPv655qfNy76uprzrHI8cfvM55PfGm/K3O233vuO+638e9H5ko/ED+UPPR+mPHp9BP9z7nfP78L/eE8/stRzjPAAAAIGNIUk0AAHomAACAhAAA+gAAAIDoAAB1MAAA6mAAADqYAAAXcJy6UTwAAAAJcEhZcwAADsQAAA7EAZUrDhsAADWjSURBVHic7d15kKVlff/9zzm9zAx7ZAgwDDDK4oBoAFMK+ANbRxkkyw/UGDWWz1Olj39YoQwkJhJ9TNxIaWmKRE2smKWeVEKkAiKiyDLD9IjiEjEuqGEVEQYFYTZgmF7O/fxx+vR0M9Mz3Q0Dw/f3elXd1We5z9X3Yeh/3nVd99VK0gQAAAAAnqRWq5WmkZr2NP3P9AWwS79Icl+STpLRJGMTx9THnYnDXxgAAAAwH31J2um2oqnHwMTRTnJIksOeqQtk/gTAPd9DSX6SbujbkuTxKT+3Thy9GCgAAgAAAHPVyrbYt2DKsSjJwiR7TbzfigD4rCQA7vl6M//GJ46pMwBHnvBTAAQAAADmqpVtKwtb6c7260u3P/RaRCbO4VlIANzzjaY7228syWPpzv7bMvF46izAkQiAAAAAwNy1kgxOHL1VhuPZdsuxpBsER5+Rq+NJEwD3fOPpxr7xdMPfo9kWAqdGQAEQAAAAmI9eAFyQbQFw6l4DvXsDCoDPUgLgnm/qDMCps/8enTgenzgEQAAAAGA+Wune/29htt2GrJnyngD4LCcA7vnG0g18vRmAvfj3SKbPBBQAAQAAgPnoBcCpS397r/fuB9h7n2chAXDP10l3iW8vBPaC3xNnAW6NAAgAAADMXW8JcC/+TQ1/vd2BOxPv8ywkAO75xrJtl99eAJw6E3DqfQAFQAAAAGCuWtl237/e896y34F042AnZgA+awmAe75OtgXAkYlja7aFwF4UFAABAACA+Whl2+y+3qy/3qYgvRbRxAzAZy0BcM/Xm2I7nm1/dL0gOPqE5wIgAAAAMFetiZ+9e/0NZnqDGEt3RmBnh59mjycAPjs0czgAAAAA5kpzKKz9TF8AAAAAALD7CIAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAA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51/72teyfv36eY111llnTbumSy+9dF7jAAAAAMDuMOMmIEmyOslhTZNDWq38epJ9d3BOL/pNXfY7GQAnHm9NN/5tSXJH0+QHTTP5mdlqtVpZuXLl5POrrroq99577xxG2ObUU0+dHOu6667LxRdfPK9x2u32tGu6/PLL84tf/GJeYwEAAADA7rDTGYCtdjt3tNu5rtPJvUn3nn1NM7khyNQZf1Pv+TfeW/abbvzbmm78u69p8q1OJ6tarV3uKvxEZ555Zt785jcnSa644or87d/+7Zw+39Nut3Peeecl6c7Yu/jii/PQQw/Na6zXvOY1ef3rX58kueyyy/J3f/d38xoHAAAAAHaXnc4AHOt08u3+/vT39+c/t27N77XbOTTJvk2TtFrTZv016Ya/sWyb/bd14ucjTZMfdjq5qWnyb319abdac7p33+DgYM4///wk3Wh3/vnnz/vef29+85tz7rnnZnh4OMPDw/nKV74yr3EWLlw47Zre9a53ufcfAAAAAHucnQbATtNkdHw8Nw8MZL9f//U89MADOSXJKUkOnJjF1yRpWq00EzP+RpOMN022pnu/v42dTr7XNLlxYCBXdzrp6+vLyMjInC7yfe97X1auXJnh4eG85z3vyc9+9rN5fdnnPe95edvb3pbh4eF873vfywc+8IF5jZMk73//+7NixYoMDw/nggsuyLp16+Y9FgAAAADsLjsNgEl3FuCmLVvyzYGBNHvvnZH99svD69fnRSMj2b/TyT5JBlutjCeTAXAkycOtVu5st3PPokVZf+ihufGXv0zfyEi2zDH+nXfeeTn99NOzevXqvPOd78xtt902n++ZpUuX5h/+4R+SJNdcc00++tGPzmucJLngggty6qmnZvXq1XnHO96Ru+66a95jAQAAAMDutMsAmHRnAt6/cWMO2Guv3NDp5NhXvCK3PPBA+jZuzAEbN2bhyEg6TZPxJCN9fRkbGMjGAw7IxgMPzCW33ZZHHnww6x99dE67/rZarfzpn/5pXv3qV+e///u/8+EPfzgPP/zwvL7k8uXL84lPfCKbN2/OP//zP+eqq66a1zitVivvfe97MzQ0lJtvvjkf+tCHsnHjxnmNBQAAAABPh1bmthlvWq1W9lu4MAfvt1/e9apXdWcANk064+PpTGz+8cjWrfnbr389Dz/2WDY8+mjG5nlvvH333Tfj4+N57LHH5vX5nsHBwQwODmZkZGTOy493dE1jY2PZsmXLkxpnDq5J8vl0J1duSHdlde94JMlj6e6xMpI5/lsCAAAApNuHBpIsSrJ3kn2S7Jtkv4njgCSDSVYmed1OB2q10sxhAhhPj1nNAJyqaZps3LIlm7ZsyXmXXJKBvr4MtNuT9wMc63QyOjaW8afgH3vz5s1PeowkT0n463mqrgkAAAAAng5zDoA9TboxcOvYWLY+hRcEAAAAADx12s/0BQAAAAAAu48ACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFCYAAAAAAUJgACAAAAACFlQiArVbrmb4EAAAAANgj9c/1AxdddNHk46Zpcvfdd2fdunX55je/mYceemjmX9TfnxUrVuTss8/OAQcckCTZsGFD1q5dmy996UsZGRnZ7jPnnXdeDjvssHz605/Oz3/+8x2O29fXl8suuyx33HFH3v3ud8/4+3/rt34rL3vZy3LllVfmW9/6Vg466KCcf/75M55/+eWX5+abb06SLF68OBdccMHke7/85S9z33335aabbsq6detmHAMAAAAA9gTNXI41a9Y0O7JmzZrmD/7gD3b4mZNOOqlZtWrVDj/X++zpp5++3efOOeecpmma5s/+7M9mvJ5XvOIVk2Pst99+M5537bXXNmvWrGkOOOCAJklz1FFHzXg9TdM0b33rWyc/u2zZshmve2fX9hQdX0ny/yT5v5Ock+SVSX4zybFJliQ5IMmCJKZBAgAAAPPRSjKYZP90W8OxSV6c5BVJ/neS/yvdNnFZdtExWq3W7u4kjnkc81oC3Ol08vu///t54QtfmHPOOSdr1qzJ0NBQ3v72t+f444+fdu4ZZ5yRv/7rv87AwEA+9rGP5YgjjsiCBQuyYMGCHHbYYXnf+96XdrudD37wg3nta1877bPXXHNNhoeHc8YZZ8y4zPecc85JkgwNDeWVr3zlDs9ZunRpBgcHc88992TDhg1Jkre+9a1Jkk9+8pM5/PDDc8ghh2TJkiVZsmRJli5dmksvvXTy8+Pj40mSL3/5yznhhBNy2mmn5aKLLsqyZcty1lln5SUvecmc/xsCAAAAwNNlTsVwzZo1zdjYWDMwMDDt9SuvvLJpmqa54IILJl/bf//9mzVr1jRr165tzjzzzBnHfPnLX96sXbu2WbNmTbN06dJp7336059umqZpTjjhhO0+t9dee02bkfif//mfOxz/ne98Z9M0TbNy5crJ1z7wgQ80TdM0559//i6/8+GHH940TdN88pOfnPb6Bz/4waZpmuaiiy7anZXWDEAAAABgdzIDsPgx701A+vun3z7ws5/9bJLkqKOOmnztj//4jzM0NJQrrrgi11133YxjrV27Np/97GczNDSU97///dPe+7d/+7ckybnnnrvd584666wMDQ3l7rvvzubNm7N48eIccsgh25332te+NsPDw1m7du127/X19e3kW+783C9+8YtJkiOPPHLWYwAAAADA02neAXBsbGza814E27x5c5JuIDz99NOzdu3a/OM//uMux/vc5z6Xa665Jsccc8zkJiFJ8l//9V9ZvXp1Xvayl6Xdnn65r3vd65IkH/3oR3PVVVdlaGgoZ5999rRzjjrqqPT19eUHP/hBHn/88e1+b29572w88dyjjz46SXdTEAAAAADYE807AB500EFptVppt9s59thj81d/9VdJkhtvvDFJcsQRR2RoaCj33HNPHnnkkV2ONzY2lptvvjlDQ0NZvnz5tNe//e1vZ+XKlTn22GMnX1+8eHGWLFmShx9+OJ/5zGfy9re/PcPDw5NRsOfss8/O0NBQLrnkkhm/x8DAQNrtdvr6+tLX15eBgYEdnrt48eLsv//+WbRoUV7wghfkve99b4aHh3PFFVfs8vsBAAAAwDNhXgGwr68vt99+ezZs2JANGzbk1ltvzb777purr746X/nKV5Iky5YtS5Lceuutsx73/vvvT5IceOCB017/93//9wwPD+fNb37z5Gu9sNd7bcuWLbn11luz1157TVuG/Nu//dsZHh7OzTffPG3MpmmSJBdeeGFGRkYyPj6esbGxjI2N5brrrsuLX/zi7a7vjW98YzZs2JDHHnsst9xyS0444YRcf/31k9ETAAAAAPY0/bs+Zcf22muvJMnw8HA2b96c66+/Pn//93+fTqeTJFm0aFGSZGRkZNZj9qJcb4yeH/3oRxkfH89pp52WdrudTqeTc889d7v7+v3TP/1Tvv3tb+fKK6/MCSeckOc973kZHBzMjTfeuN2S5Z7Vq1dn06ZN05b39vf37/C6O53OtGXIDz74YC666KJZfz8AAAAAeCbMadeQNWvWNKtWrWoOOuigpt1ub7cbcO94wQte0DRN03zmM5+Z9djvec97mqZpmhUrVmz33p/8yZ80TdM0xx9/fHPooYc2a9asaT760Y9O39Gk3W6uvfbaZnR0tDn77LObb3zjGzPuILxs2bKmaZrmL/7iL3Z5Xb1dgD/ykY807Xa7Wbp0abNp06amaZrmTW960+7eqcUuwAAAAMDuZBfg4se8lgCPj4/nwQcfTKfTyejo6A7PueeeezI8PJznPve5223eMZOXvvSlGR4e3uGy4SuvvDLDw8O59tprJ2f9PfG+fp1OJzfccEP6+/vzoQ99KC9+8Ytz7bXX5sc//vGMv3PTpk2zurbeuZ1OJ/fee28OOuigjIyM5B3veEde+MIXznoMAAAAAHg6zXsTkF3ZvHlzfvrTn+bMM8/Mq171ql2ef8opp+Q5z3lONmzYkHvvvXe793v3HFy6dGmOOeaYjIyM5Pvf//5251166aUZHh7OySefnIGBgaxatWq7JcVT9fX1zfo7TT1369atOe2005IkH/7wh2c9BgAAAAA8neYVAHv36tuVj3/84xkeHs573/veLFmyZMbzfu3Xfi0XXXRROp1OPvWpT8143pe//OXJx1dfffUOz7n77ruzfv36JN37E37+85/f6TXONINxNm6++ebceuut2W+//fKmN71p3uMAAAAAwO6y22YAJsmPf/zjfOELX0in08kll1yS008/fbtzfvM3fzOXXXZZWq1WbrrppqxevXrG8a699toMDw9neHg4l19++Yzn9d5bv3597rrrrp1e48EHH5yFCxemv78/AwMDGRgYyODg4KyXLX/wgx9MkrzjHe/I3nvvPavPAAAAAMDTZV67AC9YsCCtVmtWMwH/5m/+JuPj43nd6143uVT29ttvT5IcffTRabVa6XQ6Wb169S6X0v785z/P5s2bMz4+vsNlwj1XXXVVhoeHc8MNN8x4Tm8574UXXpgLL7xwu/cvu+yy/N7v/V6STMbAhQsXbnfeunXrcv311+cjH/lI/vIv/zLvfve7d/odAAAAAODpNOcA+NOf/jRjY2OzXgacJJ/61KeyatWqvOtd78ry5cvztre9LUl3ie5PfvKTfPrTn84tt9wyq7G+/OUvZ8uWLTs9Z9OmTfnVr36Vq666asZztm7dmn/5l3+Z8f077rhj2rn/+q//mvvuu2+H51588cU5+uijs3Tp0hx++OH5+c9/votvAQAAAABPj1a62wE/bQYHBzMwMJCke/+9kZGROX1+tjMPBwYGntT9/fYg1yT5fJLRJBuSbJpyPJLksSRbkozkaf63BAAAAEpoJRlIsijJ3kn2SbJvkv0mjgOSDCZZmeR1Ox1olt2Gp9e8lgA/GSMjI3OOflPN9n+iIvEPAAAAAJ6U3boJCAAAAADwzBIAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKAwARAAAAAAChMAAQAAAKCw/mf6AtilVpK+JJ10/71mOjpJmmfoGgEAAIBnr1Z23hz6Jo7WM3WBPDkC4J6vne6/U5NkcOJYMHGMJhmfeK8VARAAAACYu1a29YbBHTweyLYQyLOQALjn60v3j62dZCTJwnTD31i6s/4y8V5fBEAAAABg7noBcGGSvZLsPfG4dyxINwIKgM9SAuCery/dP7T+dKPfWLbN+ku2xb+BCIAAAADA3LXS7QqL0g2AU39ODYA60rOUf7g9X3+6f2w7in9JN/71pzs7UAAEAAAA5mpqAOzFv70nfvZmAfbuB8izkH+4Pd/UANjJ9M0+pt6kUwAEAAAA5mPqPQB7EbAXAHuzAAXAZzH/cHu+/nT/2MbSDXy9DT9a6S7/HUj3j1QABAAAAOajFwB79wGcOhOw97g/3QbBs5AAuOfrzQAcn3jeC3+93YF7hX40AiAAAAAwd70Vhgsmjt6y30URAEsQAPd8A+kW97Fsi3+9+/4NZFv8680QBAAAAJiLXgDsrTKcGgF7IVAAfBYTAPd8A+muux/P9n+Mi9Jd+rujzUEAAAAAZqt3j7/BKcfUENg38RrPQv8/Dlost2Buha8AAAAASUVORK5CYII=
EOF

base64 -d << 'EOF' > /home/ark/.config/retroarch/overlay/gba_sd.png
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ABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACRMAAQAAACBhAiAAAAAAJEwABAAAAICECYAAAAAAkDABEAAAAAASJgACAAAAQMIEQAAAAABImAAIAAAAAAkTAAEAAAAgYQIgAAAAACRMAAQAAACAhAmAAAAAAJAwARAAAAAAEiYAAgAAAEDCBEAAAAAASJgACAAAAAAJEwABAAAAIGECIAAAAAAkTAAEAAAAgIQJgAAAAACQMAEQAAAAABImAAIAAABAwgRAAAAAAEiYAAgAAAAACauIiNz6PgkAAAAAoEOtaH65ilgeAQEAAACANOQiojyWd7/yioioWb/nAwAAAAB0oFxEVEZEdUTUVEREl/V7PgAAAABAByqL5QGwKv4VADdZv+cDAAAAAHSgslh++a8ACAAAAAAJWnkGYHVFRPRYr6cDAAAAAHSklWcAVlVExKbr93wAAAAAgA6Ui+UBsCL+FQC7rd/zAQAAAAA6UC4iymN5AKysiIid1u/5AAAAAAAdKBfLLwMuj4iKXES8v37PBwAAAADoYLkV/8xFRLY+zwQAAAAAWHfK1vcJAAAAAADrjgAIAAAAAAkTAAEAAAAgYQIgAP9RcrlcVFZWRi6Xi7Kyssjlcq0/aaXnrr6PlZWV+c/qxqi6ujoqKio6dJ9VVVVRVVUVFRUV0aVLl6iqqurQ/a8vbf2eAQBgw2AREAD+I+RyuaioqIiGhoYO3++K0dTU1KH7Zv2oqamJZcuWtfl5nTp1iq5du8bcuXOjubl5HZzZ+tejR49YsGDB+j4NAADayFQFAJLVtWvXqKioiLKyssiyrMPjX0RElmXR3Nws/iVk2bJlkcvloqqqqtXZbivib01NTdTV1cXs2bOTjX81NTXRuXPn9X0aAAC0gwAIQHJWRJlly5ZFY2NjskGGdSfLsqivry96WXefPn1a4vKyZcuS/jrL5XKxySabxPvvv7++TwUAgHZwCTAASVkRbFKOMfx75XK5yLJV/3epuro66urq1tMZ/ft17tw5amtr1/dpAADQTgIgAEnIF2lK1a9fv9huu+2if//+UV9fH/3794+mpqaYPXt2lJeXx7Rp02Ly5MmxZMmSDj5rNhZlZWXR3Nwc1dXVUV9f3+6vNTYu5eXlUVVVFUuXLm1127X5GfTvVuq5bkyvaUO04ucGAGwIOnbJOwBYD9qzKunOO+8cRxxxRAwfPjy22GKL6Ny5c1RXV0dTU1N06tQpsiyLurq6yOVysXTp0li8eHFMmzYtXnjhhfjjH/8Y06dPb/UYu+yyS2y++eZr3B8wy7KWX6o//PDDGDduXJt/SRw6dGhss802ee89WFlZGU8//XTMmzevpH2Vl5fHgQceGLlcLu955HK5KC8vj8cffzwWL16cdx9DhgyJYcOGdcgssSzLomvXrvH888/HjBkzSnpO586do7y8vE2xYsXCLaWc84r3pampqeRj5HK52GuvvaJXr17R2NgY5eXlMXny5Jg2bVre7Tt16hQjRoyIsrKyaGxszLu/5ubmGDt2bMlBao899og+ffrk/TppamqKPn36xIQJE2LKlCklvab/NE1NTdGzZ894//33W/28d+nSpeD3x4aovLy81XuXlpeX5/1apDTiKQAbmswwDMMwNtZRVlZW0na5XC7r2bNntvfee2cPPvhgVltbm7VXY2NjduONN7Z6vPHjx7e6r+effz7bcsst2/y6R48eXXS/p59+esn7+uY3v9nqedbV1WUHHHBAwX3ccMMNpb59Jdt7771LOv9u3bpls2fPzhobG7MlS5aUPJYuXZotXrw4Gz9+fHbxxRdnW221VZbL5dr9tZjL5bJevXplhxxySHb33XdnixYtypqbm9d4H1977bXs4osvzrbZZpusoqKi5fmbbbZZ9sgjjxR9T+bMmZMde+yxJZ3Pdtttl02ZMqXo/ubOnZsddNBB6/37eEMfa/N1sTGPlb8+DcMwDMPY6Md6PwHDMAzDaNco9ZfybbbZJrvuuuuy8ePHZ42NjWsdprIsy6ZNm5ZVVVUVPObJJ5+cNTU1tbqfSZMmZfvtt1+bX/tzzz1XdL+/+c1vStrPoEGDskmTJrV6nnV1ddnIkSML7ufZZ58t+b0rxaxZs7KampqSXsPw4cM75JgzZszIrr/++mz33Xdv8+dj6NCh2U9+8pPsxRdfLPl4c+fOze68887sK1/5SsvX0iWXXJJ9+OGHBZ9TX1+f3XrrrVllZWWr3xu333570eM3NDRkV1xxxXr/Pt4YRnl5eavv9/o+x/aOysrKgn+RIgAahmEYRlJjvZ+AYRiGYbR5lPILd3V1dfbDH/4wmzx5crZs2bKSw0wpHn/88YLHLSsry1599dWS9vP+++9nJ510Upte+84775wtXbq06H4nTJhQ0r4uuOCCrL6+vtXzrK+vz84888y8++jTp0/2wQcflPR6S/Xiiy+W/H6cffbZHXbcZcuWZWPGjMk222yzko+/yy67ZK+88kq2ePHidh1z5syZ2WWXXZZFRLbDDjtkr7zyStHtX3jhhWzHHXds9T1p7Wv+wQcfzDp16rTev5c3llFdXZ33463FwY1hVFVV5f2ZWug1G4ZhGIax8Y3lSyUCwEake/fuRe+tVF5eHh/72MfizjvvjIsvvji23XbbqK6u7tBzGD9+fMHHTjvttNhuu+1K2s+mm24am2++eZuO/YUvfCFqamqKbrPVVltF7969i27Tu3fvOOKII6KysrKk43bt2jXvx3faaadWz6et3nrrrZK3bev7V0x1dXUceOCBMXr06Nhyyy2LbltTUxNf+tKX4m9/+1sMGzYsunTp0q5j9u3bN7773e/Gj370o/jf//3fuOmmm4p+fe+4446x/fbbF3x89913j3PPPbfo1/x7770Xt9xyS0n3EmS5rl275v1eKfX7Z0NWX1+/vk8BAFjHLAICwEbnww8/LPhYr1694rzzzosvfvGLHRqGVvf222/n/fiAAQPihBNOiIqK0v4TW11dHX369Cn5uP37949jjz221e06deoU++67b9xzzz0FtznooINi4MCBJR+7kG222SbKy8vXej8re/fdd0vedocddujQY0dEHHzwwXHttdfG2WefHe+8807ebS688MI444wzomfPnh1yzAsuuCB69eoVP/jBD+Kcc86JbbbZJu92nTt3jmOPPTbuuuuuvI+fccYZMWDAgILHaWhoiL/97W/x5z//ea3ON5fLRXV19RqxsqysLBoaGtq8eER1dXWHrDpbVlYW9fX1eRe4qKqqik022SQWLVqU97nl5eWxbNmyvIvhZFkW/fv3X+Xroby8PGpqamLZsmV5z6Oqqirvvpqbm2PTTTeNuXPntjyey+WiU6dOa5x3WVlZ1NXVtWmhoBWfmxXnHbF8QZNin5O2vO+5XC5qamrWOKcVC9g0NDTkfV5lZWWbF+spdPzm5uaC4bK8vLxlUad1qT2fGwBYXwRAAJJy9tlnxznnnBPdunVbp8d56aWX8n585MiRsc0225S8MnEulysaa1Z3yCGHRP/+/VvdrqysLIYOHVp0m+HDh5e0r9YMHjy4Q2dBNTU1xaxZs0ratnv37h0SMfPZe++948gjj4xrr712jccuueSSOPfcc6N79+4ddryKioo46qij4qWXXoqbbroprrjiioLv66hRo2L77bePSZMmrfLxzTbbLI488sjo1KlTweNMmTIlfv7zn6/1is1nnnlmfPWrX13jHCsqKmLq1Klx8MEHl7yv/v37xx/+8IcYMGDAWseUysrKmDlzZrz99tsxZcqUGDNmTDzzzDMRsXy26nXXXRd9+vTJG6FqamriqaeeipNOOmmNx+bNm7fG93V5eXksWLBgjW1zuVxcc8018ZnPfGaNGJZlWXTq1Cn+/ve/x5e+9KWWj19zzTXxuc99bo1ZmdXV1fHMM8/EiSeeWPJ7cPLJJ8d55523ytdBc3Nz/OIXv4jrr7++5P1UVFREXV3dGh/fZ5994ve//33U19ev8vmqrq6Op556Kj7/+c+vsv2oUaPipJNOimHDhuWNxm21IrxNnDgxbr/99rj//vtXefxHP/pRnHDCCet8ZmNVVVXccsstcemll67T4wBAR1nv1yEbhmEYRimje/fuBR/r27dv9oMf/KDN919rbm7O6uvrs9ra2mzRokXZ3Llzs3HjxmWPPvpo9vjjj2d///vfs/fffz9btGhRtnTp0qypqSlbtGhR1qVLl7zn0Z7VcB977LGSXn9FRUV29913r7GybD4NDQ3Z6NGjC+6rW7du2dSpU0s+x/r6+uyCCy7Iu6/bb789a2hoaPPrLmTBggUlr2K8++67Z5MnT+6wY6/uzjvvXOV4uVwuO/nkk7NZs2aV9PzGxsZs6dKlLasOl7IwzGOPPZbts88+2euvv150uyuvvHKVc+vTp082duzYos+pq6vLPvWpT63192L//v2zRx99tOixvv/975e8OMaWW26ZvfXWW62+N+3R3NycvfHGG9kll1yS7b///tmdd95ZdDGguXPnZl/4wheKfh9GLL/XZ6H7/+27777ZG2+8UfAYdXV12Wc/+9mW7UeNGlX09dfW1mZnnXVWye/neeedl82dO3eN92HRokXZlVdemfXs2bOk/dTU1OQ95kEHHVTw59DYsWNbths8eHB2//33d+jPh3xuvfXWbJtttmk57ujRoztswafW/PKXv+yQ/74ZhmEYxroeZgACsNEodOlvly5d4jvf+U6cfvrpJe+rvr4+3n333Xjvvfdi6tSp8cwzz8SUKVNiypQpMXfu3FVmqFRWVsZuu+0W++23X+y3337R1NQUS5YsWWOfvXv3jkMOOaTNr2vw4MElXfq4yy67xLbbblvS7MLy8vIYPHhw9OrVK+bOnbvG41/72tdiyJAhJZ9jWVlZDBo0aI2P9+nTJ/r27Vv0EuBXXnkl6urqSp4VOX/+/IKX3a5u8803L3qvu4ULF8aMGTOirOz/3/Y4y7KoqamJgQMHtjpzcfV7OQ4aNCjOOuuski7bnjx5ckyePDmefPLJeOONN2LnnXeO/fffP3bfffeiz//Upz4Ve+65Z7zwwgsxdOjQqKqqyrvdqFGj4pZbbomJEydGLpeLCy+8MD7xiU8U3G9DQ0Pccccd8fjjj7d67q056qijYvjw4UW3OeOMM+KVV16J++67b62PtzZyuVxsv/32cemll8Zbb70VjzzySLz55psF76PYo0eP+K//+q8YO3Zs3ntRVlZWRvfu3aNz584FL1U/6qijCs7AzbIsfvOb38S9997b8rGTTjqp6EzWmpqaOOWUU+LFF1+M5557rtjLLSiXy0XXrl3j/PPPjx133DF++ctftnoZeENDw1rN1jvvvPNi1KhRJd8Sob2OO+64aGxsjG9+85sxf/78dXosANhYCYAAbBTKy8sL3s9p9913jy984QslX/Y7efLk+OMf/xjjx4+P559/PmbOnFl0+4aGhnj++efj+eefj9/85jcFf1E/++yz4yMf+UhJ57Cy/v37x5ZbbhnTp08vut2wYcNKvt9cLpeLLl26xIABA9YIgN26dYtTTjmlzeeZL0T17NkzOnfuXDDu1dfXx1lnnRUffPBBSZcJrwihhe6xuLpBgwYVXJwkImLixIlx0UUXrRIgGhsbo3v37nHYYYfFSSedVDQgDhw4MMrKylouczz++ONj1113LXpOK+6x9/Of/zwefvjhlo8/9NBD8Ytf/CJOOOGE+Pa3v13wHn8REeeff36ccMIJcfjhhxdczGXAgAFxyCGHxMSJE+Owww6Lww8/vGhknTZtWtxyyy1Fz70UvXv3jgsvvDA6d+5cdLu+ffvGF77whRg7dmzMmzdvrY/bEQYNGhQnnnhiLFy4sOA2ZWVlsc8++8Q+++yTNwAuXbo0evToUXAfO++8c3zpS18qGL0mT54cv/vd71r+vP3228dhhx1WNJLlcrkYNmxYHH744e0OgCuUlZXFwQcfHNtuu23069cvfvOb3xTcdm3uoVdWVhaf/exn13n8i1h+6fE+++wTw4YNiyeeeGKdHw8ANlbrfRqiYRiGYRQbVVVVBS9923rrrbPXXnut1cu0mpubs/nz52c/+MEP1sk5br311tmMGTPafRnZSSed1Ooxrr322pIu/11h6tSp2eGHH77Gfr7xjW9ktbW1bTq/xsbGvJcUf+pTn8omTpxY8HlvvfXWOv3auOyyy4q+lmuuuabo8//yl78Ufd21tbUtl55//OMfzxYtWlR0+4aGhuyhhx7KysrKih73S1/6Uvbee+8VPe53vvOd7M477yx6vPvuuy/r0qVLdscddxTdbunSpdnll1++1u93jx49sttuu63osVY2c+bM7POf/3yr+12XlwC31+uvv54NHjy4Te9Pr169sj/96U8F97l06dLs+uuvb9l+wIAB2VNPPVXyOb377rvZLrvs0up55LsEOJ/6+vrsoosuWuXy2VJGKZcAH3300SW/ro6wZMmS7IQTTsgiXAJsGIZhGPmGGYAAbPAGDBhQcHbct7/97dhpp51a3cerr74aN954Y9xwww0dfHbLnXrqqQVnapVit912i9///vdFtxk2bFjJl9FGLJ+dt/pKyB/5yEfioIMOKjrrrS369OkTm266acHH//nPf3bIcQrp1atX0dfy6quvFn3+XXfdFaNGjSr4+Lx581ouPT/33HOLzjZsbm6OMWPGxGc+85lWF7K47bbb4pBDDomjjz467+PV1dWx//77x0UXXRQHHHBAwfd4iy22iGOOOSZGjhxZ9Hhjx46NH//4x0W3KcWxxx4bBx54YMnb9+3bN84///z405/+VHT17tbMnTs36urqVrmUe2VZlkWWZdGzZ8+WlWbX1o477hgXXHBBm24tcOKJJxa9DHvy5Mnx29/+tuXP559/fquXUq9s4MCB8dOf/jQ++9nPrvUiLhHLL2e+5JJLYq+99oorr7yyQ2fP7bjjjgUfy7Ismpqa2nV5cUVFRd6fg9XV1UV/Fq1s1qxZ0djYWPDrqVQ1NTVFZ5MCwIZEAARgg1coHOy///6tho+IiHHjxsV3vvOdeOyxxzr61CIiYsiQITFixIiC92pramqKxsbGoqGqtYi55ZZbxsc//vE2nVf37t2jX79+q3xs7733ju23377Nv/jmcrno27fvGh/v3bt30cuSS72Ut7023XTTgq+lvr6+1c95a5fzrrgX4fDhw2PPPfcsuu3rr78eP/3pT0taxbahoSF+/vOfx2c/+9m8saqsrCw233zz6NSpU4wZMyaOP/74vPvZbrvt4oorrigaPqZPnx7f+ta31joYVVZWxhFHHNHm0P3Rj340Lr300vj617/eruM2NjbG6NGj4/nnny8aAJubm6NPnz5RVVUV/fr1iwMPPDB23XXXtYqBhxxySBx33HFxxx13tLrtoEGD4ogjjohNNtmk4Db//d//HS+++GLLvg877LA2fy8OHz48vva1r8XPfvazNj2vkMrKyjjooINi2223jcMPPzwmT57cIfst9PMwYvm9OX/961/nvcS6kCzLokePHnHuuefm/VlUXl5eUgBsbm6OH/3oRzFz5sw2/YVKPjU1NfHKK6+s1T4A4N9FAARgg1fopu4jR45cI3CtrLm5OV599dV1Gv8iIkaMGBFDhw4t+MvkCy+8EHPnzo3DDjus4D623XbbqKmpiWXLluV9/Mtf/nJ06tSpTedVXl4em2222Sof22uvvYouNlBILpeLbt26RUVFRTQ2NrZ8fLPNNisaNidMmNDmY7VF//79Cz42Y8aMogHyiCOOKBjWIpaH2zfeeCMiIg4++OC80WGFpUuXxoMPPhhPPvlkCWe93DPPPBN/+9vfCs6o22yzzWLIkCHx5z//OT796U/nXTikU6dORb8uli1bFrfffnurMyFLcfTRR8cBBxyQN1j985//jLq6urwLa5SVlcUJJ5wQTz75ZNx9991tPm6WZTFnzpy466672vS8733ve3HeeefFRRddVPK9M1c3YMCAOPHEE2PMmDGxYMGCotvuu+++sccee+R9f7Isi/vvvz9uvfXWlo8dc8wxeRcKaWpqiqeffrrlHn2r69atWxx77LHx6KOPtsTEtVVRURFDhgyJ5557Li6//PK47bbb4oMPPuiQfefT1NQUU6ZMiZtvvrlNzxs5cmQ0NDQUfLzUmPrmm2+ucn9OAPhPsHbz3gFgHSs0e6eysjJ23XXX6NKlS8Hnzps3L6699tp1Gv8ilv9SWmxW1K9//euYMWNG0Rvqb7rpprHDDjvkfaxHjx4FLxVtzdZbb93y7926dSsaIdtjwIABBR9rbGyM2tra2HvvvWPEiBFFxwEHHBCDBw/u0OO///77kcvlonPnzi2jqqoqqqur49xzz43LL788evXqVfD5M2fOjMcffzyqqqpi5513Lnr571tvvRW33XZbm8//6aefLvhYjx49om/fvvHss8/GG2+80ebLJbMsiwkTJnTIKrw77LBDXH755XlnddXX18fdd98d1113XcHZjz179ozPf/7zawTpde3nP/95nHvuuTFjxox2PT+Xy8U+++wT+++/f9HtunbtGl//+tcLzv579913V1lsY999941Ro0blDVYzZ86M0aNHF42lO+ywQ7t/JhTTvXv3+M53vhNXX3110Rl8AMDGxwxAADZoVVVVsXTp0jU+3rlz57yzjVZ2ww03rDLjZl3o3bt30XuiTZo0Ke69997YfPPNY/HixdG9e/e825WXl8ewYcPyzug5+OCD27W6cESsMtvvC1/4QtHINm3atKioqIgtt9yy5P2vHBhXV15eHtddd11kWdbqpXbNzc1x5ZVXxo9+9KOSj929e/eiAXC33XaL999/f5XIkmVZlJWVRdeuXaOmpqboeY0ZMybuu+++6NatW2y11VZFt7399ttbZgu2xfjx4ws+Vl5eHr169Yq33nor/vrXv8Yee+zR6sq7K2tqaorrr78+xo0b1+bzWt23v/3t2GqrrfI+NmnSpLj22mtjzpw5cdhhh+W9p2JFRUUccMABsdtuu8WDDz641ufTFn/4wx/i4IMPjuOPP77gXygsWbIkampq8j7eq1evuOiii+Kee+4peIzzzjsvPvrRj+Z9rKGhIZ588slV/iLi8ssvzzu7L8uyeOaZZ+Lee++NV199NUaMGJH351ynTp3izDPPjP/zf/5Pq6uYt1XPnj3jmGOOiV122SWOOeaYmDhxYofuf218+OGHMX369Pjwww9XmYkcsfw9WX3F80KOO+64+PSnP93qCsU9e/aMO+64Ix566KF2nzMAbEjW+0okhmEYhpFvlJeXF1z9d4899sgaGhoKrsw4efLkf8s53nLLLQXPobGxMbv11luzXC6XHXvssUVXCV66dGl26aWXrrH/XC6XjR49uuhrLWbZsmXZ1ltvnX3kIx8pulrvsmXLsptvvjmbPn16wW2efvrplhVxV3x+pk2b1q7zWt3ixYuzb37zm21670eMGNEhx87n5ZdfziorK7OIyLbYYots1qxZBbdduHBhNnDgwHZ9/QwbNiyrq6sruO+rr746i4isa9euRT9/q2toaMh+/vOfd8jX+Mknn1zwa3fx4sXZoYce2rLtSSedlM2bN6/geY0bNy7vyrrFVgGur6/PvvOd76zVazjrrLOy2bNnFzyvRx99NHvzzTeLvqc/+clP8q7uPGLEiKLf29OnT8/22muvLCKysrKy7Mc//nFWX1+fd9u5c+dmn/zkJ1u+93/5y19my5YtK7jvv/zlL3m/9oqtAvz+++8XXYF6ZRMnTszOPPPMNfZfyirAl112WcH9zp07Nzv99NPX2c/ljlwFuCNWzzYMwzCMDWG4BBiADVb2r5U989l///0Lzt7IsuzfMmPj05/+dNFFSGbNmhWPPPJIZFkWkydPLnh/v4jlM6Ty3Q9s8ODBsf322xedqTJ16tSoq6vL+1h1dXV84hOfiGOPPTa22GKLgvuYO3du/PnPfy56E/3OnTuvcgnnkCFDiu6zLebPn9/me47ts88+HXLs1U2ZMiW+/OUvt9xrbMiQIUXvITdu3Lh2X2JaqsWLF6+yemxrXn755fjGN77RIcc+5phjCt5r8eGHH46//OUvLX9+/PHHY+zYsWvMzlrhYx/7WIedV1tMmjQp70ziFfr16xePPvpowe+jiOXvw+GHH77Kxzp16hQnnXRS0VsAjB49Op577rmIWP5z68gjj4zKysq8215zzTUt95HMsizuuOOOoitp77vvvnHaaacVfDyfl19+Ob71rW/F1KlTW912hx12iO9///tx4403tmn2KQCw4REAAdhgFYp/EVE0PC1YsCCmTJmyLk5pFcccc0zRX/xfeeWV+OMf/xgRERMnTiwauCoqKqJ///5r3NNw1113LXrftCzL4ve//30sWbKk4DZ9+vSJkSNHFr1f4rRp0+LBBx9s9VLdlS+R3HbbbVu9hK5Uixcvjv/93/9t03MKXXK5tudx3333rXLZ7Oabb150JdlJkya1+3hlZWUlr0R6/fXXt4SkYubOnRv/9//+35JWI27NyJEj45BDDsl7r7oZM2ascZ+69957L2688cZYtGhRwX0efvjh8dnPfnatz60tlixZUvTnySabbBI//OEPY/bs2QW3GTRoUHzuc59b5WODBw+OESNGFFwI5y9/+Uv85Cc/afnzIYccUvDWBS+++GJcc801q3zsiSeeiOuuu67gOXXt2jUOPfTQ2GWXXQpus7qKior4wx/+EF/84hdLWsF2s802i1NOOSVuueWW6NatW8nHAQA2LAIgABusYis67rTTTgUfmzNnTrzzzjsFH//c5z4Xr776avzjH/+IqVOnljTeeuutePbZZ1sWgvjYxz4WH//4x4veKH/HHXeMV155JaZOnRoTJ06MbbbZpujr7dKlyxr339t5552LrnT78ssvx9tvvx319fUFtznwwANj6623Lhiampqa4qabborGxsaS76EVEbH77ruXvG1ramtri37O8hkyZEiHHX+Frl27xvHHH7/K6sDFYnNzc3PMmjWr3ccbPnx4wdlgK/a/Ql1dXYwZM6boYjIRy1ed/tWvftXuc1ph9913j2uvvTZv/Gxubo4JEybEnXfeucZjf/3rX+OBBx4ouN8BAwbEySef/G+dUdba/R5zuVx8+OGHcckll0RtbW3BbUaOHBl77713y8fOOeecgvfBnDdvXtx1110tswo/+clPxnHHHZf351ptbW088sgjeWcp/upXv4pHHnmk4LnvtttuRVezzqe5uTmeeeaZ2HXXXeP++++PxYsXF92+srIyjjnmmHjggQfipJNOavVrEADY8FgEBIANVrFfMjt16lTwsYaGhoK/xEcsn8mz1VZbtXk2y6xZs1p+Ud5rr71i2223Lbp9Wxfu6Nq1a2y22WarLCaxxx57FI2MDzzwQEyfPr3opYv77bdf0Zl6zz33XNx1112RZVnMnDmz4GIPqyu0anFbZVkWtbW1bZoB2Ldv36ILkKyNLbfcMn7yk5/EpEmT4uWXX15lIZXV1dXVFZ192ZpiM7eamppiwYIFq3xs8eLF0dDQUHBG4ttvvx1XX3110ctdS5HL5eJrX/tawWg9c+bMuOGGG1ouk17dJZdcEnvuuWdst912azxWVlYWI0aMiJEjR8b999+/VudZqkGDBhX9Plq0aFHU19fH6NGj47DDDoujjjoq73abbbZZXHbZZTFixIg46qij4sQTT8y7XVNTUzz11FPx6KOPRsTyn1eXX355bL755nm3nzRpUtFVf2+88cbYeeed884GLisri1NPPTUefvjh+Pvf/15wH/lkWRbnnHNOnHvuuXH66ae3+jPxU5/6VGy++eZx7733tuk4AMD6JwACkJxcLlf0ks3evXu3zORri1dffbXl34888sgOn8G06aabrrIyaHl5eey1114Ft1+8eHFcc8010dzcXHQGT6HLE1e48cYbi96fcIVOnTpF//7944033ohcLtfqKsylam5ujmnTphW9bHR1w4YNKxqB19YWW2wRF154YRx33HFFL6VdtGhRzJ8/v93HOeiggwo+VltbG/PmzVvlY3379o2ampqCz/nGN74Rf/vb39p9PiscccQRse+++xachXvdddcVvc/mO++8E6NHj44f/ehHecNb9+7d48c//vG/LQDutttuBVfgjlh+6fKKv3D4/e9/H7vuumsMGjQo77b77bdfnHHGGXHqqacWvKx+yZIlcd1117XcG/K8884rOmP217/+ddHVmseMGRMTJkyIUaNG5Z3J2Lt377j00kvbHAAjln+uLrjggrjnnnvi3nvvjT59+hTdfujQoevlPo4Ry2f9fuUrX4nOnTuvcp/JXC4X1dXVce+997a6ynRzc3NcfPHFMX369FZ/Nnbu3DmefvrpDjl3AFjfBEAAklNRUVH0F7vevXuXfN+1la2419thhx0Wn/jEJ9p9foVsuummq/zyfeGFF0aPHj0Kbv/aa6/FwoULI2L5PQZ33HHHNh/zpZdeigkTJpS0bXl5eUt022abbYre/7C+vj7ee++9gotBrKy5uTn+8Y9/lHbC//LRj3604Ocwy7KYPXt2fPjhhwWf37t376ILnkRE7L333nHUUUcVDTOrf87a4qijjlrjku+VzZkzJ95///1VPtarV6+C20+aNCkefvjhdp3L6k4++eSCMyzHjx8fV1xxRav7ePjhh+PII4+MvfbaK+/naqeddopbbrklzjrrrLU+32IGDhwYw4cPLxpOV/4eeOCBB+LII4+Mj3zkI3lnzuZyubjgggsKLgyTZVncdNNNLbP/9t577zj++OMLButHHnkkbrjhhqKvYfHixXHrrbfGbrvtVvCWAMOGDYsf/OAH8cMf/rDovvJpaGiIp59+Ok466aS49NJLY4899ig6a7jYX7CsS4MGDYrjjjuu4EzKd955p9UAGLH8a7ijvlcAYGMhAAKwwaquri54aev06dNjjz32yPtYz549Y8CAAQX327dv33adz4svvhgREV/96ldbnTnSHtXV1S2X+OVyuYKXIUZENDY2rnKp8Lhx4+LYY49t0/Hq6+vj5ZdfXmWV0VJnsw0dOrRoIJg/f3584xvfiLfeeqvV2FpdXd3mRVuGDh1acL/Nzc1x3333xXXXXbfG/fWam5ujrKwsRo4cGZ/73Odi9913LxgzevbsGXvssUdLyMmnoqIiNtlkkzad+wqFLh9dYe7cufHmm2+u8rFil2fPnDmz6L0gS3XssccWXN164cKFq6z6W8zLL78c9913X+yyyy4F49fIkSPj6KOPjieeeKLd51tMRUVF/OY3vyl6qXVdXV386U9/avlzY2NjXHXVVbHLLrvEzjvvnPc5xT4PL730Ulx55ZUtfz7ssMMKXko9a9asVRYJKeauu+6K/fffP84888y8j2+yySZx+OGHxx/+8IeS9pfPI488EnV1dXHaaafF5z//+Xb9RQkAsGESAAHYYBX75XPOnDkFH+vVq1fee4+t0J7FI2pra2P8+PFx9NFHx8c//vE2P79UK0LBoYceWvQ858+fHy+99FLLn0tZHTbfPu6///5VLv8tdSbeFltsUXQW0LJly+Lpp59eqwUyihk4cGDBy1OzLIs333wzXn/99YLPf+mll+LOO++McePGFZzJ2Llz5xgwYED84x//iGXLluWdQZbL5dp8r8eI5avBfuxjHyv4eFNTU/zzn/9cY4XhQjOfIpYHw0L35CtVjx494ic/+UnBS+TfeeeduPnmm0ve389+9rMYOXJkHHDAAXkfHzBgQBx22GFrHQDLy8tbLjXu2rVrdOvWLUaOHBnf/e53iy7iEhHx7LPPxjPPPLPKx1599dU4/fTT49lnn21TBFu4cGHccsstLV/3ffr0idNPP73gXxg8/vjjMXbs2JL2nWVZfOUrX4lPf/rTMXTo0Lzb7LbbbjFq1KiiKx63ZuzYsTF27NiYOHFifO9731tnK/+WlZUVnUWcT0fNPBQ2AfhPJAACsFFaefZbPkcccURce+218fbbb6/y8crKyqitrY2333675Zfkpqam6NKlS94b7K8wffr0yOVycfjhhxe9f+DixYujrq4u7y+Yzc3NUV1dXfQX6hUxacSIEa0uWvDyyy+3/PmFF16IDz74oOiKwat75ZVXiq7WurrKysqWmVzbbbdd0UsqZ8+evcb96zrKgAEDol+/fkUvAR4/fnyr+5k+fXo88MAD8aUvfangNjU1NVFbWxv//Oc/Cy56svfee0fnzp2LLjyzuhNPPLHoLNW6uro17uU3aNCggvely7IslixZslbhp0uXLnHVVVcVDJpZlsVzzz0Xp5122iohJpfLRWNjY9xzzz3x2muvrfG8733ve7HrrrsWvHz5oIMOittvv73g+1dWVhaf+tSnYtttt837Oc+yLGpqaqJr166Ry+Wid+/eMWjQoFXup1nIwoUL45577sn72PPPPx9/+MMf4thjjy0pPK1YGXnMmDERsTz+3XbbbQUj17x582LmzJlxySWXrPLxysrKmDNnTlx99dV5n3fTTTfFD37wg4L3H7zwwgvjqquuWusY/NOf/jQiIk499dSCwbG9unbtGmeccUacfPLJJce4LMsil8sVvPQ6Ikq65UBExCmnnBLHHXfcWofAioqKWLJkSZx99tlr/X4DwLomAAKwwWpoaIhcLpc3ajz22GOxcOHCgpdfDh48OK688so1LovNsiyuuOKKyOVyLYs71NXVxahRo4rei+yDDz6InXbaKXbdddeiYe6GG26IGTNm5J2d1tTUFFtttVWcd955BZ8/ZMiQ2GSTTWLYsGFFj/PGG2+scm+6+vr6ePHFF+PQQw8t+JzV3XjjjW0KRp07d45evXpFLpeLfv36rXF57comTZpU8i/jbbXVVlsVjB8REUuXLo3JkyeXtK9i9wmMWB63Fi5cGNOmTSsYALfaaqs4++yzW4JJaw4//PA4/PDDi75/U6ZMWeNS25133rng10RtbW289957axUAR40aFSNHjix4aXcul4tjjjkmcrncGuFk3rx58Y9//CNvAHzhhRfi/vvvjy9+8Yt5vy822WSTuPjiiwsu0lFeXh4HHnhg0deWy+UKzggtpLGxMR577LH485//XHCbu+++O4YPH17Sytj19fVx2223tVy2fcYZZxS9V2j37t3j5JNPXuO8y8rKYtq0aQUD4EMPPRTHHHNMwZnIvXv3juOPP75ooC/VT3/605g0aVKcf/75se+++7YpmBVbibqqqip23XXXtT6/lTU2NhadGb5CWVlZHH300R1yzLKysli8eHF885vfFAAB2OAJgABssFbMzFuyZMkaj02bNi3eeOONoqvkHnbYYfHTn/40rrjiiliwYEFELP8l8e67715j29NPP73ouUycODF22mmngvcEi1h+Y/lvfetbRfez5557xplnnlnwnmg9e/aMXXbZpegMt4iI++67b437vU2YMKHkAPjQQw/lnflUbMXbFZFlxQIaxWZFtXVRj7ZobSXciRMnxsyZM1vdz9Zbb110Fd4sy2LRokVRV1cXU6ZMiQMOOCDv5628vDzOPvvsePDBB/MGsBUqKirikEMOibvuuqto3G1ubo7f/va38d57763y8WIxqa6uLubOnVvw8VIccsghrV4uWyjSLV26tOhr+uMf/xj77LNPbLvttnkf32233Yoet61xrzXNzc0xfvz4OOqoo4p+zd99991x0EEHxamnnlr0HLIsi9/97ncxevToiIjYdtttY9SoUUVDdXl5ecH3s9gK46+//nrceuutsd122xX8C5Bi9zxsqwceeCCeeeaZGD16dBx00EFFw/XKXnzxxZZZe/8OixYtKvl7oCMXMVlfC6IAQFt17P9NAUAHW/n+dCurq6uLcePGFXw8IqJTp05x2mmnxc033xz7779/we26dOkSO+20U8HHGxsbY9GiRXHccccV3Kauri7uuuuugo+vsGDBgjXCzupOOeWUopfyvv/++3H//fev8fGXXnqppFkoS5YsiXvvvTfvYytfVlxInz59il4GHRHx1ltvxW677RbDhw9vdey9994xfPjwVve5wuabb170Mup33nmn1X188pOfjOuuu67opY3z589vudT86aefLnpJc79+/eJnP/tZ0VlNF1xwQdxwww1FQ1nE8vs5Xn/99Wt8vNi5Ll26dI3L3dvi85//fHzuc59r9/NbM2bMmHjsscfW2azQtlhx78tPfvKTRePfCldccUWri9T885//jG9/+9stfz7xxBM7NMKtbvTo0SWv3t0R5syZE5/5zGfixhtvjA8++KCk5zz00EMxbdq0dXxm/9/06dNL+t4HgP9UZgACsEFramrKe3+1LMvijjvuiEMPPTS23nrrgs/v2bNnHHnkkbHnnnvG888/H6+99lpUVFREt27dYscdd4ylS5dG7969i17iN2/evKiuro5PfvKTBbeZNGlSPPLII62+ntra2lbvjXf00UcXnCEYEfHXv/4176Vu06dPj1mzZhVdKCIi4s033yx4j7xS7mPXp0+fojfvz7KsZWXTUmf/TJkyJc4///xVFjYppF+/fkVX3u3atWtceOGFa8y+yrIssiyL7bbbLoYPHx59+/YtOptp/vz58fjjj0dExKOPPhrPPPNMHHPMMXm3raioiBEjRsTtt98el1566Sorse69995x2WWXxa677lpwxtcKc+fOjT/+8Y9rfDyXyxUNgA0NDa2G5UIGDhwYF198cbtXMy5FlmXxy1/+MvbZZ5+is2jXpaampnjwwQfj0UcfjbvvvrvkGPnWW2/FN77xjbj99tujR48eazy+dOnSuOuuu1ouJx88eHCcddZZRb+H19bSpUvj+9//fgwbNqzgvRXbasUM36ampryPZ1kWZ599dkyePDm+/e1vtzpbtLm5Of7nf/4nvvvd77YavddWbW1tPPbYYzFx4sR1ehwA2NhlhmEYhrEhj6FDhxZ87Ktf/Wq2bNmybF2aNWtWNm7cuIKP19fXZ6NHjy7ptXTt2jW7//77230ujY2N2aGHHpp331tuuWX23HPPFX1+XV1ddvPNNxc8v+OOO67gc5cuXZpddNFF2Wc+85ls9uzZ7X4N+YwbNy7bcsstS3oPf/WrX3XosfNpamrKrrrqqlWOu/POO2e1tbWtPrexsTGbOnVqdvfdd2evvPJKVldXV/Ix77rrrqysrGyN1zxo0KBs7ty5BZ/76quvZjU1NW3+3qqqqspuuummbNmyZVlzc3O7x8yZM7NTTjml1eMdddRRWX19/Vodq9hoamrK6uvrs7q6uqy2tjZbtGhR9s4772S33nprtt9++63Vz6Fbb701a2pqWuV4WZZlEyZMyHbaaacsIrLu3btnDz300Fq/jjfffLOkc7r66quzxsbGNu374YcfLri/ioqKrLy8vNXjDhkyJJs8eXLW0NCwxvvxxBNPtGzXrVu37Ne//nU2b968bNmyZWtsvzajoaEhW7p0abZw4cLsZz/72Srn99vf/rbN70t7RpZl2eLFi7OuXbuus//+GYZhGEZHDTMAAdjgFbux+y9+8YsYPHhwnHHGGUXvm7U2evbsGZtuumnBx+fMmVNwJdHVLVmyJBYsWBBNTU3tunfUm2++2bLIwOrmz5/f6k3wFy5cuMbiEivLiiy0UFFREZWVldG9e/ei70dbNTc3x6xZs+Ldd98taftiq4B2lLFjx8all166ysdee+21uOyyy/LOLlxZeXl5DBkyJIYMGdKmY06YMCEuueSSvJel7rLLLgUX54iImDVrVtHL4Qvp1atXNDc3x7PPPhuNjY0tn/8sy6K5uXmVf0b8/1liZWVlLYuB5HK5WLx4ccyYMaPV491zzz3xu9/9LrbeeuuCM83WRmNjY7z77rvR1NQUU6dOjRdffDHGjh1b0qW+EctXmJ4zZ84a99eMWH4/wB49eqzyc6aysjLuvvvueP311yNi+Sre9fX18fjjj7f79ZWXl5f0XkYsnw289dZbR7du3UpaAKa8vDxeeeWVgo83NjZGWVlZlJeXFz3/f/zjH7HDDjvEbbfdFv3792/ZtrKycpVLkxctWtRyG4ajjjoqtthii+jXr99af+7Ly8vjgw8+iMmTJ8df//rXNWY0v/766/HUU0+t84U5KisrY9GiRRYAAWCjsd4rpGEYhmGszejTp092++23r/OZgIX87ne/yztrq9C44oorssWLF7frWPfff3/WuXPnvPvN5XLZ6NGjs4aGhoLPv/fee7PKysqC57bDDjsUfH5DQ0N26aWXZuecc067zr2QhoaG7Fe/+lXJ79/TTz/docdf3bhx47Idd9wx77H79euXPfzwwy2zfzrKE088kX3s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
EOF

chown -R ark:ark /home/ark/.config/retroarch/overlay
touch "$FLAG"
sleep 1
}

# =======================================================
# Gamepad Setup
# =======================================================
export SDL_GAMECONTROLLERCONFIG_FILE="/opt/inttools/gamecontrollerdb.txt"
chmod 666 /dev/uinput
cp /opt/inttools/keys.gptk "$TMP_KEYS"
sed -i 's/^x = .*/x = space/' "$TMP_KEYS"
sed -i 's/^y = .*/y = space/' "$TMP_KEYS"
if grep -q '^b = backspace' "$TMP_KEYS"; then
    sed -i 's/^b = .*/b = esc/' "$TMP_KEYS"
    sed -i 's/^a = .*/a = enter/' "$TMP_KEYS"
fi
start_gptkeyb

# =======================================================
# Main Execution
# =======================================================
printf "\033[H\033[2J" > "$CURR_TTY"
dialog --clear
trap exit_menu EXIT

if [[ -f "$MON_FLAG" ]]; then
	CRT="$T_90S"
	CRT_REF='#reference "../../shaders/monitor-retro.glslp"'
else
	CRT="$T_80S"
	CRT_REF='#reference "../../shaders/crt-retro.glslp"'
fi

rm -f "/home/ark/.retro_shaders"
[[ ! -f "$FLAG" ]] && create_files

main_menu

