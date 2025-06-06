#!/bin/sh
#
# Push to notes: https://github.com/krekhovx/krxnotes
# I'm not concerned about commit descriptions in this project.
#

gitstatus=$(git status -s)
tree > ~/git/myenv/krxnotes/README
git add .
git commit -m "$gitstatus"
git push
