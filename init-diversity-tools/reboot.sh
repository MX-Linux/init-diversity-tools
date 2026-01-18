#!/bin/bash

[ -z "$BASH_VERSION" ] || [ "$UID" -ne 0 ] && exec sudo /bin/bash "$0" "$@"

case "$(realpath /proc/1/exe 2>/dev/null || readlink -f /proc/1/exe)" in
    /usr/lib/systemd/systemd)
        /usr/bin/systemctl reboot $@
        ;;
    /usr/lib/sysvinit/init)
        /usr/lib/sysvinit/init 6
        ;;
        *)
        sync && sleep 3 && /usr/bin/busybox reboot -f;
        ;;
esac
