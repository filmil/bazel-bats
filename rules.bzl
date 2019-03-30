# From: 
# https://stackoverflow.com/questions/47192668/idiomatic-retrieval-of-the-bazel-execution-path#

def _dirname(path):
  prefix, _, _ = path.rpartition("/")
  return prefix.rstrip("/")


def _bats_test_impl(ctx):
  runfiles = ctx.runfiles(
      files = ctx.files.srcs,
      collect_data = True,
  )
  tests = ["\"{}\"".format(f.short_path) for f in ctx.files.srcs]
  path = ["$PWD/" + _dirname(b.short_path) for b in ctx.files.deps]
  l = ['export {}="{}"'.format(
        key, ctx.expand_location(val, ctx.files.deps)) for key, val in ctx.attr.env.items()]
  env = "\n".join(l)

  sep = ctx.configuration.host_path_separator

  BASH_TEMPLATE = """#!/usr/bin/env bash
set -e
export TMPDIR="$TEST_TMPDIR"
export PATH="{bats_bins_path}":$PATH
{env}
"{bats}" {test_paths}
"""
  content = BASH_TEMPLATE.format(
      bats = ctx.executable._bats.short_path,
      bats_bins_path = sep.join(path),
      env=env,
      test_paths = " ".join(tests),
  )
  ctx.file_action(
      output = ctx.outputs.executable,
      executable = True,
      content = content,
  )
  runfiles = runfiles.merge(ctx.attr._bats.default_runfiles)
  return DefaultInfo(
      runfiles = runfiles,
  )


bats_test = rule(
    _bats_test_impl,
    attrs = {
      "deps": attr.label_list(),
      "env": attr.string_dict(
          doc = "A list of key-value pairs of environment variables to define",
      ),
      "srcs": attr.label_list(
          allow_files = [".bats"],
          doc = "Source files to run a bats test on",
      ),
      "_bats": attr.label(
         default = Label("@bats_core//:bats"),
         executable = True,
         cfg = "host",
      ),
    },
    test = True,
    doc = "Runs a BATS test on the supplied source files",
)

