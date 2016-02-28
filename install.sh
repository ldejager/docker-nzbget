#!/bin/sh
#
# NZBGet Setup
# Adding to separate script to keep container layers to a minimal

apk --update add openssl wget

addgroup -g 1000 nzbget
adduser -H -D -G nzbget -s /bin/false -u 1000 nzbget

mkdir -p /nzbget
mkdir -p /config
mkdir -p /downloads

wget -O - http://nzbget.net/info/nzbget-version-linux.json | \
sed -n "s/^.*stable-download.*: \"\(.*\)\".*/\1/p" | \
wget --no-check-certificate -i - -O /tmp/nzbget-latest-bin-linux.run || \
echo "*** Download failed ***"

sh /tmp/nzbget-latest-bin-linux.run --destdir /nzbget

chown -R nzbget:nzbget /nzbget /config /downloads /tmp/nzbget-latest-bin-linux.run

rm -rf /var/cache/apk/*

cp -v /nzbget/nzbget.conf /config/nzbget.conf

sed -i -e "s|\(MainDir=\).*|\1/downloads|g" /config/nzbget.conf
sed -i -e "s|\(WriteLog=\).*|\1none|g" /config/nzbget.conf
sed -i -e "s|\(ErrorTarget=\).*|\1screen|g" /config/nzbget.conf
sed -i -e "s|\(WarningTarget=\).*|\1screen|g" /config/nzbget.conf
sed -i -e "s|\(InfoTarget=\).*|\1screen|g" /config/nzbget.conf
sed -i -e "s|\(DetailTarget=\).*|\1none|g" /config/nzbget.conf
sed -i -e "s|\(DebugTarget=\).*|\1none|g" /config/nzbget.conf
