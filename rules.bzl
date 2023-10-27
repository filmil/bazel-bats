# From:
# https://stackoverflow.com/questions/47192668/idiomatic-retrieval-of-the-bazel-execution-path#

def _dirname(path):
    prefix, _, _ = path.rpartition("/")
    return prefix.rstrip("/")

def _test_files(bats, srcs):
    return '"{bats_bin}" {test_paths}'.format(
        bats_bin = bats.short_path,
        test_paths = " ".join(['"{}"'.format(s.short_path) for s in srcs]),
    )

# Finds shortest path.
# Used to find commonpath for bats-assert or bats-support.
# This would not always necessarily return the correct path (in other contexts),
# but works for the filegroups used.
# A more robust method of finding the base directory is made more difficult by skylark's
# divergence from python. Bringing in skylab as a dependency was deemed overkill.
# So long as a file in the base dir exists (e.g. load.bash), this is fine.
def _base_dir(files):
    result = files[0].dirname
    min_len = len(files[0].dirname)
    for file in files:
        if len(file.dirname) < min_len:
            min_len = len(file.dirname)
            result = file.dirname
    return result

def _bats_test_impl(ctx):
    path = ["$PWD/" + _dirname(b.short_path) for b in ctx.files.deps]
    sep = ctx.configuration.host_path_separator

    content = "\n".join(
        ["#!/usr/bin/env bash"] +
        ["set -e"] +
        ["export TMPDIR=\"$TEST_TMPDIR\""] +
        ["export PATH=\"{bats_bins_path}\":$PATH".format(bats_bins_path = sep.join(path))] +
        [
            # First try and expand `$(location ...)`.
            # Then try for make variables (possibly supplied by toolchains).
            'export {}="{}"'.format(
                key,
                ctx.expand_make_variables(
                    key,
                    ctx.expand_location(val, ctx.attr.deps),
                    {}
                )
            )
            for key, val in ctx.attr.env.items()
        ] +
        [_test_files(ctx.executable._bats, ctx.files.srcs)],
    )
    ctx.actions.write(
        output = ctx.outputs.executable,
        content = content,
    )

    runfiles = ctx.runfiles(
        files = ctx.files.srcs,
        transitive_files = depset(ctx.files.data + ctx.files.deps),
    ).merge(ctx.attr._bats.default_runfiles)
    return [DefaultInfo(runfiles = runfiles)]

def _bats_with_bats_assert_test_impl(ctx):
    base_info = _bats_test_impl(ctx)[0]

    bats_assert_base_dir = _base_dir(ctx.attr._bats_assert.files.to_list())
    bats_support_base_dir = _base_dir(ctx.attr._bats_support.files.to_list())
    test_helper_outputs = []
    for src_file in ctx.files.srcs:
        test_helper_dir = ctx.actions.declare_directory(
            "test_helper",
            sibling = src_file,
        )
        test_helper_outputs.append(test_helper_dir)
        ctx.actions.run_shell(
            outputs=[test_helper_dir],
            inputs=depset(ctx.attr._bats_assert.files.to_list() + ctx.attr._bats_support.files.to_list()),
            arguments=[test_helper_dir.path, bats_assert_base_dir, bats_support_base_dir],
            command="""
            mkdir -p $1/bats-support $1/bats-assert \\
                && cp -r $2/* $1/bats-assert \\
                && cp -r $3/* $1/bats-support
            """)

    runfiles = ctx.runfiles(
        files = test_helper_outputs,
    ).merge(base_info.default_runfiles)
    return [DefaultInfo(runfiles = runfiles)]

_bats_test_attrs = {
    "data": attr.label_list(allow_files = True),
    "deps": attr.label_list(),
    "env": attr.string_dict(
        doc = "A list of key-value pairs of environment variables to define",
    ),
    "srcs": attr.label_list(
        allow_files = [".bats"],
        doc = "Source files to run a BATS test on",
    ),
    "_bats": attr.label(
        default = Label("@bats_core//:bats"),
        executable = True,
        cfg = "exec",
    ),
}

_bats_with_bats_assert_test_attrs = _bats_test_attrs | {
    "_bats_support": attr.label(
        default = Label("@bats_support//:load_files"),
    ),
    "_bats_assert": attr.label(
        default = Label("@bats_assert//:load_files"),
    ),
}

_bats_test = rule(
    _bats_test_impl,
    attrs = _bats_test_attrs,
    test = True,
    doc = "Runs a BATS test on the supplied source files.",
)

_bats_with_bats_assert_test = rule(
    _bats_with_bats_assert_test_impl,
    attrs = _bats_with_bats_assert_test_attrs,
    test = True,
    doc = "Runs a BATS test on the supplied source files, allowing for usage of bats-support and bats-assert.",
)


def bats_test(uses_bats_assert = False, **kwargs):
  if not uses_bats_assert:
    _bats_test(**kwargs)
  else:
    _bats_with_bats_assert_test(**kwargs)


# Inspired from `rules_rust`
def bats_test_suite(name, srcs, **kwargs):
    """
    A rule for creating a test suite for a set of `bats_test` targets.

    The rule can be used to generate `bats_test` targets for each source file and a `test_suite`
    which encapsulates all tests.

    Args:
        name (str): The name of the `test_suite`.
        srcs (list): All test sources, typically `glob(["*.bats"])`.
        **kwargs (dict): Additional keyword arguments for the underyling `bats_test` targets. The
            `tags` argument is also passed to the generated `test_suite` target.
    """
    tests = []

    for src in srcs:
        # Prefixed with `name` to allow parameterization with macros
        # The test name should not end with `.bats`
        test_name = name + "_" + src[:-5]
        bats_test(
            name = test_name,
            srcs = [src],
            **kwargs
        )
        tests.append(test_name)

    native.test_suite(
        name = name,
        tests = tests,
        tags = kwargs.get("tags", None),
    )
