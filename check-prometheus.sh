#!/bin/sh

echo "Checking Prometheus"

LATEST="$(
	curl -s 'https://github.com/prometheus/prometheus/releases' \
		| sed -n 's_^.*href="/prometheus/prometheus/tree/v\([^"-]*\)".*$_\1_p' \
		| head -n1
	)"

echo "Latest version:  $LATEST"

PKG="$(
	curl -s 'https://raw.githubusercontent.com/lkiesow/prometheus-rpm/master/prometheus.spec' \
		| grep Version: \
		| awk '{print $2}'
	)"

echo "Package version: $PKG"

if [ "$LATEST" != "$PKG" ]; then
	printf '%-32s %s -> %s\n' 'prometheus' "$PKG" "$LATEST" >> update.log
fi
