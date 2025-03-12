#!/usr/bin/env bats

@test "addition using bc" {
  result="$(echo 4)"
  [ "$result" -eq 4 ]
}

@test "Test simple environment variable" {
  echo "Val: ${SIMPLE_VAL}"
  [ "${SIMPLE_VAL}" == "hello_world" ]
}

@test "Test escaped simple environment variable" {
  echo "Val: ${ESCAPED_SIMPLE_VAL}"
  [ "${ESCAPED_SIMPLE_VAL}" == "\$SIMPLE_VAL" ]
}

@test "Test double dollar sign escaped simple environment variable" {
  echo "Val: ${DOUBLE_DOLLAR_SIGN_ESCAPED_SIMPLE_VAL}"
  [ "${DOUBLE_DOLLAR_SIGN_ESCAPED_SIMPLE_VAL}" == "\$\$SIMPLE_VAL" ]
}

@test "Test environment variable expanded from bazel location" {
  echo "Location: ${LOCATION_VAL}"
  [ "${LOCATION_VAL}" == "tests/dummy.txt" ]
}

@test "Test environment variable expanded from bazel execpath" {
  echo "Execpath: ${EXECPATH_VAL}"
  [ "${EXECPATH_VAL}" == "tests/dummy.txt" ]
}

@test "Test environment variable expanded from bazel rootpath" {
  echo "Rootpath: ${ROOTPATH_VAL}"
  [ "${ROOTPATH_VAL}" == "tests/dummy.txt" ]
}

@test "Test environment variable expanded from bazel rlocationpath" {
  echo "Rlocationpath: ${RLOCATIONPATH_VAL}"
  [ "${RLOCATIONPATH_VAL}" == "_main/tests/dummy.txt" ]
}

@test "Test environment variable expanded from another variable in env attr" {
  echo "Flag env var: ${STRING_FLAG_TO_OTHER_ENV_VAR}"
  [ "${STRING_FLAG_TO_OTHER_ENV_VAR}" == "tests/dummy.txt" ]
}

@test "Test environment variable expanded from another variable from string_flag" {
  echo "Flag env var: ${STRING_FLAG_TO_STRING_FLAG_ENV_VAR}"
  [ "${STRING_FLAG_TO_STRING_FLAG_ENV_VAR}" == "tests/dummy.txt" ]
}

@test "Test environment variable expanded from bazel string flag (raw)" {
  echo "Flag env var: ${TOOLCHAIN_STRING_FLAG_ENV_VAR_RAW}"
  [ "${TOOLCHAIN_STRING_FLAG_ENV_VAR_RAW}" == "flag_value" ]
}

@test "Test environment variable expanded from bazel string flag (in parenthesis)" {
  echo "Flag env var: ${TOOLCHAIN_STRING_FLAG_ENV_VAR_PAREN}"
  [ "${TOOLCHAIN_STRING_FLAG_ENV_VAR_PAREN}" == "flag_value" ]
}

@test "Test environment variable expanded from bazel string flag (in curly braces)" {
  echo "Flag env var: ${TOOLCHAIN_STRING_FLAG_ENV_VAR_CURLY}"
  [ "${TOOLCHAIN_STRING_FLAG_ENV_VAR_CURLY}" == "flag_value" ]
}

@test "Test environment variable expanded from bazel string flag to location (raw)" {
  echo "Flag env var: ${STRING_FLAG_TO_LOCATION_ENV_VAR_RAW}"
  [ "${STRING_FLAG_TO_LOCATION_ENV_VAR_RAW}" == "tests/dummy.txt" ]
}

@test "Test environment variable expanded from bazel string flag to location (in parenthesis)" {
  echo "Flag env var: ${STRING_FLAG_TO_LOCATION_ENV_VAR_PAREN}"
  [ "${STRING_FLAG_TO_LOCATION_ENV_VAR_PAREN}" == "tests/dummy.txt" ]
}

@test "Test environment variable expanded from bazel string flag to location (in curly braces)" {
  echo "Flag env var: ${STRING_FLAG_TO_LOCATION_ENV_VAR_CURLY}"
  [ "${STRING_FLAG_TO_LOCATION_ENV_VAR_CURLY}" == "tests/dummy.txt" ]
}

