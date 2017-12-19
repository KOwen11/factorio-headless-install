#!/bin/bash

echo Downloading Factorio headless version 0.16.6

wget -O ~/Factorio_headless.tar.xz https://www.factorio.com/get-download/0.16.6/headless/linux64

tar xf ~/Factorio_headless.tar.xz

adduser --disabled-login --no-create-home --gecos factorio factorio

cp ~/factorio.service /etc/systemd/system/factorio.service

cp ~/factorio/data/server-settings.example.json ~/factorio/data/server-settings.json

cp ~/factorio/data/map-settings.example.json ~/factorio/data/map-settings.json

cp ~/factorio/data/map-gen-settings.example.json ~/factorio/data/map-gen-settings.json

systemctl daemon-reload

systemctl enable factorio

~/factorio/bin/x64/factorio --create ~/factorio/saves/server-save.zip --map-gen-settings ~/factorio/data/map-gen-settings.json

chown factorio:factorio ~/factorio

systemctl start factorio

systemctl status factorio
