#!/usr/bin/env bats

load test_helper

setup() {
    setup_sample_file
}

@test "search github credential" {

    run ./credential_manager.sh search "$TEST_FILE" github

    [ "$status" -eq 0 ]
    [[ "$output" == *github* ]]
}