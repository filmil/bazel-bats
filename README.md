# bazel-bats: bazel test rules for the BATS testing framework (bats-core)

![Build Status](https://github.com/filmil/bazel-bats/workflows/Build/badge.svg) | ![Build Status](https://github.com/filmil/bazel-bats/workflows/Test/badge.svg)

## Usage

In your `WORKSPACE` file load and include as follows:

```
# Make the rule "git_repository" available.
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

# Make the external repo "bazel_bats" available.
git_repository(
  name = "bazel_bats",
  remote = "https://github.com/filmil/bazel-bats",
  tag = "v0.1.1",
)

# Load the declaration "bazel_bats_dependencide"
load("@bazel_bats//:deps.bzl", "bazel_bats_dependencies")

# version can be omitted, in which case the default is used.
bazel_bats_dependencies(version="v1.1.0")
```

In your `BUILD.bazel` file add the following:

```
load("@bazel_bats//:rules.bzl", "bats_test")

bats_test(
  name = "hello_world_test",
  srcs = ["hello_world.bats"],
)
```

## Examples

This repository is an example of a repo with BATS tests.  If you have `bazel`
installed, you can try it out as follows:

```console
git clone https://github.com/filmil/bazel-bats.git
cd bazel-bats
bazel test //...
```

Feel free to take a look at the `WORKSPACE` file to see how your workspace file
should look like and at `tests/BUILD.bazel` to see a sample build file.

