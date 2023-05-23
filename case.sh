#!/bin/bash
case $(hostname) in
    peka2 | peka3)
	BROWSER=/usr/bin/jitsi-meet
	$BROWSER "jitsi-meet://$1"
	echo $1 > /tmp/jitsi.log
	echo >> ================
	echo >>  "$(echo $1 | sed -r 's/.*(uniqueid=.*)/\1/' )"
        ;;
    pc284)
	BROWSER=/usr/bin/jitsi-meet
	$BROWSER "jitsi-meet://$1"
	;;
    *)
	BROWSER=/usr/bin/chromium
	$BROWSER --user-data-dir=$HOME/.config/chromium-jitsi --window-size="${WINDOWSIZE}" --disable-gpu --disable-gpu-sandbox --window-position="${WINDOWPOS}" --app="$1" &
	;;
esac
