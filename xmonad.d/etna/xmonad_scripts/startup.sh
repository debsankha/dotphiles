#!/bin/bash
xrandr --output DFP1 --primary --mode 1920x1200 --output DFP6 --rotate left --right-of DFP1 --mode 1280x1024
SpiderOak &
ssh -D 12345 root@loki.debsankha.net &
