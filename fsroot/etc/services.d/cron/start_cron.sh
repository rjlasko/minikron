#!/usr/bin/with-contenv sh

# '/etc/services.d/cron/start_cron.sh'
#		Provided as the file that defines the startup of crond,
#		in the conventional shell file naming convention.
# '/etc/services.d/cron/run'
#		The file that crond looks for to run as a script.
#		Implemented as a symbolic link to 'start_cron.sh'

exec /usr/sbin/crond -f
