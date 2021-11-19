# bazel-bats: bazel test rules for the BATS testing framework (bats-core)

![Build Status](https://github.com/jmelahman/bazel-bats/workflows/Build/badge.svg)
![Test Status](https://github.com/jmelahman/bazel-bats/workflows/Test/badge.svg)
![Integration Status](https://github.com/jmelahman/bazel-bats/workflows/Integration/badge.svg)

## Usage

In your `WORKSPACE` file load and include as follows:

```
# Make the rule "http_archive" available.
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

BAZEL_BATS_VERSION = "0.29.1"
HEAD = "75dea0bc4d15d48a4238ad2143e998509c0cb3e4"

# Make the external repo "bazel_bats" available.
http_archive(
    name = "bazel_bats",
    # TODO: Tag and release HEAD.
    # strip_prefix = "bazel-bats-%s" % BAZEL_BATS_VERSION,
    strip_prefix = "bazel-bats-%s" % HEAD,
    urls = [
        # TODO: Tag and release HEAD.
        # "https://github.com/jmelahman/bazel-bats/archive/refs/tags/v%s.tar.gz" % BAZEL_BATS_VERSION,
        "https://github.com/jmelahman/bazel-bats/archive/%s.tar.gz" % HEAD,
    ],
    sha256 = "e57d61da26bbb5428e8162da4fa2432d85abc2530b6211dd2d096d75be18d9fb",
)

# Load the function "bazel_bats_dependencide"
load("@bazel_bats//:deps.bzl", "bazel_bats_dependencies")

# version and sha256 can be omitted, in which case the default is used.
bazel_bats_dependencies(
  version="1.5.0",
  sha256="36a3fd4413899c0763158ae194329af8f48bb1ff0d1338090b80b3416d5793af"
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
