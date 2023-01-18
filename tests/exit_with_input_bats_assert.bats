#!/usr/bin/env bats

PATH_TO_EXIT_WITH_INPUT="tests/exit_with_input"

setup() {
    load "test_helper/bats-support/load"
    load "test_helper/bats-assert/load"
}

@test "can run succeeding executable" {
  run "${PATH_TO_EXIT_WITH_INPUT}" 0

  assert_success
  refute_output
}

@test "can run succeeding executable with output" {
  run "${PATH_TO_EXIT_WITH_INPUT}" 0 'some message'

  assert_success
  assert_output --partial 'Given for output:'
  assert_output --partial 'some message'
  assert_output --regexp '^Given for output: some message$'
  assert_output 'Given for output: some message'
  refute_output 'never printed'
}

@test "can run failing executable" {
  run "${PATH_TO_EXIT_WITH_INPUT}" 1

  assert_failure
  assert_failure 1
  refute_output
}

@test "can run failing executable with output" {
  run "${PATH_TO_EXIT_WITH_INPUT}" 1 'some message'

  assert_failure
  assert_failure 1
  assert_output --partial 'Given for output:'
  assert_output --partial 'some message'
  assert_output --regexp '^Given for output: some message$'
  assert_output 'Given for output: some message'
  refute_output 'never printed'
}

@test "can run failing executable with different return code" {
  run "${PATH_TO_EXIT_WITH_INPUT}" 2

  assert_failure
  assert_failure 2
  refute_output
}

@test "can run failing executable with different return code with output" {
  run "${PATH_TO_EXIT_WITH_INPUT}" 2 'some message'

  assert_failure
  assert_failure 2
  assert_output --partial 'Given for output:'
  assert_output --partial 'some message'
  assert_output --regexp '^Given for output: some message$'
  assert_output 'Given for output: some message'
  refute_output 'never printed'
}
