package main

import (
	"fmt"
	"os"
	"os/exec"
	"syscall"
)

func main() {
	if os.Getenv("GOKRAZY_FIRST_START") == "1" {
		os.Exit(0)
	}
	const frozenDir = "/usr/lib/aarch64-linux-gnu/nftables.frozen"
	nft := exec.Command(
		frozenDir+"/ld-linux-aarch64.so.1",
		append([]string{
			frozenDir + "/nft",
		}, os.Args[1:]...)...)
	nft.Env = append(os.Environ(), "LD_LIBRARY_PATH="+frozenDir)
	nft.Stdin = os.Stdin
	nft.Stdout = os.Stdout
	nft.Stderr = os.Stderr
	err := nft.Run()
	if err != nil {
		if exiterr, ok := err.(*exec.ExitError); ok {
			if status, ok := exiterr.Sys().(syscall.WaitStatus); ok {
				os.Exit(status.ExitStatus())
			}
		} else {
			fmt.Fprintf(os.Stderr, "%v: %v\n", nft.Args, err)
		}
	}
}
