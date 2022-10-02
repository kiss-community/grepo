#!/bin/sh

set -eu

BASEDIR="${0%/*}"

REMOVE="
core/musl
"

cd "$BASEDIR"

[ -z "$(git status -s)" ] || {
    echo "Working tree is dirty!" >&2
    exit 1
}

git clone --depth=1 https://codeberg.org/kiss-community/repo kiss-repo
hash="$(git -C kiss-repo rev-parse HEAD)"

ret=0

{
    rm -rf core extra wayland

    for repo in core extra wayland; do
        cp -LR "$PWD/kiss-repo/$repo" "$repo"
    done

    for pkg in $REMOVE; do
        rm -rf "$PWD/$pkg"
    done

    for repo in overrides/*; do
        dest="$BASEDIR/${repo##*/}"
        mkdir -p "$dest"

        for pkg in "$repo"/*; do
            pkg="${pkg##*/}"

            rm -rf "${dest:?}/$pkg"
            ln -sf "../$repo/$pkg" "$dest/$pkg"
        done
    done
} || ret=$?

rm -rf kiss-repo

[ "$ret" = 0 ] && {
    git add .
    git commit -am "*: bump to $hash"
}

return "$ret"
