package main

import (
	"context"
	"errors"
	"flag"
	"fmt"
	"os"
	"strings"
	"sync"
	"time"

	"github.com/xslook/fakeps"
)

var (
	programs string
	daemon   bool
	timeout  int
)

func init() {
	flag.StringVar(&programs, "p", "", "The names of programs that will be faked, divided by comma, such as mse.exe,kb.exe")
	flag.BoolVar(&daemon, "d", false, "Run on daemon mode")
	flag.IntVar(&timeout, "t", 0, "The running time (seconds), 0 means running until terminate manually")
}

func run(ctx context.Context, name string) {
	exe, err := os.Executable()
	if err != nil {
		panic(err)
	}
	err = fakeps.Run(ctx, name, exe)
	if err != nil {
		if errors.Is(err, context.Canceled) || errors.Is(err, context.DeadlineExceeded) {
			return
		}
		if strings.Contains(err.Error(), "killed") {
			return
		}
		fmt.Printf("Run %s error, %v\n", name, err)
	}
	return
}

func runPrograms(ctx context.Context, ps []string) {
	var wg sync.WaitGroup
	for i := 0; i < len(ps); i++ {
		wg.Add(1)

		pname := ps[i]
		go func(name string) {
			defer wg.Done()

			run(ctx, name)
		}(pname)
	}
	wg.Wait()
}

const maxTimeout = 1 << 30

func runDaemon(ctx context.Context) {
	for {
		select {
		case <-ctx.Done():
			return
		}
	}
}

func main() {
	flag.Parse()

	if timeout <= 0 {
		timeout = maxTimeout
	}
	ctx, cancel := context.WithTimeout(context.Background(), time.Duration(timeout)*time.Second)
	defer cancel()

	if daemon {
		runDaemon(ctx)
		return
	}

	if programs == "" {
		return
	}

	ps := strings.Split(programs, ",")

	runPrograms(ctx, ps)
}
