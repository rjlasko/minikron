#!/usr/bin/with-contenv sh
set -e

echo "CRONTAB_USEDEFAULT=$CRONTAB_USEDEFAULT" 1>&2
if ! $( echo "$CRONTAB_USEDEFAULT" | grep -qi '^TRUE$' ) ; then
	crontab /dev/null
fi

echo "CRONTAB_MAILTO=$CRONTAB_MAILTO" 1>&2
if [ -n "$CRONTAB_MAILTO" ] ; then
	(echo "MAILTO=$CRONTAB_MAILTO"; crontab -l) | crontab -
fi

# append user provided crontab files
if [ -f "/etc/periodic/cron.tab" ] ; then
	(crontab -l ; cat "/etc/periodic/cron.tab") | crontab -
	echo "/etc/periodic/cron.tab injected into crontab" 1>&2
fi
