#!/bin/sh

LATEST="$(
	curl -s 'https://data.services.jetbrains.com/products/releases?code=IIC&latest=true&type=release' \
		| jq -r '.IIC[0].version'
	)"

PKG="$(
	curl -s 'https://raw.githubusercontent.com/lkiesow/intellij-idea-community-rpm/master/intellij-idea-community.spec' \
		| grep Version: \
		| awk '{print $2}'
	)"

if [ "$LATEST" != "$PKG" ]; then
	printf '%-32s %s -> %s\n' 'intellij-idea-community' "$PKG" "$LATEST" >> update.log
fi
