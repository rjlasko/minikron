FROM rjlasko/alpine-s6:1.1
MAINTAINER rjlasko

ENV CRONTAB_MAILTO ""
ENV CRONTAB_USEDEFAULT ""

COPY fsroot /
RUN /bin/sh /tmp/build.sh && \
	rm -rf /tmp/*
