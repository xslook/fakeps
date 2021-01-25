package main

import (
	"context"
	"flag"
	"time"
)

var (
	timeout int
)

func init() {
	flag.IntVar(&timeout, "time", 0, "The timeout value")
}

const maxTimeout = 1 << 30

func main() {
	flag.Parse()

	if timeout <= 0 {
		timeout = maxTimeout
	}

	td := time.Duration(timeout) * time.Second
	ctx, cancel := context.WithTimeout(context.Background(), td)
	defer cancel()

	for {
		select {
		case <-ctx.Done():
			return
		}
	}

}
