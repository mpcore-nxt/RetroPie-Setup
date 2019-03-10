#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# By Liontek1985
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="rpmenu-icons"
rp_module_desc="Icon-Settings for ES"
rp_module_section="config"

function depends_rpmenu-icons() {
    getDepends mc
}

function gui_rpmenu-icons() {
    while true; do
        local options=(
            1 "choose default icon set"
            2 "choose nes style icon set"
            3 "choose snes style icon set"
            4 "choose gameboy style icon set"
            5 "choose modern icon set"
        )
        local cmd=(dialog --default-item "$default" --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            1)
                rm -rf "$datadir/retropiemenu/icons"
                cp -r "$scriptdir/scriptmodules/supplementary/retropiemenu/icons" "$datadir/retropiemenu/icons"
                chown -R $user:$user "$datadir/retropiemenu/icons"
                printMsgs "dialog" "Settings menu default icons installed\n\nRestart EmulationStation to apply."
                ;;
            2)
                rm -rf "$datadir/retropiemenu/icons"
                cp -r "$scriptdir/scriptmodules/supplementary/retropiemenu/icons_nes" "$datadir/retropiemenu/icons"
                chown -R $user:$user "$datadir/retropiemenu/icons"
                printMsgs "dialog" "Settings menu nes icons installed.\n\nRestart EmulationStation to apply."
                ;;
            3)
                rm -rf "$datadir/retropiemenu/icons"
                cp -r "$scriptdir/scriptmodules/supplementary/retropiemenu/icons_snes" "$datadir/retropiemenu/icons"
                chown -R $user:$user "$datadir/retropiemenu/icons"
                printMsgs "dialog" "Settings menu snes icons installed.\n\nRestart EmulationStation to apply."
                ;;
            4)
                rm -rf "$datadir/retropiemenu/icons"
                cp -r "$scriptdir/scriptmodules/supplementary/retropiemenu/icons_gb" "$datadir/retropiemenu/icons"
                chown -R $user:$user "$datadir/retropiemenu/icons"
                printMsgs "dialog" "Settings menu gameboy icons installed.\n\nRestart EmulationStation to apply."
                ;;
            5)
                rm -rf "$datadir/retropiemenu/icons"
                cp -r "$scriptdir/scriptmodules/supplementary/retropiemenu/icons_modern" "$datadir/retropiemenu/icons"
                chown -R $user:$user "$datadir/retropiemenu/icons"
                printMsgs "dialog" "Settings menu modern icons installed.\n\nRestart EmulationStation to apply."
                ;;
        esac
    done
}