#!/bin/bash

[ -z "$BASH_VERSION" ] || [ "$UID" -ne 0 ] && exec sudo /bin/bash "$0" "$@"

case "$(realpath /proc/1/exe 2>/dev/null || readlink -f /proc/1/exe)" in
    /usr/lib/sysvinit/init)
        [ -x /usr/lib/init/rc ] && exec /usr/lib/init/rc "$@"
        ;;
esac
exit 0
