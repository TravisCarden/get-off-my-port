#!/usr/bin/env sh

cd "$(dirname "$0")" && clear || exit 1

./bats/bin/bats test.bats
