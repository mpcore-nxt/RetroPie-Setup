#!/bin/sh
stty -echo
SERVICE='fbi'
      if ps ax | grep $SERVICE > /dev/null
  then
      sudo killall -q $SERVICE
      fi
while pgrep mpv &>/dev/null;
do sleep 1;
done
pushd "/home/pi/RetroPie/retropiemenu/Microplay/kodi" 
startx ./start-kodi.SH 
popd
startx 2>&1 >/dev/tty;
python /home/pi/RetroPie/retropiemenu/Microplay/BGM/bgmusic.py & /opt/retropie/supplementary/emulationstation/emulationstation.sh;
stty echo;sudo pkill -f bgmusic.py

