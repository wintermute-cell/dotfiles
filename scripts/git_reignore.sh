#!/usr/bin/env bash

read -p 'Apply new .gitignore? [Y/n] ' reply
if [[ $reply =~ ^[Nn]$ ]]
then
    exit 0
fi

git rm -r --cached .
if [ $? -ne 0 ]
then
    echo "git rm failed"
    exit 1
fi
git add .
if [ $? -ne 0 ]
then
    echo "git add failed"
    exit 1
fi
git commit -m "fixed missing gitignore entries"
if [ $? -ne 0 ]
then
    echo "git commit failed"
    exit 1
fi
git push
