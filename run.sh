#!/bin/bash
# checkout
git checkout -B gh-pages

# clear
./publish.sh clear

# merge
git merge master

# publish
./publish.sh

# commit & push
git add .
git commit -m "Update pages: `date +%Y-%m-%d,%H:%m:%S`"
git push origin gh-pages

# checkout
git checkout master
