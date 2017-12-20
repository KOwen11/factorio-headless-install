#!/bin/bash

while getopts ":v:u" opt; do 
	case $opt in
		v) version="$OPTARG"
		;;
		u) username="$OPTARG"
		;;
		/?)
			echo "Invalid option -$OPTARG" >&2
			exit 1
		;;
	esac
done 

if [[ ! -u ]]; then
	$username="factorio"

if [[ -v ]]; then
	wget -O ~/Factorio_headless.tar.xz https://www.factorio.com/get-download/$version/headless/linux64
	echo Downloading Factorio Headless $version
else	
	wget -O ~/Factorio_headless.tar.xz https://www.factorio.com/get-download/0.16.6/headless/linux64
	echo Downloading Factorio headless version 0.16.6
fi 

if [ ! -f "~/Factorio_headless.tar.xz" ]; then exit 1; else tar xf ~/Factorio_headless.tar.xz; fi 

if id "$username" >/dev/null 2>&1; then
	echo "user $username already exists"
else
	adduser --disabled-login --no-create-home --gecos $username $username
fi

if [ ! -f "~/factorio.service" ]; then cp ~/factorio.service /etc/systemd/system/factorio.service; fi 

if [ ! -f "~/factorio/data/server-settings.json" ]; then cp ~/factorio/data/server-settings.example.json ~/factorio/data/server-settings.json; fi 

if [ ! -f "~/factorio/data/map-settings.json" ]; then cp ~/factorio/data/map-settings.example.json ~/factorio/data/map-settings.json; fi 

if [ ! -f "~/factorio/data/map-gen-settings.json" ]; then cp ~/factorio/data/map-gen-settings.example.json ~/factorio/data/map-gen-settings.json; fi 

if [ -f "~/factorio/saves/server-save.zip"] then mv ~/factorio/saves/server-save.backup.zip; fi 
~/factorio/bin/x64/factorio --create ~/factorio/saves/server-save.zip --map-gen-settings ~/factorio/data/map-gen-settings.json

chown $username:$username ~/factorio

systemctl daemon-reload

systemctl enable factorio

systemctl start factorio

echo "verifying file names"

ls /etc/systemd/system/

ls ~/factorio/saves

ls ~/factorio/data/

systemctl status factorio
