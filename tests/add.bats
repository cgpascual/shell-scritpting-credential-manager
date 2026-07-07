#!/usr/bin/env bats

load test_helper

setup() {
    setup_empty_file
}

@test "add credential" {

    run ./credential_manager.sh add \
        "$TEST_FILE" \
        github \
        john \
        pass123 \
        admin

    [ "$status" -eq 0 ]

    run grep "^github |" "$TEST_FILE"

    [ "$status" -eq 0 ]
}