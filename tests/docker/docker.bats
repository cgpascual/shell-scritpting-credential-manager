#!/usr/bin/env bats

IMAGE="credential-manager:0.0.1"


@test "docker image exists" {

    run docker image inspect "$IMAGE"

    [ "$status" -eq 0 ]
}


@test "container starts successfully" {

    run docker run --rm "$IMAGE"

    [ "$status" -eq 0 ]
}


@test "container creates credential file" {

    TEST_DIR="$BATS_TEST_TMPDIR/data"

    mkdir -p "$TEST_DIR"


    run docker run \
        --rm \
        -v "$TEST_DIR:/app/data" \
        "$IMAGE" \
        create data/credentials.txt


    [ "$status" -eq 0 ]

    [ -f "$TEST_DIR/credentials.txt" ]
}


@test "container adds credential" {

    TEST_DIR="$BATS_TEST_TMPDIR/data"

    mkdir -p "$TEST_DIR"


    docker run \
        --rm \
        -v "$TEST_DIR:/app/data" \
        "$IMAGE" \
        create data/credentials.txt


    run docker run \
        --rm \
        -v "$TEST_DIR:/app/data" \
        "$IMAGE" \
        add data/credentials.txt github john pass123 admin


    [ "$status" -eq 0 ]


    grep "github | john | pass123 | admin" \
    "$TEST_DIR/credentials.txt"
}