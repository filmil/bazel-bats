#!/usr/bin/env bats

load "helper"

@test "can run function from loaded library" {
  run echo4
  [ $status -eq 0 ]
  [ "$output" == "4" ]
}
