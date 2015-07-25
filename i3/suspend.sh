#!/bin/sh

i3lock
dbus-send --system --print-reply --dest="org.freedesktop.UPower" /org/freedesktop/UPower org.freedesktop.UPower.Suspend
auto-layout.sh
i3-bg.sh
