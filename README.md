# authorizer-proto (authorizer-proto-python)

Generated protobuf/gRPC Python stubs for the
[Authorizer](https://github.com/authorizerdev/authorizer) auth server API
(`authorizer.v1`).

This package is **generated code**, not meant for direct hand-editing. It is
consumed as a versioned PyPI dependency by
[`authorizer-py`](https://github.com/authorizerdev/authorizer-python) (and any
other Python client that speaks Authorizer's gRPC / grpc-gateway REST API). It
replaces the old approach of copy-pasting the stubs into the SDK.

## Install

```bash
pip install authorizer-proto          # message stubs + REST (protojson) usage
pip install "authorizer-proto[grpc]"  # add grpcio for the gRPC client stubs
```

## Usage

```python
from authorizer_proto.authorizer.v1 import (
    admin_pb2, admin_pb2_grpc,
    authorizer_pb2, authorizer_pb2_grpc,
)
```

The import package is `authorizer_proto` (not `authorizer`) so it never collides
with the SDK's own `authorizer` package. REST clients (grpc-gateway JSON,
snake_case) reuse the same message classes via `google.protobuf.json_format`.

## How it is generated

Stubs are generated directly from the published Buf Schema Registry module
[`buf.build/authorizerdev/authorizer`](https://buf.build/authorizerdev/authorizer)
— there is **no cross-repo copy step**. `google/api` and `buf/validate` are
vendored (via `--include-imports`) because Python needs them importable at
runtime. protoc's default top-level import segments are rewritten to the
`authorizer_proto` package.

```bash
./scripts/generate.sh
```

CI regenerates on demand (`Regenerate` workflow) and opens a PR when the upstream
schema has moved. Releases publish to PyPI on a `v*` tag.

## License

Apache-2.0. See [LICENSE](./LICENSE).
