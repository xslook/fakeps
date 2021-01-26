//+build linux darwin

package fakeps

import (
	"context"
	"io"
	"os"
	"os/exec"
	"path/filepath"
	"strconv"
	"syscall"
)

const realProgram = "sleep"

func copyExecutable(source, name string) (string, error) {
	rp, err := exec.LookPath(realProgram)
	if err != nil {
		return "", err
	}
	src, err := os.Open(rp)
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

const timeout = 1 << 30

// Run named process
func Run(ctx context.Context, name string) error {
	exe, err := copyExecutable(realProgram, name)
	if err != nil {
		return err
	}

	arg := strconv.Itoa(timeout)
	cmd := exec.CommandContext(ctx, exe, arg)
	cmd.SysProcAttr = &syscall.SysProcAttr{Setpgid: true}
	return cmd.Run()
}
