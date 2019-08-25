#!/bin/sh

echo "Checking ActiveMQ"

LATEST="$(
	curl -s 'https://activemq.apache.org/components/classic/download/' \
		| sed -n 's/^.*apache-activemq-\([0-9.]*\)-bin\.tar\.gz<.*$/\1/p'
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
