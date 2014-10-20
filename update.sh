#!/bin/sh
jekyll build
git add *
git commit
git push origin master
