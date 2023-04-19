#!/usr/bin/bash
set -eu
set -v

rm -rdf deploy

# 1. Build

./lean_source/mkall.sh

make clean
make html
make latexpdf

# 3. Deploy

git clone git@github.com:YOUR DESTINATION REPOSITORY deploy

cd deploy

rm -rf *
cp -rf ../user_repo/. .
cp -rf ../build/html ./html
cp ../build/latex/title_of_the_book.pdf .
cp -rf ../src ./src

DATE=$(date +"%m/%d/%Y %T")


git add .
git commit -m "Update $DATE"
git push

cd ..
rm -rf deploy
