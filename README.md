# bazel-bats: bazel test rules for the BATS testing framework (bats-core)

![Build Status](https://github.com/filmil/bazel-bats/workflows/Build/badge.svg)
![Test Status](https://github.com/filmil/bazel-bats/workflows/Test/badge.svg)
![Integration Status](https://github.com/filmil/bazel-bats/workflows/Integration/badge.svg)

## Usage

In your `WORKSPACE` file load and include as follows:

```
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

BAZEL_BATS_VERSION = "0.30.0"
BAZEL_BATS_SHA256 = "9ae647d2db3aa0bd36af84a0a864dce1c4a1c4f7207b240d3a809862944ecb18"

http_archive(
    name = "bazel_bats",
    strip_prefix = "bazel-bats-%s" % BAZEL_BATS_VERSION,
    urls = [
        "https://github.com/filmil/bazel-bats/archive/refs/tags/v%s.tar.gz" % BAZEL_BATS_VERSION,
    ],
    sha256 = BAZEL_BATS_SHA256,
)

load("@bazel_bats//:deps.bzl", "bazel_bats_dependencies")

bazel_bats_dependencies()
```

You can alternatively specify the specific bats-core version, as well as optionally adding bats-core extensions.

```
BATS_ASSERT_VERSION = "2.0.0"
BATS_ASSERT_SHA256 = "15dbf1abb98db785323b9327c86ee2b3114541fe5aa150c410a1632ec06d9903"
BATS_CORE_VERSION = "1.7.0"
BATS_CORE_SHA256 = "ac70c2a153f108b1ac549c2eaa4154dea4a7c1cc421e3352f0ce6ea49435454e"
BATS_SUPPORT_VERSION = "0.3.0"
BATS_SUPPORT_SHA256 = "7815237aafeb42ddcc1b8c698fc5808026d33317d8701d5ec2396e9634e2918f"

# ...

bazel_bats_dependencies(
    version = BATS_CORE_VERSION,
    sha256 = BATS_CORE_SHA256,
    # Optional test extensions
    bats_assert_version = BATS_ASSERT_VERSION,
    bats_assert_sha256 = BATS_ASSERT_SHA256,
    bats_support_version = BATS_SUPPORT_VERSION,
    bats_support_sha256 = BATS_SUPPORT_SHA256)
```

In your `BUILD.bazel` file add the following:

```
load("@bazel_bats//:rules.bzl", "bats_test")

bats_test(
  name = "hello_world_test",
  srcs = ["hello_world.bats"],
)
```

If your test would like to make use of the bats-assert extension (`assert_success`, `assert_failure`, `assert_output`, etc), simply add `uses_bats_assert = True` to your `bats_test()` target. This still requires adding the appropriate `load` statements in your test file.

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
