package fakeps

import (
	"context"
	"embed"
	"fmt"
	"io"
	"os"
	"os/exec"
	"path/filepath"
	"runtime"
)

//go:embed build
var fs embed.FS

func copyExecutable(source, name string) (string, error) {
	src, err := fs.Open(source)
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

func targetFile() (target string) {
	switch runtime.GOOS {
	case "linux":
		if runtime.GOARCH == "amd64" {
			target = "build/worker_linux64"
		} else {
			target = "build/worker_linux32"
		}
	case "windows":
		if runtime.GOARCH == "amd64" {
			target = "build/worker_win64"
		} else {
			target = "build/worker_win32"
		}
	case "darwin":
		target = "build/worker_darwin"
	default:
	}
	return
}

// Run named process
func Run(ctx context.Context, name string) error {
	target := targetFile()
	if target == "" {
		return fmt.Errorf("Platform did not support yet")
	}
	exe, err := copyExecutable(target, name)
	if err != nil {
		return err
	}
	cmd := exec.CommandContext(ctx, exe)
	return cmd.Run()
}
