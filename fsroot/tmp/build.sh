#!/bin/sh
set -e


# replace sendmail with msmtp
apk add --update --no-cache msmtp
ln -s -f "$(which msmtp)" "$(which sendmail)"

# install cronic to cleanup cron outputs for mailing errors
apk add --update --no-cache bash curl
# requires 'bash'
curl -L http://habilis.net/cronic/cronic -o /usr/bin/cronic
chmod a=rx /usr/bin/cronic

# remove all installation-only packages
apk del curl
# and clear the apk cache
rm -rf /var/cache/apk/*
