FROM rjlasko/alpine-s6:1.3
MAINTAINER rjlasko


# TODO: remove these?
ENV CRONTAB_MAILTO ""
ENV CRONTAB_USEDEFAULT ""

# XXX: Alpine needs to have tzdata installed prior to defining the TZ
# https://serverfault.com/questions/683605/docker-container-time-timezone-will-not-reflect-changes
RUN apk add --no-cache tzdata
ENV TZ UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


COPY fsroot /
RUN /bin/sh /tmp/build.sh && \
	rm -rf /tmp/*
