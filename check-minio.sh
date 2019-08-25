#!/bin/sh

echo "Checking minio"

LATEST="$(
	curl -s 'https://github.com/minio/minio/releases' \
		| sed -n 's_^.*href="/minio/minio/tree/\(RELEASE\.[^"]*\)".*$_\1_p' \
		| head -n1
	)"

echo "Latest version:  $LATEST"

PKG="$(
	curl -s 'https://raw.githubusercontent.com/lkiesow/minio-rpm/master/minio.spec' \
		| grep '%define *tag' \
		| awk '{print $3}'
	)"

echo "Package version: $PKG"

if [ "$LATEST" != "$PKG" ]; then
	printf '%-32s %s -> %s\n' 'gron' "$PKG" "$LATEST" >> update.log
fi
