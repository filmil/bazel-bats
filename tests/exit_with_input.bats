#!/usr/bin/env bats

PATH_TO_EXIT_WITH_INPUT="tests/exit_with_input"

@test "can run executable" {
  run "${PATH_TO_EXIT_WITH_INPUT}" 1
  [ $status -eq 1 ]
}

@test "can run executable with different return code" {
  run "${PATH_TO_EXIT_WITH_INPUT}" 2
  [ $status -eq 2 ]
}
