#!/bin/sh

current_branch=$(git branch --show-current)
is_main_branch_exists=$(git show-ref --quiet 'refs/heads/main' && echo true || echo false)

if [ "$current_branch" != 'main' ] && [ "$is_main_branch_exists" != true ]; then
    git fetch origin main
    git branch --track main origin/main
fi
