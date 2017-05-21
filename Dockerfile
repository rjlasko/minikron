FROM rjlasko/alpine-s6:latest
MAINTAINER rjlasko

ENV MAILTO ""
ENV USEDEFAULTCRONTAB ""

COPY fsroot /
RUN /bin/sh /tmp/build.sh && \
	rm -rf /tmp/*
