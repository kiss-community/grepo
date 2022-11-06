#!/bin/sh

set -eu

BASEDIR=${0%/*}

EXCLUDE='
:^core/musl
'

INCLUDE='
core
extra
wayland
'

cd "$BASEDIR"

[ -z "$(git status -s)" ] || {
    echo "Working tree is dirty!" >&2
    exit 1
}

# exclude overrides
cd overrides
for pkg in */*; do
    EXCLUDE="$EXCLUDE :^$pkg"
done
cd "$OLDPWD"

git fetch https://codeberg.org/kiss-community/repo

# need to find common ancestor because grepo repo has unrelated commit history.
# 'bump to' grep can be dropped once first cherry-picked commit is added.
ancestor=$(git log --grep='\*: bump to' --grep='(cherry picked from commit' -1 --format=%B |
    sed -n 's@.* \([a-f0-9]\{40\}\).*@\1@p')

# apply commits. cherry-pick will fail if stdin is empty(no commits)
git rev-list --reverse "${ancestor}..FETCH_HEAD" -- $INCLUDE $EXCLUDE |
    git cherry-pick -x --stdin
