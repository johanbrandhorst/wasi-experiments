# wasi-experiments
Playing around with some WASI stuff

## Requirements

Go 1.21

`hello` requires any runtime that supports `wasi_snapshot_preview1`.

`http` requires a runtime that supports the [WasmEdge](https://github.com/WasmEdge/WasmEdge) socket extension to `wasi_snapshot_preview1`, e.g. WasmEdge or [wasirun](https://github.com/stealthrocket/wasi-go).

## Running

To build any of the demos, run `make` followed by the folder name:

```
$ make hello
GOOS=wasip1 GOARCH=wasm go build -o hello.wasm ./hello/
```

You can then execute the build binary in your favourite runtime:

```
$ wasmtime hello.wasm
Hello world
```

If you have `wasmtime` installed on your local system, you can also run the demos directly:

```
$ GOOS=wasip1 GOARCH=wasm PATH=$PATH:$(go env GOROOT)/misc/wasm go run ./hello
Hello world
```

This works by using the `go_wasip1_wasm_exec` script in `$GOROOT/misc/wasm` to execute `wasmtime`.
The Go toolchain [automatically executes](https://pkg.go.dev/cmd/go#hdr-Compile_and_run_Go_program)
these scripts in they are available in the path.
The runtime can be chosen using the `GOWASIRUNTIME` environment variable, and defaults to `wasmtime`.
Available options are `wasmtime`, `wazero`, `wasmedge` and `wasmer`.
