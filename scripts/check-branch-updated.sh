#!/bin/sh

target_branch=${1:-"origin/main"}

no_of_commits_behind="$(git rev-list .."${target_branch}" | wc -l )"

if [ $no_of_commits_behind = 0 ]; then
    echo "branch is up to date"
else 
    echo "branch is behind ${target_branch} of ${no_of_commits_behind}"
    exit 1
fi
