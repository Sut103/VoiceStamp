#!/bin/sh
pip install --upgrade pip
pip install -r requirements.txt
apt update
apt install git -y
git config --system --add safe.directory $1