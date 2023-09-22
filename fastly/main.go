//go:build wasm && wasip1

package main

import (
	"net/http"

	"github.com/fastly/compute-sdk-go/fsthttp"
)

func main() {
	fsthttp.Serve(fsthttp.Adapt(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("Hello World!\n"))
	})))
}
