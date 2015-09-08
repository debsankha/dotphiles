#!/bin/sh

# which screens are on?
xrandr | grep --quiet -P -z -o 'HDMI2 connected\N*\n\N*\*'
HDMI2_ON=$?
xrandr | grep --quiet -P -z -o 'HDMI3 connected\N*\n\N*\*'
HDMI3_ON=$?
xrandr | grep --quiet -P -z -o 'HDMI2 disconnected primary 1280x1024'
WAS_CASPARI_OFFICE=$?
xrandr | grep --quiet -P -z -o 'HDMI3 disconnected primary 1920x1200'
WAS_BUNSEN=$?
xrandr | grep --quiet -P -z -o 'VGA1 connected\N*\n\N*\*'
VGA1_ON=$?
xrandr | grep --quiet -P -z -o 'LVDS1 connected\N*\n\N*\*'
LVDS1_ON=$?

killall -SIGSTOP i3

# testing for caspari office
if xrandr | grep --quiet -P -z -o 'HDMI2 connected\N*\n\s*1280x1024' && xrandr | grep --quiet -P -z -o 'VGA1 connected\N*\n\s*1280x1024'; then
	# we are at caspari office
	echo "Detected caspari office."
#	if test $HDMI2_ON -ne 0 && test $VGA1_ON -ne 0
#	then
#		# switch on HDMI2 first
#		xrandr --output HDMI2 --auto
#		if test $? -ne 0
#		then
#			echo "Failed to switch on HDMI2. Aborting"
#			exit 1
#		fi
#	fi
	xrandr --output VIRTUAL1 --off --output DP3 --off --output DP2 --off --output DP1 --off --output HDMI3 --off --output HDMI1 --off --output LVDS1 --off
	xrandr --output HDMI2 --mode 1280x1024 --pos 0x0 --rotate normal --output VGA1 --mode 1280x1024 --pos 1280x0 --rotate normal
	xrandr --output HDMI2 --primary
	xrandr --dpi 96
	killall -SIGCONT i3
	exit 0
fi

# testing for bunsen
if xrandr | grep --quiet -P -z -o 'HDMI3 connected\N*\n\s*1920x1200' && xrandr | grep --quiet -P -z -o 'HDMI2 connected\N*\n\s*1280x1024'; then
	# we are at bunsen
	echo "Detected bunsen."
#	if test $HDMI3_ON -ne 0 && test $HDMI2_ON -ne 0
#	then
#		# switch on HDMI3 first
#		xrandr --output HDMI3 --auto
#		if test $? -ne 0
#		then
#			echo "Failed to switch on HDMI3. Aborting"
#			exit 1
#		fi
#	fi
	xrandr --output VIRTUAL1 --off --output DP3 --off --output DP2 --off --output DP1 --off --output HDMI1 --off --output LVDS1 --off --output VGA1 --off
	xrandr --output HDMI3 --mode 1920x1200 --pos 0x184 --rotate normal --output HDMI2 --mode 1280x1024 --pos 1920x0 --rotate left
	xrandr --output HDMI3 --primary
	killall -SIGCONT i3
	exit 0
fi

# testing for fassberg
if xrandr | grep --quiet -P -z -o 'LVDS1 connected' && xrandr | grep --quiet -P -z -o 'VGA1 connected\N*\n\s*1920x1200'; then
	# we are at fassberg VGA
	echo "Detected fassberg VGA."
	xrandr --output VIRTUAL1 --off --output DP3 --off --output DP2 --off --output DP1 --off --output HDMI1 --off --output HDMI2 --off --output HDMI3 --off
	xrandr --output LVDS1 --mode 1366x768 --pos 0x432 --rotate normal --output VGA1 --mode 1920x1200 --pos 1366x0 --rotate normal
	xrandr --output VGA1 --primary
	killall -SIGCONT i3
	exit 0
fi

# testing for wilhelm
if xrandr | grep --quiet -P -z -o 'HDMI1 connected\N*\n\s*1280x1024'; then
	# we are at wilhelm
	echo "Detected wilhelm Digital"
	xrandr --output VIRTUAL1 --off --output DP3 --off --output DP2 --off --output DP1 --off --output HDMI3 --off --output HDMI2 --off --output VGA1 --off
	xrandr --output HDMI1 --mode 1280x1024 --pos 40x0 --rotate normal --output LVDS1 --mode 1366x768 --pos 0x1024 --rotate normal 
	xrandr --output HDMI1 --primary
	killall -SIGCONT i3
	exit 0
fi

# fall back to laptop
echo "Falling back to auto configuration..."
#if test $LVDS1_ON -ne 0
#then
#	if test $WAS_CASPARI_OFFICE -eq 0
#	then
#		echo "Detected former configuration 'caspari office'."
#		# switch off VGA1
#		xrandr --output VGA1 --off
#	fi
#
#	if test $WAS_BUNSEN -eq 0
#	then
#		echo "Detected former configuration 'bunsen'."
#		# switch off HDMI2
#		xrandr --output HDMI2 --off
#	fi
#
#	# switch on LVDS1
#	xrandr --auto
#fi
xrandr --output VIRTUAL1 --off --output DP3 --off --output DP2 --off --output DP1 --off --output HDMI3 --off --output HDMI1 --off --output VGA1 --off --output HDMI2 --off
xrandr --auto
xrandr --dpi 96

killall -SIGCONT i3

