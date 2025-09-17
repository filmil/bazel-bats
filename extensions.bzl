load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load(":deps.bzl", "bazel_bats_dependencies")

def _bazel_bats_deps_impl(ctx):
    bats_core_version = None
    bats_core_sha256 = None
    bats_assert_version = None
    bats_assert_sha256 = None
    bats_support_version = None
    bats_support_sha256 = None
    for mod in ctx.modules:
        for bats_core in mod.tags.bats_core:
            bats_core_version = bats_core.version
            bats_core_sha256 = bats_core.sha256
        for bats_assert in mod.tags.bats_assert:
            bats_assert_version = bats_assert.version
            bats_assert_sha256 = bats_assert.sha256
        for bats_support in mod.tags.bats_support:
            bats_support_version = bats_support.version
            bats_support_sha256 = bats_support.sha256

    bazel_bats_dependencies(
        version=bats_core_version,
        sha256=bats_core_sha256,
        bats_assert_version=bats_assert_version,
        bats_assert_sha256=bats_assert_sha256,
        bats_support_version=bats_support_version,
        bats_support_sha256=bats_support_sha256,
    )


_dep_class = tag_class( attrs = {
    "version": attr.string(doc = "The version of the dependency to download."),
    "sha256": attr.string(doc = "The sha256 hash of the dependency archive."),
})
bazel_bats_deps = module_extension(
    implementation = _bazel_bats_deps_impl,
    tag_classes = {
        "bats_core": _dep_class,
        "bats_assert": _dep_class,
        "bats_support": _dep_class,
    },
)
