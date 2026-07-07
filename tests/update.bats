#!/usr/bin/env bats

load test_helper

setup() {
    setup_sample_file
}

@test "update credential" {

    run ./credential_manager.sh update \
        "$TEST_FILE" \
        github \
        peter \
        newpass \
        developer

    [ "$status" -eq 0 ]
}