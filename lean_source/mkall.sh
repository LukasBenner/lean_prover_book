#!/usr/bin/bash
set -eu
set -v

python3 lean_source/mkdoc.py 01_Introduction 01_Getting_Started
python3 lean_source/mkdoc.py 02_Basics 01_Basics