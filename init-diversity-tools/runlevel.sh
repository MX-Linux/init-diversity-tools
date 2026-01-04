#!/bin/bash

[ -z "$BASH_VERSION" ] && exec /bin/bash "$0" "$@"

case "$(cat /proc/1/comm)" in
    systemd)
        /usr/lib/systemd/runlevel $@
        ;;
    init)
        /usr/lib/sysvinit/runlevel $@
        ;;
esac
exit 0
