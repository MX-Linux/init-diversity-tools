#!/bin/bash

# [ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

if mountpoint -q /live/aufs; then
#	echo "Live/Frugal system detected... detecting init"
		if [ $(cat /proc/cmdline | grep -ic "init=/") -eq 0 ]; then
#			echo "Primary Live/Frugal init booted... detecting primary live init"
				if [ $(ps -p1 | grep -ic "runit") -eq 1 ]; then
#					echo "runit Live/Frugal system detected...  executing runlevel command..."
					/usr/lib/runit/runlevel $@;
					exit 0
				elif [ $(ps -p1 | grep -ic "systemd") -eq 1 ]; then
#					echo "systemd Live/Frugal system detected...  executing runlevel command..."
					/usr/lib/systemd/runlevel $@;
					exit 0
				elif [ $(ps -p1 | grep -ic "init") -eq 1 ]; then
#					echo "sysvinit Live/Frugal system detected...  executing runlevel command..."
					/usr/lib/sysvinit/runlevel $@;
					exit 0
				else 
					#echo "Strange... Cannot detect Live/Frugal init...  Will try to execute runlevel using bysybox... executing runlevel command..."
					sync && sleep 5 && /usr/bin/busybox runlevel -f;
					exit 1
				fi
		else
#			echo "cmdline Live/Frugal init booted... detecting live init"
				if [ $(ps -p1 | grep -ic "runit") -eq 1 ]; then
#					echo "runit Live/Frugal system detected...  executing runlevel command..."
					/usr/lib/runit/runlevel $@;
					exit 0
				elif [ $(ps -p1 | grep -ic "systemd") -eq 1 ]; then
#					echo "systemd Live/Frugal system detected...  executing runlevel command..."
					/usr/lib/systemd/runlevel $@;
					exit 0
				elif [ $(ps -p1 | grep -ic "init") -eq 1 ]; then
#					echo "sysvinit Live/Frugal system detected...  executing runlevel command..."
					/usr/lib/sysvinit/runlevel $@;
					exit 0
				else 
					#echo "Strange... Cannot detect Live/Frugal init...  Will try to execute runlevel using bysybox... executing runlevel command..."
					sync && sleep 5 && /usr/bin/busybox runlevel -f;
					exit 1
				fi	
		fi
else
#	echo "Installed system detected... detecting init"
		if [ $(cat /proc/cmdline | grep -ic "init=/") -eq 0 ]; then
#			echo "Primary init booted... detecting primary init"
				if [ $(ps -p1 | grep -ic "runit") -eq 1 ]; then
#					echo "runit primary init detected...  executing runlevel command..."
					/usr/lib/runit/runlevel $@;
					exit 0
				elif [ $(ps -p1 | grep -ic "systemd") -eq 1 ]; then
#					echo "systemd primary init detected...  executing runlevel command..."
					/usr/lib/systemd/runlevel $@;
					exit 0
				elif [ $(ps -p1 | grep -ic "init") -eq 1 ]; then
#					echo "sysvinit primary init detected...  executing runlevel command..."
					/usr/lib/sysvinit/runlevel $@;
					exit 0
				else 
					#echo "Strange... Cannot detect primary init...  Will try to execute runlevel using bysybox... executing runlevel command..."
					sync && sleep 5 && /usr/bin/busybox runlevel -f;
					exit 1
				fi
		else
#			echo "cmdline init booted... detecting init"
				if [ $(ps -p1 | grep -ic "runit") -eq 1 ]; then
#					echo "runit init detected...  executing runlevel command..."
					/usr/lib/runit/runlevel $@;
					exit 0
				elif [ $(ps -p1 | grep -ic "systemd") -eq 1 ]; then
#					echo "systemd init detected...  executing runlevel command..."
					/usr/lib/systemd/runlevel $@;
					exit 0
				elif [ $(ps -p1 | grep -ic "init") -eq 1 ]; then
#					echo "sysvinit init detected...  executing runlevel command..."
					/usr/lib/sysvinit/runlevel $@;
					exit 0
				else 
					#echo "Strange... Cannot detect cmdline init...  Will try to execute runlevel using bysybox... executing runlevel command..."
					sync && sleep 5 && /usr/bin/busybox runlevel -f;
					exit 1
				fi	
		fi
	
fi
