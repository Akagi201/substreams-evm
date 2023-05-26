# Substreams EVM

The Graph Substreams EVM template.

## Gen Protobuf

```sh
make codegen
```

## Compile

Build WASM binary and Protobuf definitions.

```sh
make build
```

The resulting WASM artifact will be found at `./target/wasm32-unknown-unknown/release/substreams.wasm`

## Run substream

```sh
make map_transfers
make store_transfers
```
