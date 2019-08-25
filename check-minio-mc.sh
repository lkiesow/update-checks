#!/bin/sh

echo "Checking minio-mc"

LATEST="$(
	curl -s 'https://github.com/minio/mc/releases' \
		| sed -n 's_^.*href="/minio/mc/tree/\(RELEASE\.[^"]*\)".*$_\1_p' \
		| head -n1
	)"

echo "Latest version:  $LATEST"

PKG="$(
	curl -s 'https://raw.githubusercontent.com/lkiesow/minio-rpm/master/minio-mc.spec' \
		| grep '%define *tag' \
		| awk '{print $3}'
	)"

echo "Package version: $PKG"

if [ "$LATEST" != "$PKG" ]; then
	printf '%-32s %s -> %s\n' 'minio-mc' "$PKG" "$LATEST" >> update.log
fi
