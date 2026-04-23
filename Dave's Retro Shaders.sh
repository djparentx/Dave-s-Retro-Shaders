#!/bin/bash

# =======================================
# Dave's Retro Shaders v1.3
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

# ==============================================
# CRT Style Chooser
# ==============================================
CRT="$T_80S"
CRT_REF='#reference "../../shaders/crt-retro.glslp"'

television() {
	CRT="$T_80S"
	CRT_REF='#reference "../../shaders/crt-retro.glslp"'
}

monitor() {
	CRT="$T_90S"
	CRT_REF='#reference "../../shaders/monitor-retro.glslp"'
}

crt_style() {
    while true; do
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
            1) television ;;
            2) monitor ;;
        esac
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
input_overlay = "~/.config/retroarch/overlay/gb-4k.cfg"
input_overlay_opacity = "0.35"
input_overlay_scale_landscape = "1.070000"
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
input_overlay = "~/.config/retroarch/overlay/gb-4k.cfg"
input_overlay_opacity = "0.35"
input_overlay_scale_landscape = "1.070000"
EOF

chown -R ark:ark $CONFIGPATH/Gambatte
}

create_gbaglslp() {
# --- Create GameBoy Advance shader config file ---
mkdir -p $CONFIGPATH/mGBA
	cat > $CONFIGPATH/mGBA/gba.glslp << 'EOF'
#reference "../../shaders/gba-retro.glslp"
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
# Exit the script
# ============================================================
exit_menu() {
	trap - EXIT
    printf "\033[H\033[2J" > "$CURR_TTY"
    printf "\e[?25h" > "$CURR_TTY"
	stop_gptkeyb
    if [[ ! -e "/dev/input/by-path/platform-odroidgo2-joypad-event-joystick" ]]; then
        [ -n "$original_font" ] && setfont "$original_font"
    fi

    exit 0
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

# --- Create GameBoy overlay config file ---
	cat > /home/ark/.config/retroarch/overlay/gb-4k.cfg << 'EOF'
overlays = 1
overlay0_overlay = gb-4k.png
overlay0_full_screen = true
overlay0_descs = 0
EOF

# --- Create GameBoy overlay PNG file ---
base64 -d << 'EOF' > /home/ark/.config/retroarch/overlay/gb-4k.png
iVBORw0KGgoAAAANSUhEUgAABnAAAASKCAYAAABuEyBkAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADr8AAA6/ATgFUyQAAC1xSURBVHhe7d09z6RneYDhe2fX9no/MI4tLNkQktBFSkKUKJEipaWjo1gtFRXagooGRSCEQBENFYVFRYXlgo6OP5B0ISkpkihxQDGxY7PLetcfu2lmrGfvnbE1zcz5KMchXZpX1ytdf+DUPXPhxs1bDweswKuvvDyvAAAAAAD2unHz1ryCVdnMCwAAAAAAAM5LwAEAAAAAAIgRcAAAAAAAAGIEHAAAAAAAgBgBBwAAAAAAIObCjZu3Hs5LKHr1lZfn1SE/H2PcX8y707y3nffHGB+MMR7MBwAAAACAk9mMMS6OMS6NMZ7YzpPTPLWYL8wH9rlx89a8glURcFiNIwLOz7bh5t5HhJxdxPlgOwAAAADAeVzczr54sww3l7efX5wP7CPgsHYCDqtxRMD56Tbe7ALOoZCzfIUDAAAAAJzH8vXNR4Wby9v50nxgHwGHtRNwWI0jAs5PFgHnnQMhZxdx3t8OAAAAAHAel7Yzx5tluHl6EXC+PB/YR8Bh7QQcVuOIgPPjbbjZzS7mLF/l7CLO7hUOAAAAAHAey9c3y3iznKcX85X5wD4CDmsn4LAaRwScH40x7k4RZxdyli9y7gs4AAAAAHB2u4CzjDe7FzfLcPP0GOPKGOOr84F9BBzWTsBhNY4IOD/cBpzdzCHnncVXqgk4AAAAAHBeu4Cz+8q0Odrsws1uvjYf2EfAYe0EHFbjiIDzg224+d2ekHN3eokj4AAAAADAeS0Dzu7lzZU94ebq9vPr84F9BBzWTsBhNY4ION/fxpvdLGPOLuIIOAAAAADQMAecZbzZRZuri/nGfGAfAYe1E3BYjSMCzne3webOx4Sc+2OMdwUcAAAAADirS2OMJxdfn3Yo3Fzbfn5rPrCPgMPaCTisxhEB59vbeLObOebsvkbtnoADAAAAAGe3CziXF1+fNkeba4v5znxgHwGHtRNwWI0jAs43t8Hm9p6Qs3yBsws4H8wHAAAAAICTubgIOMsXOHO4ub79/N58YB8Bh7UTcFiNIwLO323jzW4+KuD4DRwAAAAAOK99v4EzB5zri/n7+cA+Ag5rt5kXAAAAAAAAnJeAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMZsHDx7MOwAAAAAAAM5o84t/+od5BwAAAAAAwBltfvnLfxm3b7897wEAAAAAADiTzXg4xj//4h/nPQAAAAAAAGeyGWOM1/7zX8ebb7w+/w8AAAAAAIAz2Oz+8Fs4AAAAAAAADR8GnNdf/9X49a/+49H/AgAAAAAAcHIfBpwx/BYOAAAAAABAwSMB56233hi/ef3XyxUAAAAAAAAn9kjAGWOM/3rt3+YVAAAAAAAAJ/RYwHlNwAEAAAAAADirxwLOnTu/HW+99ca8BgAAAAAA4EQeCzjD16gBAAAAAACc1d6A89pr/z6vAAAAAAAAOJG9Aed/3/zNuHv3zrwGAAAAAADgBPYGnDHGeON//nteAQAAAAAAcAIHA87t22/PKwAAAAAAAE7gYMB5++035xUAAAAAAAAncDDg3Ln923kFAAAAAADACRwMOPfu3Z1XAAAAAAAAnMDBgAMAAAAAAMB5HAw4d9+5M68AAAAAAAA4gYMB5+GDh/MKAAAAAACAEzgYcC5sLswrAAAAAAAATuBgwLny9LV5BQAAAAAAwAkcDDgAAAAAAACcx8GAc/nylXkFAAAAAADACRwMONeuf2JeAQAAAAAAcAIHA84zz/zevAIAAAAAAOAEDgac69efmVcAAAAAAACcwMGA89zzL8wrAAAAAAAATmBvwPnkJ58bV65cm9cAAAAAAACcwN6A85nf/6N5BQAAAAAAwInsDTgvvvQH8woAAAAAAIATeSzgXL16fTz77PPzGgAAAAAAgBN5LOC89Ok/nFcAAAAAAACc0GMB58WXPjuvAAAAAAAAOKFHAs61a58Yn/rUi8sVAAAAAAAAJ/ZIwPn8n//N2Gwee5QDAAAAAADACX1Ya5577oXx6c/4/RsAAAAAAIBz+zDg/Onn//rR/wAAAAAAAHAWmzHGePHFz44XXnhp/h8AAAAAAABnsBkXxviTP/ureQ8AAAAAAMCZbD73uT8ezz77/LwHAAAAAADgTDZ/8Zd/O+8AAAAAAAA4o81ms5l3AAAAAAAAnJF6AwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABAj4AAAAAAAAMQIOAAAAAAAADECDgAAAAAAQIyAAwAAAAAAECPgAAAAAAAAxAg4AAAAAAAAMQIOAAAAAABAjIADAAAAAAAQI+AAAAAAAADECDgAAAAAAAAxAg4AAAAAAECMgAMAAAAAABBz4cbNWw/nJRS9+srL8+qQb44x7owxbm8/d/O77dwdY7wzxrg3xnh3jPHBfAAAAAAAOJmLY4wnxxiXxxhPjzGujDGubufaYq5vP783H9jnxs1b8wpWRcBhNY4ION/eE27mgHNvEXDenw8AAAAAACdzaRFwLu8JOHPI+c58YB8Bh7UTcFiNIwLOd/dEm124Wb7AuS/gAAAAAMDZ7QLOU9MLnGXIWcacb80H9hFwWDsBh9U4IuB8/2PCzfIr1N4TcAAAAADgrC6NMZ6YvkLto0LON+YD+wg4rJ2Aw2ocEXB+MEWb3ezizT0BBwAAAAAy5oCz+xq1XcTZzS7mfH0+sI+Aw9oJOKzGEQHnh3vCzTz3BRwAAAAASFgGnN3XqM2zDDlfmw/sI+CwdgIOq3FEwPnRgXCzfHlzfzsCDgAAAACc1y7gPLWd5UucfSHnq/OBfQQc1k7AYTWOCDg/3hNulrOLN+8KOAAAAABwdruA8+QUcZazjDhfmQ/sI+CwdgIOq3FEwPnJItYsX9zM8ebdbbwRcAAAAADgfC5t58k9EWd+kXN5jPHl+cA+Ag5rJ+CwGkcEnJ9Or22W4WYZb3avbz6YDwAAAAAAJ3NxeoWzjDhzyLk8xvjSfGAfAYe1E3BYjSMCzs8+Jtzs4s1723gj4AAAAADA+VzczhNTxDkUcr44H9hHwGHtBBxW44iA8/OPCDfLeLN7ffNgPgAAAAAAnMxmeoUzR5w55HxhPrCPgMPaCTisxhEBBwAAAAD4f07AYe028wIAAAAAAIDzEnAAAAAAAABiBBwAAAAAAICY/wPCOyzWca7w1QAAAABJRU5ErkJggg==
EOF

chown -R ark:ark /home/ark/.config/retroarch/overlay

sleep 2
}

# =======================================================
# Clean up temporary keymap
# =======================================================
CleanupKeys() {
    rm -f "$TMP_KEYS"
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
trap 'stop_gptkeyb; CleanupKeys; exit_menu' EXIT

[[ ! -f "$SHADERPATH/gb-retro.glslp" ]] && create_files

main_menu