@test "Test indirect simple environment variable (raw)" {
  echo "Val: ${INDIRECT_SIMPLE_VAL_RAW}"
  [ "${INDIRECT_SIMPLE_VAL_RAW}" == "hello_world" ]
}

@test "Test indirect simple environment variable (in parenthesis)" {
  echo "Val: ${INDIRECT_SIMPLE_VAL_PAREN}"
  [ "${INDIRECT_SIMPLE_VAL_PAREN}" == "hello_world" ]
}

@test "Test indirect simple environment variable (in curly braces)" {
  echo "Val: ${INDIRECT_SIMPLE_VAL_CURLY}"
  [ "${INDIRECT_SIMPLE_VAL_CURLY}" == "hello_world" ]
}

@test "Test indirect escaped simple environment variable (raw)" {
  echo "Val: ${INDIRECT_ESCAPED_SIMPLE_VAL_RAW}"
  [ "${INDIRECT_ESCAPED_SIMPLE_VAL_RAW}" == "\$SIMPLE_VAL" ]
}

@test "Test indirect escaped simple environment variable (in parenthesis)" {
  echo "Val: ${INDIRECT_ESCAPED_SIMPLE_VAL_PAREN}"
  [ "${INDIRECT_ESCAPED_SIMPLE_VAL_PAREN}" == "\$SIMPLE_VAL" ]
}

@test "Test indirect escaped simple environment variable (in curly braces)" {
  echo "Val: ${INDIRECT_ESCAPED_SIMPLE_VAL_CURLY}"
  [ "${INDIRECT_ESCAPED_SIMPLE_VAL_CURLY}" == "\$SIMPLE_VAL" ]
}

@test "Test indirect environment variable expanded from bazel location (raw)" {
  echo "Location: ${INDIRECT_LOCATION_VAL_RAW}"
  [ "${INDIRECT_LOCATION_VAL_RAW}" == "tests/dummy.txt" ]
}

@test "Test indirect environment variable expanded from bazel location (in parenthesis)" {
  echo "Location: ${INDIRECT_LOCATION_VAL_PAREN}"
  [ "${INDIRECT_LOCATION_VAL_PAREN}" == "tests/dummy.txt" ]
}

@test "Test indirect environment variable expanded from bazel location (in curly braces)" {
  echo "Location: ${INDIRECT_LOCATION_VAL_CURLY}"
  [ "${INDIRECT_LOCATION_VAL_CURLY}" == "tests/dummy.txt" ]
}

@test "Test indirect environment variable expanded from bazel execpath (raw)" {
  echo "Execpath: ${INDIRECT_EXECPATH_VAL_RAW}"
  [ "${INDIRECT_EXECPATH_VAL_RAW}" == "tests/dummy.txt" ]
}

@test "Test indirect environment variable expanded from bazel execpath (in parenthesis)" {
  echo "Execpath: ${INDIRECT_EXECPATH_VAL_PAREN}}"
  [ "${INDIRECT_EXECPATH_VAL_PAREN}" == "tests/dummy.txt" ]
}

@test "Test indirect environment variable expanded from bazel execpath (in curly braces)" {
  echo "Execpath: ${INDIRECT_EXECPATH_VAL_CURLY}"
  [ "${INDIRECT_EXECPATH_VAL_CURLY}" == "tests/dummy.txt" ]
}

@test "Test indirect environment variable expanded from bazel rootpath (raw)" {
  echo "Rootpath: ${INDIRECT_ROOTPATH_VAL_RAW}"
  [ "${INDIRECT_ROOTPATH_VAL_RAW}" == "tests/dummy.txt" ]
}

@test "Test indirect environment variable expanded from bazel rootpath (in parenthesis)" {
  echo "Rootpath: ${INDIRECT_ROOTPATH_VAL_PAREN}"
  [ "${INDIRECT_ROOTPATH_VAL_PAREN}" == "tests/dummy.txt" ]
}

@test "Test indirect environment variable expanded from bazel rootpath (in curly braces)" {
  echo "Rootpath: ${INDIRECT_ROOTPATH_VAL_CURLY}"
  [ "${INDIRECT_ROOTPATH_VAL_CURLY}" == "tests/dummy.txt" ]
}

