#!/usr/bin/env bash

setup_empty_file() {
    TEST_FILE="$BATS_TEST_TMPDIR/test.txt"
    cp test_data/empty_credentials.txt "$TEST_FILE"
}

setup_sample_file() {
    TEST_FILE="$BATS_TEST_TMPDIR/test.txt"
    cp test_data/sample_credentials.txt "$TEST_FILE"
}

setup_invalid_file() {
    TEST_FILE="$BATS_TEST_TMPDIR/test.txt"
    cp test_data/invalid_credentials.txt "$TEST_FILE"
}