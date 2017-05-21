#!/usr/bin/with-contenv sh
set -e


echo "USEDEFAULTCRONTAB=$USEDEFAULTCRONTAB"
if ! $( echo "$USEDEFAULTCRONTAB" | grep -qi '^TRUE$' ) ; then
	crontab /dev/null
fi

# if MAILTO is provided
if [ -n "$MAILTO" ] ; then
	echo "Updating crontab MAILTO=$MAILTO" 1>&2
	(echo "MAILTO=$MAILTO"; crontab -l) | crontab -
fi

# append user provided crontab files
if [ -f "/etc/periodic/cron.tab" ] ; then
	echo "Injecting /etc/periodic/cron.tab into crontab" 1>&2
	(crontab -l ; cat "/etc/periodic/cron.tab") | crontab -
fi

exec /usr/sbin/crond -f
