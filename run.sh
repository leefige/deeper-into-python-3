#!/bin/bash
# clear
./publish.sh clear

# publish
./publish.sh

# update docs
rm -r docs
mkdir docs
mv index.html docs/index.html
mv pages docs/pages

# commit & push
git add .
git commit -m "Update pages: `date +%Y-%m-%d,%H:%m:%S`"
git push

# clear
./publish.sh clear
