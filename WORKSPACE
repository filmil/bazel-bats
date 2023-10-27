# Based on the work from:
# https://stackoverflow.com/questions/47192668/idiomatic-retrieval-of-the-bazel-execution-path#
workspace(name = "bazel_bats")

BATS_ASSERT_VERSION = "2.0.0"
BATS_ASSERT_SHA256 = "15dbf1abb98db785323b9327c86ee2b3114541fe5aa150c410a1632ec06d9903"
BATS_CORE_VERSION = "1.7.0"
BATS_CORE_SHA256 = "ac70c2a153f108b1ac549c2eaa4154dea4a7c1cc421e3352f0ce6ea49435454e"
BATS_SUPPORT_VERSION = "0.3.0"
BATS_SUPPORT_SHA256 = "7815237aafeb42ddcc1b8c698fc5808026d33317d8701d5ec2396e9634e2918f"

load("@bazel_bats//:deps.bzl", "bazel_bats_dependencies")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

bazel_bats_dependencies(
    version = BATS_CORE_VERSION,
    sha256 = BATS_CORE_SHA256,
    bats_assert_version = BATS_ASSERT_VERSION,
    bats_assert_sha256 = BATS_ASSERT_SHA256,
    bats_support_version = BATS_SUPPORT_VERSION,
    bats_support_sha256 = BATS_SUPPORT_SHA256
)

# Used for testing support/compatibility with `string_flag()` from
# `@bazel_skylib//rules:common_settings.bzl` (specifically testing make variable support).
# TODO: Update from `git_repository()` to `http_archive()` once a tag/release >1.4.2 is out.
#       Specifically looking for changes from https://github.com/bazelbuild/bazel-skylib/pull/440.
#       See https://github.com/bazelbuild/bazel-skylib/issues/471.
git_repository(
    name = "bazel_skylib",
    # Latest `main` commit that contains desired changes.
    commit = "652c8f0b2817daaa2570b7a3b2147643210f7dc7",
    remote = "https://github.com/bazelbuild/bazel-skylib.git",
)
