#!/usr/bin/env bash

# This file is part of The Microplay Project 
# based on The RetroPie Project
#
# only for sun8i, sun50i (like Allwinner H2+/H3/A64/H5)
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="microplay"
rp_module_desc="Microplay NXT-Base"
rp_module_section="config"

function depends_microplay() {
    getDepends mc
}

function gui_microplay() {
    while true; do
        local options=(
            10 "mpcore-nxt base installer"		
            11 "mpcore-nxt base updater"
            20 "Enable Background-Music"
            21 "Disable Background-Music"
            22 "set default Background-Music"
            23 "set default Controller config"
            24 "ES-Systems show full list"
            25 "ES-Systems show default list"
            30 "Armbian-OS Update"
            31 "Armbian-OS Setup"
            40 "Autostart boot to Desktop"
            41 "Autostart boot to Kodi"
            42 "Autostart boot to ES (default)"
            99 "Reboot System"
        )
        local cmd=(dialog --default-item "$default" --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            10)
			#mpcore-nxt base installer
		echo "install & update mpcore-nxt base"
		echo "v1.58"
		echo "#################################"
		echo "*check the packages"
		echo "*starting the installation"
		echo "#################################"
		sleep 5
			#remove old System for upgrade
		echo "remove old System for upgrade"
                rm -rf "$datadir/retropiemenu/icons"
		rm -rf "/home/pi/RetrOrangePi"
		rm -rf "/home/pi/RetroPie/retropiemenu/RetrOrangePi"
		rm -rf "/etc/splash-full.png"
		rm -rf "/etc/splash-slim.png"
			#install retropiemenu
		echo "install retropiemenu"
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/retropiemenu/." "$datadir/retropiemenu"
			#install retropiemenu iconset
		echo "install retropiemenu iconset"
                cp -rf "$scriptdir/scriptmodules/supplementary/retropiemenu/icons_nes" "$datadir/retropiemenu/icons"
			#install desktop iconset
		echo "install desktop iconset"
                cp -rf "$scriptdir/scriptmodules/supplementary/retropiemenu/icons_desktop" "$datadir/retropiemenu/icons2"
			#install desktop taskpanel and links
		echo "install desktop taskpanel and links"
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/xfce4/xfce4_links/." "/home/pi/Desktop"
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/xfce4/xfce4_taskpanel/." "/home/pi/.config/xfce4/panel"
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/xfce4/xfce4_conf/." "/home/pi/.config/xfce4/xfconf/xfce-perchannel-xml"
			#install retropiemenu gamelist
		echo "install retropiemenu gamelist"
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/retropiemenu_gamelist/." "/opt/retropie/configs/all/emulationstation/gamelists/retropie"		
			#install mpcore data
		echo "install mpcore data"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/Microplay/." "$datadir/retropiemenu/Microplay"
			#install tekcommand_png runcommand images
		echo "install tekcommand_png runcommand images"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/tekcommand_png/." "/opt/retropie/"
			#install Screensaver images
		echo "#install Screensaver images"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/Screensaver/." "/opt/retropie/configs/all/emulationstation"
			#install Splashscreens images and sounds
		echo "#install Splashscreens images and sounds"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/splashscreens/." "/home/pi/RetroPie/splashscreens"
		chmod 755 /home/pi/RetroPie/splashscreens/*
			#install Splashscreen list
		echo "#install Splashscreen list"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/splashscreenlist/splashscreen.list" "/etc/splashscreen.list"
		chmod 755 "/etc/splashscreen.list"
			#install and backup es-systems config
		echo "install and backup es-systems config"
		mv -f "/etc/emulationstation/es_systems.cfg" "/etc/emulationstation/es_systems.bkup"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/es_systems/es_systems.cfg" "/etc/emulationstation/es_systems.cfg"
		chmod 755 "/etc/emulationstation/es_systems.cfg"
			#install ES-Systemlogo
		echo "install Emulationstation system logo"
		mv -f "/opt/retropie/supplementary/emulationstation/resources/splash.svg" "/opt/retropie/supplementary/emulationstation/resources/splash.svg.bkup"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/ES-Splashscreen/splash.svg" "/opt/retropie/supplementary/emulationstation/resources/splash.svg"
		chmod 755 "/opt/retropie/supplementary/emulationstation/resources/splash.svg"
			#install ES-Audio-Fix
		echo "install ES Audio-Fix"
		mv -f "/opt/retropie/configs/all/emulationstation/es_settings.cfg" "/opt/retropie/configs/all/emulationstation/es_settings.cfg.bkup"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/ES-Audiofix/." "/opt/retropie/configs/all/emulationstation/"
		chmod 755 "/opt/retropie/configs/all/emulationstation/es_settings.cfg"
			#install retroarch configs
		echo "install retroarch configs"
		mv -f "/opt/retropie/configs/all/retroarch.cfg" "/opt/retropie/configs/all/retroarch.cfg.bkup"
		mv -f "/opt/retropie/configs/all/retroarch-core-options.cfg" "/opt/retropie/configs/all/retroarch-core-options.cfg.bkup"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/cfg_retroarch/configs/." "/opt/retropie/configs"
			#install standalone configs
		echo "install standalone configs"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/cfg_standalone/Dreamcast/." "/opt/retropie/configs/dreamcast"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/cfg_standalone/PPSSPP/." "/opt/retropie/configs/psp/PSP/SYSTEM"
			#install BGM-Script in Autostart
		echo "install BGM-Script in Autostart"
		mv -f "/opt/retropie/configs/all/autostart.sh" "/opt/retropie/configs/all/autostart.sh.bkup"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/BGM/autostart.sh" "/opt/retropie/configs/all/autostart.sh"
		chmod 755 "/opt/retropie/configs/all/autostart.sh"
			#copy boot and bios files
		echo "copy boot and bios files"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/boot/." "/boot"
			#install boost and clock fix
		echo "install boost and clock fix"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/clockfix/cpufrequtils" "/etc/default/cpufrequtils"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/clockfix/rc.local" "/etc/rc.local"
		chmod 755 "/etc/rc.local"
			#install GPIO-Base
		echo "install GPIO-Base"
		pushd /home/pi/RetroPie/retropiemenu/Microplay/GPIO/orangepi_PC_gpio_pyH3-master
		sudo python setup.py install
		popd
		sleep 5
			#install Safe-Button-Scripts
		echo "install Safe-Button-Scripts"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/Safebuttons/crontabs/root" "/var/spool/cron/crontabs"
		chown -cR root:crontab "/var/spool/cron/crontabs/root"
		chmod 644 "/var/spool/cron/crontabs/root"
			#install motd logo file
		echo "install motd logo file"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/motd_logo/." "/etc/update-motd.d"
			#install system UpdateSource
		echo "install system UpdateSource"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/system_source/." "/etc/apt"
			#set FTP-Hostname
		echo "set FTP-Hostname"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/ftp_showname/." "/etc/"
		chmod 644 "/etc/hostname"
			#change access
		echo "change access"
		chown -cR pi:pi "/home/pi/Desktop"
		chown -cR pi:pi "/etc/emulationstation"
		chown -cR pi:pi "/opt/retropie"
		chown -cR pi:pi "/home/pi/RetroPie"
		chown -cR pi:pi "/home/pi/RetroPie-Setup"
		yes microplay | passwd root
			#finish
		echo "mpcore-nxt installation successful"
		printMsgs "dialog" "mpcore-nxt base installed\n\nRestart System to apply."
		;;
            11)
			#mpcore-nxt base updater
		echo "update mpcore-nxt base"
		echo "v1.58"
		echo "#################################"
		echo "*check the packages"
		echo "*starting the update"
		echo "#################################"
		sleep 5
			#remove old files for upgrade
		echo "remove old files for upgrade"
		rm -rf "$datadir/retropiemenu/icons"
			#install retropiemenu
		echo "install retropiemenu"
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/retropiemenu/." "$datadir/retropiemenu"
			#update retropiemenu iconset
		echo "update retropiemenu iconset"
		cp -rf "$scriptdir/scriptmodules/supplementary/retropiemenu/icons_nes" "$datadir/retropiemenu/icons"
			#install desktop iconset
		echo "install desktop iconset"
                cp -rf "$scriptdir/scriptmodules/supplementary/retropiemenu/icons_desktop" "$datadir/retropiemenu/icons2"
			#install desktop taskpanel and links
		echo "install desktop taskpanel and links"
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/xfce4/xfce4_links/." "/home/pi/Desktop"
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/xfce4/xfce4_taskpanel/." "/home/pi/.config/xfce4/panel"
                cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/xfce4/xfce4_conf/." "/home/pi/.config/xfce4/xfconf/xfce-perchannel-xml"
			#update retropiemenu gamelist
		echo "update retropiemenu gamelist"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/retropiemenu_gamelist/." "/opt/retropie/configs/all/emulationstation/gamelists/retropie"		
			#update mpcore data
		echo "update mpcore data"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/Microplay/." "$datadir/retropiemenu/Microplay"
			#update tekcommand_png runcommand images
		echo "update tekcommand_png runcommand images"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/tekcommand_png/." "/opt/retropie/"
			#update Screensaver images
		echo "#update Screensaver images"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/Screensaver/." "/opt/retropie/configs/all/emulationstation"
			#update Splashscreens images and sounds
		echo "#update Splashscreens images and sounds"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/splashscreens/." "/home/pi/RetroPie/splashscreens"
		chmod 755 /home/pi/RetroPie/splashscreens/*
			#update Splashscreen list
		echo "#update Splashscreen list"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/splashscreenlist/splashscreen.list" "/etc/splashscreen.list"
		chmod 755 "/etc/splashscreen.list"
			#update ES-Systemlogo
		echo "update Emulationstation system logo"
		mv -f "/opt/retropie/supplementary/emulationstation/resources/splash.svg" "/opt/retropie/supplementary/emulationstation/resources/splash.svg.bkup"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/ES-Splashscreen/splash.svg" "/opt/retropie/supplementary/emulationstation/resources/splash.svg"
		chmod 755 "/opt/retropie/supplementary/emulationstation/resources/splash.svg"
			#update motd logo file
		echo "update motd logo file"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/motd_logo/." "/etc/update-motd.d"
			#update system UpdateSource
		echo "update system UpdateSource"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/system_source/." "/etc/apt"
			#update kodi configs
		echo "update kodi configs"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/cfg_retroarch/configs/ports/." "/opt/retropie/configs/ports"
			#change access
		echo "Update folders"			
		rm -rf "/home/pi/RetrOrangePi"
		rm -rf "/home/pi/RetroPie/retropiemenu/Microplay/Board-Overlays"
		rm -rf "/home/pi/RetroPie/retropiemenu/Microplay/Bezelproject"
		rm -rf "/home/pi/RetroPie/retropiemenu/Microplay/Reicast-Bugfix"
		rm -rf "/home/pi/RetroPie/retropiemenu/Microplay/Resolution"
		echo "change access"
		chown -cR pi:pi "/home/pi/Desktop"
		chown -cR pi:pi "/etc/emulationstation"
		chown -cR pi:pi "/opt/retropie"
		chown -cR pi:pi "/home/pi/RetroPie"
		chown -cR pi:pi "/home/pi/RetroPie-Setup"
			#finish
		echo "mpcore-nxt updated successful"

		printMsgs "dialog" "mpcore-nxt base updated\n\nRestart System to apply."
		;;
            20)
			#Enable BGM
		echo "Enable Background-Music"
		rm /home/pi/RetroPie/retropiemenu/Microplay/BGM/DisableMusic 2> /dev/null
		sudo sed -i -e 's/touch/python/g' /opt/retropie/configs/all/autostart.sh 2> /dev/null
		python /home/pi/RetroPie/retropiemenu/Microplay/BGM/bgmusic.py &
		printMsgs "dialog" "Background-Music enabled\n\nRestart System to apply."
		;;
            21)
			#Disable BGM
		echo "Disable Background-Music"
		sudo pkill -f bgmusic.py
		touch /home/pi/RetroPie/retropiemenu/Microplay/BGM/DisableMusic
		sudo sed -i -e 's/python/touch/g' /opt/retropie/configs/all/autostart.sh 2> /dev/null
		printMsgs "dialog" "Background-Music disabled\n\nRestart System to apply."
		;;
            22)
			#set BGM to default
		echo "set BGM to default"
		sudo pkill -f bgmusic.py
		rm -r /home/pi/RetroPie/music/*
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/music/." "/home/pi/RetroPie/music"
		chown -cR pi:pi "/home/pi/RetroPie/music"
		chmod 755 /home/pi/RetroPie/music/*
		printMsgs "dialog" "Background-Music set to default-set\n\nRestart System to apply."
		;;
            23)
			#set default Controller config
		echo "set default Controller config"
		rm "$configdir/all/emulationstation/es_input.cfg"
		printMsgs "dialog" "Controller config set to default .\n\nRestart System to apply."
		;;
            24)
			#install es_systems full list
		echo "install es_systems full list"
		mv -f "/etc/emulationstation/es_systems.cfg" "/etc/emulationstation/es_systems.bkup"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/es_systems/Full/es_systems.cfg" "/etc/emulationstation/es_systems.cfg"
		chmod 755 "/etc/emulationstation/es_systems.cfg"
		printMsgs "dialog" "ES-Systems list updated\n\nRestart Emulationstation to apply."
		;;
            25)
			#install es_systems default list
		echo "install es_systems default list"
		mv -f "/etc/emulationstation/es_systems.cfg" "/etc/emulationstation/es_systems.bkup"
		cp -rf "$scriptdir/scriptmodules/supplementary/mpcore/es_systems/es_systems.cfg" "/etc/emulationstation/es_systems.cfg"
		chmod 755 "/etc/emulationstation/es_systems.cfg"
		printMsgs "dialog" "ES-Systems list updated\n\nRestart Emulationstation to apply."
		;;
            30)
			#Armbian-OS Update
		echo "Armbian-OS Update"
		apt-get update && apt-get upgrade -y
		printMsgs "dialog" "OS updated\n\nRestart System to apply."
		;;
            31)
			#Armbian-OS Setup
		clear
		echo "Armbian-OS Setup"
		armbian-config
		;;
            40)
			#Autostart boot to Desktop
		echo "set your Autostart to Desktop"
		echo "Please wait"
		sleep 1
		cp -v /home/pi/RetroPie-Setup/scriptmodules/supplementary/mpcore/Autostart/autostart_desktop.SH /opt/retropie/configs/all/autostart.sh
		chmod 755 "/opt/retropie/configs/all/autostart.sh"
		printMsgs "dialog" "Now system will boot to Armbian Desktop by default."
		;;
            41)
			#Autostart boot to Kodi
		echo "set your Autostart to Kodi"
		echo "Please wait"
		sleep 1
		cp -v /home/pi/RetroPie-Setup/scriptmodules/supplementary/mpcore/Autostart/autostart_kodi.SH /opt/retropie/configs/all/autostart.sh
		chmod 755 "/opt/retropie/configs/all/autostart.sh"
		printMsgs "dialog" "Now system will boot to Kodi Media Center by default."
		;;
            42)
			#Autostart boot to ES
		echo "set your Autostart to ES"
		echo "Please wait"
		sleep 1
		cp -v /home/pi/RetroPie-Setup/scriptmodules/supplementary/mpcore/Autostart/autostart_emustation.SH /opt/retropie/configs/all/autostart.sh
		chmod 755 "/opt/retropie/configs/all/autostart.sh"
		printMsgs "dialog" "Now system will boot to EmulationStation by default."
		;;
            99)
			#Reboot System
		echo "...Rebooting System"
		/usr/bin/sudo /sbin/reboot
		;;
        esac
    done
}
