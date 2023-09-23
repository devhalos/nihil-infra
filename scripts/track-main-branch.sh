#!/bin/sh

current_branch=$(git branch --show-current)

if [ "$current_branch" != 'main' ]; then
    git fetch origin main
    git branch --track main origin/main
fi
