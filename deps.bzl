load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

BATS_CORE_BUILD_CONTENT = """
load("@rules_shell//shell:sh_binary.bzl", "sh_binary")
load("@rules_shell//shell:sh_library.bzl", "sh_library")
load("@rules_shell//shell:sh_test.bzl", "sh_test")

sh_library(
    name = "bats_lib",
    srcs = glob(["libexec/**"]),
)

sh_binary(
    name = "bats",
    srcs = ["bin/bats"],
    visibility = ["//visibility:public"],
    deps = [":bats_lib"],
)

sh_library(
    name = "file_setup_teardown_lib",
    srcs = ["test/file_setup_teardown.bats"],
    visibility = ["//visibility:public"],
    data = glob(["test/fixtures/file_setup_teardown/**"]),
)

sh_library(
    name = "junit_formatter_lib",
    srcs = ["test/junit-formatter.bats"],
    visibility = ["//visibility:public"],
    data = glob(["test/fixtures/junit-formatter/**"]),
)

sh_library(
    name = "parallel_lib",
    srcs = ["test/parallel.bats"],
    visibility = ["//visibility:public"],
    data = glob([
        "test/concurrent-coordination.bash",
        "test/fixtures/parallel/**",
    ]),
)

sh_library(
    name = "run_lib",
    srcs = ["test/run.bats"],
    visibility = ["//visibility:public"],
    data = glob(["test/fixtures/run/**"]),
)

sh_library(
    name = "suite_lib",
    srcs = ["test/suite.bats"],
    visibility = ["//visibility:public"],
    data = glob(["test/fixtures/suite/**"]),
)

sh_library(
    name = "test_helper",
    srcs = ["test/test_helper.bash"],
    visibility = ["//visibility:public"],
)

sh_library(
    name = "trace_lib",
    srcs = ["test/trace.bats"],
    visibility = ["//visibility:public"],
    data = glob(["test/fixtures/trace/**"]),
)

exports_files(glob(["test/*.bats"]))
"""

BATS_ASSERT_BUILD_CONTENT = """
filegroup(
    name = "load_files",
    srcs = [
        "load.bash",
    ] + glob([
        "src/**/*.bash",
    ]),
    visibility = ["//visibility:public"],
)
"""

BATS_SUPPORT_BUILD_CONTENT = """
filegroup(
    name = "load_files",
    srcs = [
        "load.bash",
    ] + glob([
        "src/**/*.bash",
    ]),
    visibility = ["//visibility:public"],
)
"""

def bazel_bats_dependencies(
    version = "1.7.0",
    sha256 = "ac70c2a153f108b1ac549c2eaa4154dea4a7c1cc421e3352f0ce6ea49435454e",
    bats_assert_version = None,
    bats_assert_sha256 = None,
    bats_support_version = None,
    bats_support_sha256 = None
):
    if not sha256:
        fail("sha256 for bats-core was not supplied.")

    maybe(
        http_archive,
        name = "bats_core",
        build_file_content = BATS_CORE_BUILD_CONTENT,
        urls = [
            "https://github.com/bats-core/bats-core/archive/refs/tags/v%s.tar.gz" % version,
        ],
        strip_prefix = "bats-core-%s" % version,
        sha256 = sha256,
    )

    if bats_assert_version:
        if not bats_support_version:
            fail("bats-assert version was set, but was missing set version for dependency bats-support.")
        if not bats_assert_sha256:
            fail("sha256 for bats-assert was not supplied.")
        maybe(
            http_archive,
            name = "bats_assert",
            build_file_content = BATS_ASSERT_BUILD_CONTENT,
            sha256 = bats_assert_sha256,
            strip_prefix = "bats-assert-%s" % bats_assert_version,
            urls = [
                "https://github.com/bats-core/bats-assert/archive/refs/tags/v%s.tar.gz" % bats_assert_version,
            ],
        )
    if bats_support_version:
        if not bats_support_sha256:
            fail("sha256 for bats-support was not supplied.")
        maybe(
            http_archive,
            name = "bats_support",
            build_file_content = BATS_SUPPORT_BUILD_CONTENT,
            sha256 = bats_support_sha256,
            strip_prefix = "bats-support-%s" % bats_support_version,
            urls = [
                "https://github.com/bats-core/bats-support/archive/refs/tags/v%s.tar.gz" % bats_support_version,
            ],
        )

