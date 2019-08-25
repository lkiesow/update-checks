#!/bin/sh

echo "Checking intellij-idea-community"

LATEST="$(
	curl -s 'https://data.services.jetbrains.com/products/releases?code=IIC&latest=true&type=release'
	)"

version="$(printf "%s" "${LATEST}" | jq -r '.IIC[0].version')"
build="$(printf "%s" "${LATEST}" | jq -r '.IIC[0].build')"
LATEST="$version ($build)"

echo "Latest version:  $LATEST"

PKG="$(
	curl -s 'https://raw.githubusercontent.com/lkiesow/intellij-idea-community-rpm/master/intellij-idea-community.spec'
	)"

version="$(echo "$PKG" | grep Version: | awk '{print $2}')"
build="$(echo "$PKG" | grep '%global build_vers' | awk '{print $3}')"
PKG="$version ($build)"

echo "Package version: $PKG"

if [ "$LATEST" != "$PKG" ]; then
	printf '%-32s %s -> %s\n' 'intellij-idea-community' "$PKG" "$LATEST" >> update.log
fi
