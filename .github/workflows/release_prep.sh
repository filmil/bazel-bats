#!/usr/bin/env bash
# Builds the release archive and prints the release notes to stdout.
#
# Called by bazel-contrib/.github/.github/workflows/release_ruleset.yaml,
# which requires this exact path and reads the release notes from stdout.
set -o errexit -o nounset -o pipefail

TAG="$1"
VERSION="${TAG#v}"
REPO_NAME="bazel-bats"
ARCHIVE="${REPO_NAME}-${TAG}.zip"

# These exclusions reproduce the ones thedoctor0/zip-release used before this
# script replaced it, so the archive keeps the same file list.
#
# `bazel-*` must stay excluded, because `zip` follows symlinks and stores the
# target contents. Without it the whole bazel output tree lands in the archive.
#
# `release_notes.txt` must be excluded too. The reusable workflow runs this
# script as `release_prep.sh TAG > release_notes.txt`, so the shell creates
# that file in the working directory before the script starts.
zip --quiet --recurse-paths "${ARCHIVE}" . \
  -x '*.git*' '/*node_modules/*' '.editorconfig' 'bazel-*' \
     'release_notes.txt' "${ARCHIVE}"

cat <<NOTES
## Using Bzlmod

\`\`\`starlark
bazel_dep(name = "bazel_bats", version = "${VERSION}")
\`\`\`
NOTES
