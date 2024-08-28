# wasi-experiments
Playing around with some WASI stuff

## Requirements

Go 1.21

`hello` requires any runtime that supports `wasi_snapshot_preview1`.

`http` requires a runtime that supports the [WasmEdge](https://github.com/WasmEdge/WasmEdge) socket extension to `wasi_snapshot_preview1`, e.g. WasmEdge or [wasirun](https://github.com/stealthrocket/wasi-go).

`fastly` requires the [Viceroy](https://github.com/fastly/Viceroy) or [Fastly](https://developer.fastly.com/learning/compute/testing/#running-a-local-testing-server) CLI locally.

`export` requires Go >= 1.24.0, most easily installed with [`gotip`](https://pkg.go.dev/golang.org/dl/gotip). It also requires `wasmtime`.

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

## export

The `export` Makefile target compiles and runs the `export` code, exercising the `go:wasmexport` compiler directive using `wasmtime`.

It uses `-buildmode=c-shared` to compile the binary as a library (AKA a reactor in wasi preview 1 terminology) with exported methods, as indicated by the presence of a `_initialize` export, which must be called before any exports are called.

## Further reading

The official blog post about WASI is a great resource: https://go.dev/blog/wasi

The proposals that led to the wasip1 implementation contain more of the nitty gritty details: https://go.dev/issue/38248, https://go.dev/issue/58141, https://go.dev/issue/59149, https://go.dev/issue/65199
