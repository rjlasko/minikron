FROM alpine:latest
MAINTAINER rjlasko

COPY build.sh /tmp/
RUN /bin/sh /tmp/build.sh && \
	rm -rf /tmp/*

CMD ["/usr/sbin/crond", "-f"]
