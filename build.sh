#!/bin/sh
set -e

# add permanent applications & utilities
apk add --update --no-cache bash msmtp

# replace sendmail with msmtp
SENDMAIL_PATH="$(which sendmail)"
unlink "$SENDMAIL_PATH"
ln -s "$(which msmtp)" "$SENDMAIL_PATH"

# add packages only needed for installation
apk add --update --no-cache curl

# install cronic to cleanup cron outputs for mailing errors
# requires 'bash'
curl -L http://habilis.net/cronic/cronic -o /usr/bin/cronic
chmod a=rx /usr/bin/cronic

# remove all installation-only packages
apk del curl
# and clear the apk cache
rm -rf /var/cache/apk/*
