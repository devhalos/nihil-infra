#!/bin/sh

for d in ./modules/*  ; do
    echo "linting module ${d}"
    cd "$d" || exit
    terraform init
    sh ../../../../scripts/lint-infrastructure.sh
done;
