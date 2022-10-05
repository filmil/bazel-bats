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

# 'version' and 'sha256' of bats-core can be provided to override the version of v1.5.0.
bazel_bats_dependencies()
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

To run the integration tests, change to the `integration/` directory and run,

```console
cd integration
bazel test //...
```
