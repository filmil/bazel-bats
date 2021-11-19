# From:
# https://stackoverflow.com/questions/47192668/idiomatic-retrieval-of-the-bazel-execution-path#
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository", "new_git_repository")

BATS_CORE_BUILD="""
sh_library(
  name = "bats_lib",
  srcs = glob(["libexec/**"]),
)

sh_binary(
  name = "bats",
  srcs = ["bin/bats"],
  deps = [":bats_lib"],
  visibility = ["//visibility:public"],
)
"""

def bazel_bats_dependencies(version="v1.5.0"):
    new_git_repository(
        name = "bats_core",
        remote = "https://github.com/bats-core/bats-core",
        tag = version,
        build_file_content = BATS_CORE_BUILD,
    )
