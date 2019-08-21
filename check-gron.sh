#!/bin/sh

echo "Checking gron"

LATEST="$(
	curl -s 'https://github.com/tomnomnom/gron/releases' \
		| sed -n 's_^.*href="/tomnomnom/gron/tree/v\([^"]*\)".*$_\1_p' \
		| head -n1
	)"

echo "Latest version:  $LATEST"

PKG="$(
	curl -s 'https://copr-be.cloud.fedoraproject.org/results/lkiesow/gron/fedora-28-x86_64/00782488-gron/gron.spec' \
		| grep Version: \
		| awk '{print $2}'
	)"

echo "Package version: $PKG"

if [ "$LATEST" != "$PKG" ]; then
	printf '%-32s %s -> %s\n' 'gron' "$PKG" "$LATEST" >> update.log
fi
