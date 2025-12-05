#!/bin/sh
#
# Push to notes: https://github.com/krekhovx/krxnotes
# I'm not concerned about commit descriptions in this project.
#

git_status=$(git status -s)
tree > README
git add .
git commit -m "$git_status"
git push
