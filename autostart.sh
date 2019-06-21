#!/bin/sh
### In opensim.sh (make sure this file is chmod +x):


cd /opt/opensim/bin/
rm *.log
#exec screen -S money -D -m mono ./MoneyServer.exe
screen -DmS money mono ./MoneyServer.exe


