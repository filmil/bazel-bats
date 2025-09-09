# bazel-bats: bazel test rules for the BATS testing framework (bats-core)

![Build Status](https://github.com/filmil/bazel-bats/workflows/Build/badge.svg)
![Test Status](https://github.com/filmil/bazel-bats/workflows/Test/badge.svg)
![Integration Status](https://github.com/filmil/bazel-bats/workflows/Integration/badge.svg)

## Usage

### `MODULE.bazel` (a.k.a. bzlmod)

```
bazel_dep(name = "bazel_bats", version = "0.35.0")
```

### Workspace

> Support for `WORKSPACE` was removed starting from bazel-bats 0.35.0. If you
> must use `WORKSPACE`, refer to earlier releases. Please acknowledge that
> earlier releases are not supported.

### Code changes

In your `BUILD.bazel` file add the following:

```
load("@bazel_bats//:rules.bzl", "bats_test")

bats_test(
  name = "hello_world_test",
  srcs = ["hello_world.bats"],
)
```

If your test would like to make use of the bats-assert extension
(`assert_success`, `assert_failure`, `assert_output`, etc), simply add
`uses_bats_assert = True` to your `bats_test()` target. This still requires
adding the appropriate `load` statements in your test file.

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

To run the integration tests, change to the `integration/` directory and run,

```console
cd integration
bazel test //...
```
