#!/bin/bash

function cleanup {
    echo cleanup-time
    docker-compose kill
    docker-compose rm --force
}

function test {
    echo test-time
    docker-compose pull
    docker-compose build
    docker-compose run test
    return $?
}

function publish {
    echo publish-time
    docker-compose run -e IMAGE_NAME=$DOCKER_IMAGE -e TAG=$DOTCI_SHA publish
    return $?
}

cleanup
test
TEST=$?
if [[ "$TEST" -eq "0" && -n "$DOCKER_IMAGE" && -n "$DOTCI_SHA" ]]; then
    publish
fi
cleanup

exit $TEST
