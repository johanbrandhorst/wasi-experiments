.PHONY: hello
hello:
	GOOS=wasip1 GOARCH=wasm go build -o hello.wasm ./hello/

.PHONY: http
http:
	GOOS=wasip1 GOARCH=wasm go build -o http.wasm ./http/

.PHONY: fastly
fastly:
	GOOS=wasip1 GOARCH=wasm go build -o fastly.wasm ./fastly/

clean:
	rm -f hello.wasm http.wasm fastly.wasm
