#!/bin/bash
set -e

if [ $# -lt 1 ]
  then
  echo "Usage: release.sh [commit hash]"
  exit 1
fi

commit=$1

git fetch
git checkout $commit src
git checkout $commit elm-package.json
git reset
git checkout HEAD .gitignore
elm-make src/UrlParams.elm
git add elm.js
git add index.html
git commit -m "Updated to $commit"
