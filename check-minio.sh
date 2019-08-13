#!/bin/sh

LATEST="$(
	curl -s 'https://github.com/minio/minio/releases' \
		| sed -n 's_^.*href="/minio/minio/tree/\(RELEASE\.[^"]*\)".*$_\1_p' \
		| head -n1
	)"

echo $LATEST
exit

PKG="$(
	curl -s 'https://copr-be.cloud.fedoraproject.org/results/lkiesow/gron/fedora-28-x86_64/00782488-gron/gron.spec' \
		| grep Version: \
		| awk '{print $2}'
	)"

if [ "$LATEST" != "$PKG" ]; then
	printf '%-32s %s -> %s\n' 'gron' "$PKG" "$LATEST" >> update.log
fi
