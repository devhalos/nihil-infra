#!/bin/sh

command=$1

current_branch=$(git branch --show-current)
base=main
head=HEAD

if [ "$current_branch" = 'main' ]; then
    base=main~1
    head=main
else
    sh ./scripts/track-main-branch.sh
fi

npx nx affected -t "$command" --base=$base --head=$head
