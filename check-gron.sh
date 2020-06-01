#!/bin/sh

SPECURL="https://src.fedoraproject.org/rpms/gron/raw/master/f/gron.spec"

echo "Checking gron"

LATEST="$(
	curl -s 'https://github.com/tomnomnom/gron/releases' \
		| sed -n 's_^.*href="/tomnomnom/gron/tree/v\([^"]*\)".*$_\1_p' \
		| head -n1
	)"

echo "Latest version:  $LATEST"

PKG="$(
	curl -s "${SPECURL}" \
		| grep Version: \
		| awk '{print $2}'
	)"

echo "Package version: $PKG"

if [ "$LATEST" != "$PKG" ]; then
	printf '%-32s %s -> %s\n' 'gron' "$PKG" "$LATEST" >> update.log
fi
