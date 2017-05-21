FROM rjlasko/alpine-s6:latest
MAINTAINER rjlasko

ENV MAILTO ""
ENV USEDEFAULTCRONTAB ""

COPY build.sh /tmp/
RUN /bin/sh /tmp/build.sh && \
	rm -rf /tmp/*

COPY start.sh /usr/bin/

CMD ["/bin/sh", "/usr/bin/start.sh"]
