#!/bin/sh
set -e

INPUT_BRANCH=${INPUT_BRANCH:-master}
INPUT_FORCE=${INPUT_FORCE:-false}
INPUT_TAGS=${INPUT_TAGS:-false}
INPUT_DIRECTORY=${INPUT_DIRECTORY:-'.'}
_FORCE_OPTION=''
REPOSITORY=${INPUT_REPOSITORY:-$GITHUB_REPOSITORY}

[ -z "${INPUT_GITHUB_TOKEN}" ] && {
    echo 'Missing input "github_token: ${{ secrets.GITHUB_TOKEN }}".';
    exit 1;
};

_git_is_dirty() {
    [ -n "$(git status -s)" ]
}

if _git_is_dirty; then
    echo "Commit to branch $INPUT_BRANCH";
    git config --local user.email "kristofer@kristoferbaxter.com"
    git config --local user.name "Kristofer Baxter"
    git add .
    git commit -m "Pushed Changes from Github Actions Bot"

    echo "Push to branch $INPUT_BRANCH";
    if ${INPUT_FORCE}; then
        _FORCE_OPTION='--force'
    fi

    if ${TAGS}; then
        _TAGS='--tags'
    fi

    cd ${INPUT_DIRECTORY}

    remote_repo="https://${GITHUB_ACTOR}:${INPUT_GITHUB_TOKEN}@github.com/${REPOSITORY}.git"

    git push "${remote_repo}" HEAD:${INPUT_BRANCH} --follow-tags $_FORCE_OPTION $_TAGS;
else
    echo "Working tree clean. Nothing to commit."
fi
