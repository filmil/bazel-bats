# bazel-bats: bazel test rules for the BATS testing framework (bats-core)

![Build Status](https://github.com/jmelahman/bazel-bats/workflows/Build/badge.svg)
![Test Status](https://github.com/jmelahman/bazel-bats/workflows/Test/badge.svg)
![Integration Status](https://github.com/jmelahman/bazel-bats/workflows/Integration/badge.svg)

## Usage

In your `WORKSPACE` file load and include as follows:

```
# Make the rule "http_archive" available.
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

BAZEL_BATS_VERSION = "1.0.0"

# Make the external repo "bazel_bats" available.
http_archive(
    name = "bazel_bats",
    strip_prefix = "bazel-bats-%s" % BAZEL_BATS_VERSION,
    urls = [
        "https://github.com/jmelahman/bazel-bats/archive/refs/tags/v%s.tar.gz" % BAZEL_BATS_VERSION,
    ],
    sha256 = "1d79f0837ffd782170c8b0d3d649e414507a2ab4b6b2236b5b0102557d3b4afb",
)

# Load the function "bazel_bats_dependencide"
load("@bazel_bats//:deps.bzl", "bazel_bats_dependencies")

# version and sha256 can be omitted, in which case the default is used.
bazel_bats_dependencies(
    version = "1.5.0",
    sha256 = "36a3fd4413899c0763158ae194329af8f48bb1ff0d1338090b80b3416d5793af"
)
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
bazel test //...
```
