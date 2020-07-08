#!/bin/sh
echo "log on" > $SERVER/csgo/csgo/cfg/autoexec.cfg
echo 'hostname "CSGO Server"' >> $SERVER/csgo/csgo/cfg/autoexec.cfg
echo "sv_cheats 0" >> $SERVER/csgo/csgo/cfg/autoexec.cfg
echo "sv_lan 0" >> $SERVER/csgo/csgo/cfg/autoexec.cfg
echo "sv_password $SV_PASSWORD" >> $SERVER/csgo/csgo/cfg/autoexec.cfg
echo "rcon_password $RCON" >> $SERVER/csgo/csgo/cfg/autoexec.cfg

cd $SERVER/
./update.sh

cd $HOME/hlserver
csgo/srcds_run -game csgo -tickrate 128 -autoupdate -steam_dir ~/hlserver -steamcmd_script ~/hlserver/csgo_ds.txt $@