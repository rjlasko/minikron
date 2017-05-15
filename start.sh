#!/bin/sh
set -e

if ! $( echo "$USEDEFAULTCRONTAB" | grep -qi '^TRUE$' ) ; then
	crontab /dev/null
fi

# if MAILTO is provided
if [ -n "$MAILTO" ] ; then
	(echo "MAILTO=$MAILTO"; crontab -l) | crontab -
fi

# append user provided crontab files
if [ -f "/etc/periodic/cron.tab" ] ; then
	(crontab -l ; cat "/etc/periodic/cron.tab") | crontab -
fi

exec /usr/sbin/crond -f
