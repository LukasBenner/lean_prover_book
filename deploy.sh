#!/usr/bin/bash
set -eu
set -v

rm -rdf deploy

# 1. Build

python3 ./lean_source/mkdoc.py

make clean
make html
make latexpdf

# 3. Deploy

git clone https://github.com/DEST_REPO deploy

cd deploy

rm -rf ./html
rm -rf ./src

cp -rf ../dest_repo/. .
cp -f ../leanpkg.toml .

cp -rf ../build/html ./html
cp -f ../build/latex/BOOK_FILE_NAME.pdf .
cp -rf ../src ./src

DATE=$(date +"%m/%d/%Y %T")

git add .
git commit -m "Update $DATE"
git push

cd ..
rm -rf deploy