@test "Test indirect environment variable expanded from bazel rlocationpath (raw)" {
  echo "Rlocationpath: ${INDIRECT_RLOCATIONPATH_VAL_RAW}"
  [ "${INDIRECT_RLOCATIONPATH_VAL_RAW}" == "_main/tests/dummy.txt" ]
}

@test "Test indirect environment variable expanded from bazel rlocationpath (in parenthesis)" {
  echo "Rlocationpath: ${INDIRECT_RLOCATIONPATH_VAL_PAREN}"
  [ "${INDIRECT_RLOCATIONPATH_VAL_PAREN}" == "_main/tests/dummy.txt" ]
}

@test "Test indirect environment variable expanded from bazel rlocationpath (in curly braces)" {
  echo "Rlocationpath: ${INDIRECT_RLOCATIONPATH_VAL_CURLY}"
  [ "${INDIRECT_RLOCATIONPATH_VAL_CURLY}" == "_main/tests/dummy.txt" ]
}

@test "Test indirect environment variable expanded from bazel string flag (raw)" {
  echo "Flag env var: ${INDIRECT_TOOLCHAIN_STRING_FLAG_ENV_VAR_RAW}"
  [ "${INDIRECT_TOOLCHAIN_STRING_FLAG_ENV_VAR_RAW}" == "flag_value" ]
}

@test "Test indirect environment variable expanded from bazel string flag (in parenthesis)" {
  echo "Flag env var: ${INDIRECT_TOOLCHAIN_STRING_FLAG_ENV_VAR_PAREN}"
  [ "${INDIRECT_TOOLCHAIN_STRING_FLAG_ENV_VAR_PAREN}" == "flag_value" ]
}

@test "Test indirect environment variable expanded from bazel string flag (in curly braces)" {
  echo "Flag env var: ${INDIRECT_TOOLCHAIN_STRING_FLAG_ENV_VAR_CURLY}"
  [ "${INDIRECT_TOOLCHAIN_STRING_FLAG_ENV_VAR_CURLY}" == "flag_value" ]
}

@test "Test indirect environment variable expanded from bazel string flag to location (raw)" {
  echo "Flag env var: ${INDIRECT_STRING_FLAG_TO_LOCATION_ENV_VAR_RAW}"
  [ "${INDIRECT_STRING_FLAG_TO_LOCATION_ENV_VAR_RAW}" == "tests/dummy.txt" ]
}

@test "Test indirect environment variable expanded from bazel string flag to location (in parenthesis)" {
  echo "Flag env var: ${INDIRECT_STRING_FLAG_TO_LOCATION_ENV_VAR_PAREN}"
  [ "${INDIRECT_STRING_FLAG_TO_LOCATION_ENV_VAR_PAREN}" == "tests/dummy.txt" ]
}

@test "Test indirect environment variable expanded from bazel string flag to location (in curly braces)" {
  echo "Flag env var: ${INDIRECT_STRING_FLAG_TO_LOCATION_ENV_VAR_CURLY}"
  [ "${INDIRECT_STRING_FLAG_TO_LOCATION_ENV_VAR_CURLY}" == "tests/dummy.txt" ]
}

@test "Test indirect multiple environment variables expanded (raw)" {
  echo "Muli env var: ${MULTI_INDIRECT_RAW}"
  [ "${MULTI_INDIRECT_RAW}" == "hello_world-\$SIMPLE_VAL-tests/dummy.txt-_main/tests/dummy.txt-flag_value-tests/dummy.txt" ]
}

@test "Test indirect multiple environment variables expanded (in parenthesis)" {
  echo "Muli env var: ${MULTI_INDIRECT_PAREN}"
  [ "${MULTI_INDIRECT_PAREN}" == "hello_world-\$SIMPLE_VAL-tests/dummy.txt-_main/tests/dummy.txt-flag_value-tests/dummy.txt" ]
}

@test "Test indirect multiple environment variables expanded (in curly braces)" {
  echo "Muli env var: ${MULTI_INDIRECT_CURLY}"
  [ "${MULTI_INDIRECT_CURLY}" == "hello_world-\$SIMPLE_VAL-tests/dummy.txt-_main/tests/dummy.txt-flag_value-tests/dummy.txt" ]
}
