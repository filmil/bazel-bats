#!/usr/bin/env bats

@test "can read from data" {
  run echo 4
  [ $status -eq 0 ]
  [ "$output" == "$(< 'testdata/golden_4.txt')" ]
}
