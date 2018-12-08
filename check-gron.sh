#!/bin/sh

LATEST="$(
	curl -s https://api.github.com/repos/tomnomnom/gron/tags \
		| grep name \
		| sed 's/^.*"v\(.*\)".*$/\1/' \
		| head -n1
	)"

PKG="$(
	curl -s 'https://copr-be.cloud.fedoraproject.org/results/lkiesow/gron/fedora-28-x86_64/00782488-gron/gron.spec' \
		| grep Version: \
		| awk '{print $2}'
	)"

if [ "$LATEST" != "$PKG" ]; then
	printf '%-32s %s -> %s\n' 'gron' "$PKG" "$LATEST" >> update.log
fi
