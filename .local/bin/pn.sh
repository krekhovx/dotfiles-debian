#!/bin/sh
#
# Simple auto-push script.
# Just send changes without caring about commit messages.
#

git_status=$(git status -s)
tree > README
git add .
git commit -m "$git_status"
git push
