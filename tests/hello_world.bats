#!/usr/bin/env bats

@test "addition using bc" {
  result="$(echo 4)"
  [ "$result" -eq 4 ]
}

@test "Test simple environment variable" {
  [ "${PROGRAM}" == "hello_world" ]
}

@test "Test environment variable expanded from bazel location" {
  echo "Location: ${LOCATED}"
  [ "${LOCATED}" == "tests/dummy.txt" ]
}

@test "Test environment variable expanded from bazel string flag" {
  echo "Flag env var: ${TOOLCHAIN_STRING_FLAG_ENV_VAR}"
  [ "${TOOLCHAIN_STRING_FLAG_ENV_VAR}" == "flag_value" ]
}
