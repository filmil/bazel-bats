#!/usr/bin/env bats

@test "addition using bc" {
  result="$(echo 4)"
  [ "$result" -eq 4 ]
}

