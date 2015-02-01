#!/bin/sh
jekyll build
git add *
git rm _site -r
git commit
git push origin master
