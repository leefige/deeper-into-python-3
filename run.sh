#!/bin/bash
# checkout
git checkout gh-pages

# clear
./publish clear

# merge
git merge master

# publish
./publish

# commit & push
git add .
git commit -m "Update pages: `date +%Y-%m-%d,%H:%m:%S`"
git push origin gh-pages

# checkout
git checkout master
