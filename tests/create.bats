#!/usr/bin/env bats

setup() {
    TEST_FILE="$BATS_TEST_TMPDIR/test.txt"
}

@test "create credential file" {

    run ./credential_manager.sh create "$TEST_FILE"

    [ "$status" -eq 0 ]
    [ -f "$TEST_FILE" ]
}