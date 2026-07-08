#!/usr/bin/env bats

load ../helpers/test_helper

setup() {
    setup_sample_file
}

@test "delete credential" {

    run ./credential_manager.sh delete "$TEST_FILE" github

    [ "$status" -eq 0 ]
}