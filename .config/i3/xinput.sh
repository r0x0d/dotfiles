#!/bin/bash

XINPUT_TOUCHPAD=$(xinput | grep Touchpad | awk '{ print $3" "$4" "$5}')
xinput set-prop "$XINPUT_TOUCHPAD" "libinput Tapping Enabled" 1
