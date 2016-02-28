FROM alpine:latest
MAINTAINER Leon de Jager <leondejager@gmail.com>

ADD install.sh /install.sh

RUN chmod +x /install.sh && sh /install.sh

VOLUME /config /downloads

EXPOSE 6789

USER nzbget

ENTRYPOINT ["/nzbget/nzbget", "-s", "-o", "OutputMode=log", "-c", "/config/nzbget.conf"]
