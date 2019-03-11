# bazel-bats: bazel test rules for the BATS testing framework (bats-core)

## Usage

In your `WORKSPACE` file load and include as follows:

```
# Based on the work from:
# https://jayconrod.com/posts/106/writing-bazel-rules--simple-binary-rule
load("//:deps.bzl", "bazel_bats_dependencies")

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

