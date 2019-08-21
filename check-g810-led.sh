#!/bin/sh

echo "Checking g810-led"

LATEST="$(
	curl -s 'https://github.com/MatMoul/g810-led/releases' \
		| sed -n 's_^.*href="/MatMoul/g810-led/[^/]*/v\([^"]*\).tar.gz".*$_\1_p' \
		| head -n1
	)"

echo "Latest version:  $LATEST"

PKG="$(
	curl -s 'https://raw.githubusercontent.com/lkiesow/g810-led-rpm/master/g810-led.spec' \
		| grep Version: \
		| awk '{print $2}'
	)"

echo "Package version: $PKG"

if [ "$LATEST" != "$PKG" ]; then
	printf '%-32s %s -> %s\n' 'g810-led' "$PKG" "$LATEST" >> update.log
fi
