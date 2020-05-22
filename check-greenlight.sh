#!/bin/sh

echo "Checking greenlight"

LATEST="$(
	curl -s 'https://github.com/bigbluebutton/greenlight/releases' \
		| sed -n 's_^.*href="/bigbluebutton/greenlight/tree/release-\([^"]*\)".*$_\1_p' \
		| head -n1
	)"

echo "Latest version:  $LATEST"

DEPLOYED="$(
	curl -s -H 'Accept-Language: en' https://conference.opencast-niedersachsen.de/b \
		| sed -n 's/^.*>Powered.*<\/a>\. *\([0-9.]*\)<\/p>.*$/\1/p'
	)"

echo "Deployed version: $DEPLOYED"

if [ "$LATEST" != "DEPLOYED" ]; then
	printf '%-32s %s -> %s\n' 'greenlight' "$PKG" "$LATEST" >> update.log
fi
