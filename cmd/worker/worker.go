package main

import (
	"context"
	"flag"
	"os"
	"os/signal"
	"syscall"
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

	sgch := make(chan os.Signal, 1)
	signal.Notify(sgch, os.Kill, os.Interrupt, syscall.SIGTERM)
	for {
		select {
		case <-ctx.Done():
			return
		case <-sgch:
			return
		}
	}
}
