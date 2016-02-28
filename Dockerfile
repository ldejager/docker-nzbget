FROM alpine:3.3

RUN apk --update add openssl jq \
 && wget -qO /tmp/nzbget.run $(wget -qO- https://api.github.com/repos/nzbget/nzbget/releases/latest | jq -r '.name') \
 && sh /tmp/nzbget.run \
 && rm /tmp/nzbget.run
