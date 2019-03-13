#!/usr/bin/env bats

@test "addition using bc" {
  result="$(echo 4)"
  [ "$result" -eq 4 ]
}

@test "Test program name" {
  [ "${PROGRAM}" == "hello_world" ]
}

