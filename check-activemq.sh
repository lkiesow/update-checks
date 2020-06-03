#!/bin/sh

echo "Checking ActiveMQ"

LATEST="$(
	curl -s 'https://github.com/apache/activemq/releases' \
		| sed -n 's_^.*href="/apache/activemq/releases/tag/activemq-\([^"]*\)".*$_\1_p' \
		| head -n1
	)"

echo "Latest version:  $LATEST"

PKG="$(
	curl -s 'https://raw.githubusercontent.com/lkiesow/activemq-dist-rpm/master/activemq-dist.spec' \
		| grep Version: \
		| awk '{print $2}'
	)"

echo "Package version: $PKG"

if [ "$LATEST" != "$PKG" ]; then
	printf '%-32s %s -> %s\n' 'ActiveMQ' "$PKG" "$LATEST" >> update.log
fi
