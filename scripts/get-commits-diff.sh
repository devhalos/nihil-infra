#!/bin/sh

old_branch=${1:-"origin/main"}
new_branch=${2:-"HEAD"}

git log --oneline --pretty='format:%Creset%s' "^$old_branch" "$new_branch" | tac