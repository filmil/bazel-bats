# From:
# https://stackoverflow.com/questions/47192668/idiomatic-retrieval-of-the-bazel-execution-path#
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def bazel_bats_dependencies(
        version = "1.5.0",
        sha256 = "36a3fd4413899c0763158ae194329af8f48bb1ff0d1338090b80b3416d5793af"):
    http_archive(
        name = "bats_core",
        build_file = "@//:third_party/BUILD.bats_core",
        urls = [
            "https://github.com/bats-core/bats-core/archive/refs/tags/v%s.tar.gz" % version,
        ],
        strip_prefix = "bats-core-%s" % version,
        sha256 = sha256,
    )
