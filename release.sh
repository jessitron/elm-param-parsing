#!/bin/bash
set -e

if [ $# -lt 1 ]
  then
  echo "Usage: release.sh [commit hash]"
  exit 1
fi

commit=$1

git fetch
git checkout $commit .
git reset
git checkout HEAD .gitignore
elm-make *.elm
git add elm.js
git add index.html
git commit -m "Updated to $commit"
