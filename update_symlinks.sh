#!/bin/sh

set -eu

cd "${0%/*}"

for repo in ./*/; do
	(
		cd "$repo"

		reponame="${PWD##*/}"

		for pkg in ./*; do
    		[ -L "$PWD/$pkg" ] || continue

    		pkg="${pkg##*/}"
    		rm -fv "$PWD/$pkg"

			[ -d "../kiss-repo/$reponame/$pkg" ] || continue

    		ln -sfv "../kiss-repo/$reponame/$pkg" "$PWD/$pkg"
        done
	)
done
