#!/bin/bash

[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

if mountpoint -q /live/aufs; then
	echo "Live/Frugal system detected... detecting init"
		if [ $(cat /proc/cmdline | grep -ic "init=/") -eq 0 ]; then
			echo "Primary Live/Frugal init booted... detecting primary live init"
				if [ $(ps -p1 | grep -ic "runit") -eq 1 ]; then
					echo "runit Live/Frugal system detected...  Rebooting..."
					sync && touch /run/initctl && ( /usr/lib/runit/runit-init 6  | /usr/sbin/init 6 ) && ( /usr/lib/runit/shutdown -r now | /usr/sbin/shutdown -r now ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				elif [ $(ps -p1 | grep -ic "s6-svscan") -eq 1 ] && [ -e /run/s6-rc ]; then
					echo "s6-rc Live/Frugal system detected...  Rebooting..."
					sync  && ( openvt -c12 -f -- /usr/lib/s6-rc/reboot $@ | openvt -c12 -f -- /usr/bin/s6-linux-init-hpr -r $@ ) && /usr/bin/busybox reboot -f;
					exit 0
				elif [ $(ps -p1 | grep -ic "s6-svscan") -eq 1 ] && [ -e /run/66 ]; then
					echo "s6-66 Live/Frugal system detected...  Rebooting..."
					sync  && ( /usr/lib/s6-66/reboot $@ | /usr/bin/66 reboot $@ ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				elif [ $(ps -p1 | grep -ic "openrc") -eq 1 ] || [ $(readlink -e /sbin/init | grep -ic "openrc") -eq 1 ]; then
					echo "openrc Live/Frugal system detected...  Rebooting..."
					sync  && ( /usr/lib/openrc/openrc-shutdown -r now | /usr/sbin/shutdown -r now ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				elif [ $(ps -p1 | grep -ic "dinit") -eq 1 ] || [ $(/sbin/init --version | grep -ic "Dinit") -eq 1 ]; then
					echo "dinit Live/Frugal system detected...  Rebooting..."
					sync  && ( /usr/lib/dinit/reboot $@ | /usr/sbin/dinit-reboot $@ ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				elif [ $(ps -p1 | grep -ic "init") -eq 1 ] && [ $(/sbin/init --version | grep -ic "SysV") -eq 1 ]; then
					echo "sysvinit Live/Frugal system detected...  Rebooting..."
					sync  && ( /usr/lib/sysvinit/init 6 | /usr/sbin/init 6 ) && sleep 3 && ( /usr/lib/sysvinit/reboot $@ ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				elif [ $(ps -p1 | grep -ic "systemd") -eq 1 ]; then
					echo "systemd Live/Frugal system detected...  Rebooting..."
					sync  && ( systemctl reboot $@ | /usr/lib/systemd/systemctl reboot $@ | /usr/sbin/reboot $@ ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				else 
					echo "Strange... Cannot detect Live/Frugal init...  Will try to reboot using bysybox... Rebooting..."
					sync && sleep 5 && /usr/bin/busybox reboot -f;
					exit 1
				fi
		else
			echo "cmdline Live/Frugal init booted... detecting live init"
				if [ $(ps -p1 | grep -ic "runit") -eq 1 ]; then
					echo "runit Live/Frugal system detected...  Rebooting..."
					sync && touch /run/initctl && ( /usr/lib/runit/runit-init 6  | /usr/sbin/init 6 ) && ( /usr/lib/runit/shutdown -r now | /usr/sbin/shutdown -r now ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				elif [ $(ps -p1 | grep -ic "s6-svscan") -eq 1 ] && [ -e /run/s6-rc ]; then
					echo "s6-rc Live/Frugal system detected...  Rebooting..."
					sync  && ( openvt -c12 -f -- /usr/lib/s6-rc/reboot $@ | openvt -c12 -f -- /usr/bin/s6-linux-init-hpr -r $@ ) && /usr/bin/busybox reboot -f;
					exit 0
				elif [ $(ps -p1 | grep -ic "s6-svscan") -eq 1 ] && [ -e /run/66 ]; then
					echo "s6-66 Live/Frugal system detected...  Rebooting..."
					sync  && ( /usr/lib/s6-66/reboot $@ | /usr/bin/66 reboot $@ ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				elif [ $(cat /proc/cmdline | grep -ic "openrc") -eq 1 ]; then
					echo "openrc Live/Frugal system detected...  Rebooting..."
					sync  && ( /usr/lib/openrc/openrc-shutdown -r now | /usr/sbin/shutdown -r now ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				elif [ $(cat /proc/cmdline | grep -ic "dinit") -eq 1 ]; then
					echo "dinit Live/Frugal system detected...  Rebooting..."
					sync  && ( /usr/lib/dinit/reboot $@ | /usr/sbin/dinit-reboot $@ ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				elif [ $(cat /proc/cmdline | grep -ic "sysvinit") -eq 1 ]; then
					echo "sysvinit Live/Frugal system detected...  Rebooting..."
					sync  && ( /usr/lib/sysvinit/init 6 | /usr/sbin/init 6 ) && sleep 3 && ( /usr/lib/sysvinit/reboot $@ ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				elif [ $(ps -p1 | grep -ic "systemd") -eq 1 ]; then
					echo "systemd Live/Frugal system detected...  Rebooting..."
					sync  && ( systemctl reboot $@ | /usr/lib/systemd/systemctl reboot $@ | /usr/sbin/reboot $@ ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				else 
					echo "Strange... Cannot detect Live/Frugal init...  Will try to reboot using bysybox... Rebooting..."
					sync && sleep 5 && /usr/bin/busybox reboot -f;
					exit 1
				fi	
		fi
else
	echo "Installed system detected... detecting init"
		if [ $(cat /proc/cmdline | grep -ic "init=/") -eq 0 ]; then
			echo "Primary init booted... detecting primary init"
				if [ $(ps -p1 | grep -ic "runit") -eq 1 ]; then
					echo "runit primary init detected...  Rebooting..."
					sync && touch /run/initctl && ( /usr/lib/runit/runit-init 6  | /usr/sbin/init 6 ) && ( /usr/lib/runit/shutdown -r now | /usr/sbin/shutdown -r now ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				elif [ $(ps -p1 | grep -ic "s6-svscan") -eq 1 ] && [ -e /run/s6-rc ]; then
					echo "s6-rc primary init detected...  Rebooting..."
					sync  && ( /usr/lib/s6-rc/reboot $@ | /usr/bin/s6-linux-init-hpr -r $@ ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				elif [ $(ps -p1 | grep -ic "s6-svscan") -eq 1 ] && [ -e /run/66 ]; then
					echo "s6-66 primary init detected...  Rebooting..."
					sync  && ( /usr/lib/s6-66/reboot $@ | /usr/bin/66 reboot $@ ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				elif [ $(ps -p1 | grep -ic "openrc") -eq 1 ] || [ $(readlink -e /sbin/init | grep -ic "openrc") -eq 1 ]; then
					echo "openrc primary init detected...  Rebooting..."
					sync  && ( /usr/lib/openrc/openrc-shutdown -r now | /usr/sbin/shutdown -r now ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				elif [ $(ps -p1 | grep -ic "dinit") -eq 1 ] || [ $(/sbin/init --version | grep -ic "Dinit") -eq 1 ]; then
					echo "dinit primary init detected...  Rebooting..."
					sync  && ( /usr/lib/dinit/reboot $@ | /usr/sbin/dinit-reboot $@ ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				elif [ $(ps -p1 | grep -ic "init") -eq 1 ] && [ $(/sbin/init --version | grep -ic "SysV") -eq 1 ]; then
					echo "sysvinit primary init detected...  Rebooting..."
					sync  && ( /usr/lib/sysvinit/init 6 | /usr/sbin/init 6 ) && sleep 3 && ( /usr/lib/sysvinit/reboot $@ ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				elif [ $(ps -p1 | grep -ic "systemd") -eq 1 ]; then
					echo "systemd primary init detected...  Rebooting..."
					sync  && ( systemctl reboot $@ | /usr/lib/systemd/systemctl reboot $@ | /usr/sbin/reboot $@ ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				else 
					echo "Strange... Cannot detect primary init...  Will try to reboot using bysybox... Rebooting..."
					sync && sleep 5 && /usr/bin/busybox reboot -f;
					exit 1
				fi
		else
			echo "cmdline init booted... detecting init"
				if [ $(ps -p1 | grep -ic "runit") -eq 1 ]; then
					echo "runit init detected...  Rebooting..."
					sync && touch /run/initctl && ( /usr/lib/runit/runit-init 6  | /usr/sbin/init 6 ) && ( /usr/lib/runit/shutdown -r now | /usr/sbin/shutdown -r now ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				elif [ $(ps -p1 | grep -ic "s6-svscan") -eq 1 ] && [ -e /run/s6-rc ]; then
					echo "s6-rc init detected...  Rebooting..."
					sync  && ( /usr/lib/s6-rc/reboot $@ | /usr/bin/s6-linux-init-hpr -r $@ ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				elif [ $(ps -p1 | grep -ic "s6-svscan") -eq 1 ] && [ -e /run/66 ]; then
					echo "s6-66 init detected...  Rebooting..."
					sync  && ( /usr/lib/s6-66/reboot $@ | /usr/bin/66 reboot $@ ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				elif [ $(ps -p1 | grep -ic "openrc") -eq 1 ]; then
					echo "openrc init detected...  Rebooting..."
					sync  && ( /usr/lib/openrc/openrc-shutdown -r now | /usr/sbin/shutdown -r now ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				elif [ $(ps -p1 | grep -ic "dinit") -eq 1 ] || [ $(cat /proc/cmdline | grep -ic "dinit") -eq 1 ]; then
					echo "dinit init detected...  Rebooting..."
					sync  && ( /usr/lib/dinit/reboot $@ | /usr/sbin/dinit-reboot $@ ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				elif [ $(ps -p1 | grep -ic "init") -eq 1 ] && [ $(cat /proc/cmdline | grep -ic "sysvinit") -eq 1 ]; then
					echo "sysvinit init detected...  Rebooting..."
					sync  && ( /usr/lib/sysvinit/init 6 | /usr/sbin/init 6 ) && sleep 3 && ( /usr/lib/sysvinit/reboot $@ ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				elif [ $(ps -p1 | grep -ic "systemd") -eq 1 ]; then
					echo "systemd init detected...  Rebooting..."
					sync  && ( systemctl reboot $@ | /usr/lib/systemd/systemctl reboot $@ | /usr/sbin/reboot $@ ) && sync && sleep 3 && /usr/bin/busybox reboot -f;
					exit 0
				else 
					echo "Strange... Cannot detect cmdline init...  Will try to reboot using bysybox... Rebooting..."
					sync && sleep 5 && /usr/bin/busybox reboot -f;
					exit 1
				fi	
		fi
	
fi
