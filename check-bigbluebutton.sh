#!/bin/sh

echo "Checking BigBlueButton"

LATEST="$(
	curl -s 'https://github.com/bigbluebutton/bigbluebutton/releases' \
		| sed -n 's_^.*href="/bigbluebutton/bigbluebutton/tree/v\([^"]*\)".*$_\1_p' \
		| head -n1
	)"

echo "Latest version:  $LATEST"

DEPLOYED="$(curl -s https://conference.opencast-niedersachsen.de/version)"

echo "Deployed version: $DEPLOYED"

if [ "$LATEST" != "$DEPLOYED" ]; then
	printf '%-32s %s -> %s\n' 'BigBlueButton' "$DEPLOYED" "$LATEST" >> update.log
fi
