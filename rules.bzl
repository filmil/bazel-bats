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

def _bats_test_impl(ctx):
  path = ["$PWD/" + _dirname(b.short_path) for b in ctx.files.deps]
  sep = ctx.configuration.host_path_separator

  content = "\n".join(
      ["#!/usr/bin/env bash"] +
      ["set -e"] +
      ["export TMPDIR=\"$TEST_TMPDIR\""] +
      ["export PATH=\"{bats_bins_path}\":$PATH".format(bats_bins_path = sep.join(path))] +
      [
          'export {}="{}"'.format(key, ctx.expand_location(val, ctx.attr.deps))
          for key, val in ctx.attr.env.items()
      ] +
      [_test_files(ctx.executable._bats, ctx.files.srcs)]
  )
  ctx.actions.write(
      output = ctx.outputs.executable,
      content = content,
  )
  runfiles = ctx.runfiles(
      files = ctx.files.srcs,
      collect_data = True,
  ).merge(ctx.attr._bats.default_runfiles)
  return [DefaultInfo(runfiles = runfiles)]


bats_test = rule(
    _bats_test_impl,
    attrs = {
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
    },
    test = True,
    doc = "Runs a BATS test on the supplied source files",
)

