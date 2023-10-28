#!/usr/bin/env bats

PATH_TO_WRAPPER_SCRIPT="tests/wrapper_script_for_exit_with_input"

@test "can run executable with dep" {
  run "${PATH_TO_WRAPPER_SCRIPT}"
  [ $status -eq 2 ]
  [ "$output" == "Given for output: hello from wrapper" ]
}
