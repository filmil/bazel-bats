# Based on the work from:
# https://stackoverflow.com/questions/47192668/idiomatic-retrieval-of-the-bazel-execution-path#
workspace(name = "bazel_bats")

BATS_CORE_VERSION = "1.7.0"
BATS_CORE_SHA256 = "ac70c2a153f108b1ac549c2eaa4154dea4a7c1cc421e3352f0ce6ea49435454e"

load("@bazel_bats//:deps.bzl", "bazel_bats_dependencies")

bazel_bats_dependencies(
    version = BATS_CORE_VERSION,
    sha256 = BATS_CORE_SHA256)
