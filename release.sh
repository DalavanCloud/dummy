#!/bin/bash

set -e

if [ "$GITHUB_TOKEN" == "" ]
then
  echo "GITHUB_TOKEN is missing"
  exit 1
fi

if [ "$TRAVIS_TAG" == "" ]
then
  echo "TRAVIS_TAG is not defined"
  exit 1
fi

./writeVersion.js

echo "Setting up git & pushing package.json"
git config --global user.email "koss+jake-the-bot@nocorp.me"
git config --global user.name "Jake the Bot"
git add package.json
git commit --message "Prepare release"
git remote add origin-pages "https://$GITHUB_TOKEN@github.com/date-fns/dummy.git" #> /dev/null 2>&1`
git push --set-upstream origin master