FROM alpine:latest
MAINTAINER rjlasko

RUN apk add --update apk-cron && \
	rm -rf /tmp/* && \
	rm -rf /var/cache/apk/*

CMD ["/usr/sbin/crond", "-f"]
