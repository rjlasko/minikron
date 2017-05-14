#!/bin/sh
set -e

# append user provided crontab files
if [ -f "/etc/periodic/user/cron.tab" ] ; then
	(crontab -l ; cat "/etc/periodic/user/cron.tab") | crontab -
fi

exec /usr/sbin/crond -f
