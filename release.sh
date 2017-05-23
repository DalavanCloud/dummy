#!/bin/bash

set -e

if [ "$TRAVIS_TAG" == "" ]
then
  echo "TRAVIS_TAG is not defined, skipping..."
  exit 0
fi

if [ "$GITHUB_JAKE_TOKEN" == "" ]
then
  echo "GITHUB_JAKE_TOKEN is missing"
  exit 1
fi

echo "Writing version to package.json..."
./writeVersion.js

echo "Setting up git & pushing package.json..."
git config --global user.email "koss+jake-the-bot@nocorp.me"
git config --global user.name "Jake the Bot"
git add package.json
git commit --message "Prepare release"
git remote add upstream "https://$GITHUB_JAKE_TOKEN@github.com/date-fns/dummy.git" #> /dev/null 2>&1`
git push --set-upstream upstream master
