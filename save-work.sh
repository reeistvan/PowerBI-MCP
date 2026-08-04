#!/bin/bash

set -e

cd "$(dirname "$0")"

echo "Aktualis branch:"
git branch --show-current

echo "Valtozasok ellenorzese..."
git status --short

if [ -z "$(git status --porcelain)" ]; then
    echo "Nincs mentendo valtozas."
    exit 0
fi

MESSAGE="${1:-Munka mentese}"

git add .
git commit -m "$MESSAGE"
git push

echo "A valtozasok felkerultek a GitHubra."