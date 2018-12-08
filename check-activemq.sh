#!/bin/sh

LATEST="$(
	curl -s 'http://activemq.apache.org/download.html' \
		| sed -n 's/^.*ActiveMQ \([0-9.]*\) Release.*$/\1/p'
	)"

PKG="$(
	curl -s 'https://raw.githubusercontent.com/lkiesow/activemq-dist-rpm/master/activemq-dist.spec' \
		| grep Version: \
		| awk '{print $2}'
	)"

if [ "$LATEST" != "$PKG" ]; then
	printf '%-32s %s -> %s\n' 'ActiveMQ' "$PKG" "$LATEST" >> update.log
fi
