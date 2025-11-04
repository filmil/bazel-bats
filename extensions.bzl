load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load(":deps.bzl", "bazel_bats_dependencies")

def _bazel_bats_deps_impl(ctx):
    bats_core_version = "1.7.0"
    bats_core_sha256 = "ac70c2a153f108b1ac549c2eaa4154dea4a7c1cc421e3352f0ce6ea49435454e"
    bats_assert_version = "2.0.0"
    bats_assert_sha256 = "15dbf1abb98db785323b9327c86ee2b3114541fe5aa150c410a1632ec06d9903"
    bats_support_version = "0.3.0"
    bats_support_sha256 = "7815237aafeb42ddcc1b8c698fc5808026d33317d8701d5ec2396e9634e2918f"
    for mod in ctx.modules:
        for bats_core in mod.tags.bats_core:
            if bats_core.version:
                bats_core_version = bats_core.version
            if bats_core.sha256:
                bats_core_sha256 = bats_core.sha256
        for bats_assert in mod.tags.bats_assert:
            if bats_assert.version:
                bats_assert_version = bats_assert.version
            if bats_assert.sha256:
                bats_assert_sha256 = bats_assert.sha256
        for bats_support in mod.tags.bats_support:
            if bats_support.version:
                bats_support_version = bats_support.version
            if bats_support.sha256:
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
    "version": attr.string(default = "", doc = "The version of the dependency to download."),
    "sha256": attr.string(default = "", doc = "The sha256 hash of the dependency archive."),
})
bazel_bats_deps = module_extension(
    implementation = _bazel_bats_deps_impl,
    tag_classes = {
        "bats_core": _dep_class,
        "bats_assert": _dep_class,
        "bats_support": _dep_class,
    },
)
