#!/usr/bin/env bats

load ../helpers/test_helper

setup() {
    setup_sample_file
}

@test "list credentials" {

    run ./credential_manager.sh list "$TEST_FILE"

    [ "$status" -eq 0 ]
}