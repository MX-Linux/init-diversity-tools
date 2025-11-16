#!/usr/bin/bash

## Start 66 user services if s6-66 is detected
if [ $(ps -p1 | grep -ic "s6-svscan") -eq 1 ] && [ -e /run/66 ]; then
    sh -c "66 tree start"
fi

## Start s6-rc user services if s6-rc is detected
if [ $(ps -p1 | grep -ic "s6-svscan") -eq 1 ] && [ -e /run/s6-rc ]; then
	mkdir -p /tmp/"${UID}"/service
	coproc s6-svscan /tmp/"${UID}"/service
	s6-rc-init -c "$(/usr/lib/execline/bin/homeof $(whoami))"/.s6-rc/compiled -l /tmp/"${UID}"/s6-rc /tmp/"${UID}"/service 
    s6-rc -l /tmp/"${UID}"/s6-rc -up change default
fi

## Start dinit user services if dinit is detected
if [ $(ps -p1 | grep -ic "dinit") -eq 1 ]; then
	dinit &
fi
