package main

import (
	"fmt"
	"os"
	"os/exec"
	"syscall"
)

// docker        run image <cmd> <params>
// go run main.go          <cmd> <params>

func main() {
	switch os.Args[1] {
	case "run":
		run()
	case "child":
		child()
	
	default:
		panic("bad command")
	}
}

func run(){
	fmt.Printf("Running %v\n", os.Args[2:])

	cmd := exec.Command("/proc/self/exe", append([]string{"child"}, os.Args[2:]...)...)
	cmd.Stdin = os.Stdin
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.SysProcAttr = &syscall.SysProcAttr{
		Cloneflags:   syscall.CLONE_NEWUTS,
	}
	cmd.Run()

}

func child(){
	fmt.Printf("Running %v\n", os.Args[2:])

	syscall.Sethostname([]byte("container"))
	syscall.Chroot("/host-home-folder/ubuntu-fs")
	syscall.Chdir("/")

	cmd := exec.Command(os.Args[2], os.Args[3:]...)
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	
	cmd.Run()

	syscall.Sethostname([]byte("container"))
}

func must(err error) {
	if err != nil {
		panic(err)
	}
}