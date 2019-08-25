#!/bin/sh

echo "Checking nexus-oss"

LATEST="$(
	curl -s -I -L http://download.sonatype.com/nexus/oss/nexus-latest-bundle.tar.gz \
		| grep Location \
		| tail -n1 \
   	| sed 's_^.*oss/nexus-\([0-9.]*\)-.*_\1_'
	)"

echo "Latest version:  $LATEST"

PKG="$(
	curl -s 'https://raw.githubusercontent.com/lkiesow/nexus-oss-rpm/master/nexus-oss.spec' \
		| grep Version: \
		| awk '{print $2}'
	)"

echo "Package version: $PKG"

if [ "$LATEST" != "$PKG" ]; then
	printf '%-32s %s -> %s\n' 'nexus-oss' "$PKG" "$LATEST" >> update.log
fi
