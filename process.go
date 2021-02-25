package main

import (
	"context"
	"io"
	"os"
	"os/exec"
	"path/filepath"
)

func copyExecutable(source, name string) (string, error) {
	src, err := os.Open(source)
	if err != nil {
		return "", err
	}
	defer src.Close()

	targetFile := filepath.Join(os.TempDir(), name)
	dst, err := os.OpenFile(targetFile, os.O_CREATE|os.O_WRONLY, 0755)
	if err != nil {
		return "", err
	}
	defer dst.Close()

	_, err = io.Copy(dst, src)
	if err != nil {
		return "", err
	}
	return targetFile, nil
}

// Run named process
func Run(ctx context.Context, name, worker string) error {
	exe, err := copyExecutable(worker, name)
	if err != nil {
		return err
	}
	cmd := exec.CommandContext(ctx, exe, "-d")
	return cmd.Run()
}
