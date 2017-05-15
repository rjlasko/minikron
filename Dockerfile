FROM alpine:latest
MAINTAINER rjlasko

ENV MAILTO ""
ENV USEDEFAULTCRONTAB ""

COPY build.sh /tmp/
RUN /bin/sh /tmp/build.sh && \
	rm -rf /tmp/*

COPY start.sh /usr/bin/

ENTRYPOINT ["/bin/sh"]
CMD ["/usr/bin/start.sh"]
