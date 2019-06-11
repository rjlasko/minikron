#!/bin/sh
set -xeu

BUILD_DEPS="curl"
RUN_DEPS="bash msmtp"

apk add --update --no-cache ${RUN_DEPS} ${BUILD_DEPS}


# replace sendmail with msmtp
ln -s -f "$(which msmtp)" "$(which sendmail)"


# install cronic to cleanup cron outputs for mailing errors
# requires 'bash'
curl -L http://habilis.net/cronic/cronic -o /usr/bin/cronic
chmod a=rx /usr/bin/cronic


# remove all installation-only packages
apk del ${BUILD_DEPS}
# and clear the apk cache
rm -rf /var/cache/apk/*
