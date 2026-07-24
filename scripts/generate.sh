#!/usr/bin/env bash
# Regenerate src/authorizer_proto from the published BSR module.
# No cross-repo copy step: the schema is pulled from
# buf.build/authorizerdev/authorizer.
#
# protoc emits proto-package-based imports (e.g. `from authorizer.v1 import ...`).
# We rewrite the top-level segment to the `authorizer_proto` package so the stubs
# are a self-contained, installable package that never collides with the
# consuming SDK's own `authorizer` package. `from google.protobuf import ...`
# (the real runtime lib) is left untouched.
set -euo pipefail
cd "$(dirname "$0")/.."

rm -rf gen src/authorizer_proto
buf generate buf.build/authorizerdev/authorizer --template buf.gen.yaml --include-imports

find gen -name '*.py' -print0 | xargs -0 perl -0pi -e '
  s/^from authorizer\.v1 import /from authorizer_proto.authorizer.v1 import /mg;
  s/^from buf\.validate import /from authorizer_proto.buf.validate import /mg;
  s/^from google\.api import /from authorizer_proto.google.api import /mg;
'

mkdir -p src/authorizer_proto
mv gen/* src/authorizer_proto/
rmdir gen

# __init__.py at every package level.
find src/authorizer_proto -type d -exec touch {}/__init__.py \;

echo "generated src/authorizer_proto"
