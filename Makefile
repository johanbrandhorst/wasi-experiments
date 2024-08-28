.PHONY: hello
hello:
	GOOS=wasip1 GOARCH=wasm go build -o hello.wasm ./hello/

.PHONY: http
http:
	GOOS=wasip1 GOARCH=wasm go build -o http.wasm ./http/

.PHONY: fastly
fastly:
	GOOS=wasip1 GOARCH=wasm go build -o fastly.wasm ./fastly/

.PHONY: export
export:
	GOARCH=wasm GOOS=wasip1 gotip build -buildmode=c-shared -o export.wasm ./export
	wasmtime --invoke primes export.wasm 10

clean:
	rm -f hello.wasm http.wasm fastly.wasm
