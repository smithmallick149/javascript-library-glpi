#!/usr/bin/env bash

git checkout "$TRAVIS_BRANCH"
yarn release -t ''
export GIT_TAG=$(jq -r ".version" package.json)
git reset HEAD^1

yarn build 

if [ "$TRAVIS_BRANCH" = "develop" ] 
then
    if [[ "$TRAVIS_COMMIT_MESSAGE" != *"ci(build): update library to version "* ]]
    then 
        echo '>.<'
    fi
    git add lib/
    git commit -m "ci(build): update library to version ${GIT_TAG}"
    git push origin "$TRAVIS_BRANCH"
fi