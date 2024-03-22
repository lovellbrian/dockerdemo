# This is shell script containing the commands to build a container in GO

# Based on  https://www.youtube.com/watch?v=8fi7uSYlOdc
# and       https://www.youtube.com/watch?v=Utf-A4rODH8

# main (select main branch, then step1, step2 ...)
# Show first 3 slides up to run docker

docker run --rm -it ubuntu /bin/bash
hostname # in container
hostname # in host
ps  # in container
# note low pids
ps  # in host
exit # in container

# Want to recreate 'docker run' in Go
# show slide on namespaces - restricting the view
# Create main.go adding func(run)

# step1
# Open bash terminal, detach
sudo -i
cd /workspaces/dockerdemo

go run main.go run echo Hello ELEC4630
# note - just typing string, not running echo command

#step2
go run main.go run echo Hello ELEC4630  #runs command
go run main.go run /bin/bash
ps
# now to containerize

#step3
# now we can have different hostname in container

# Show hostname in prompt
export PS1="[\u@\h \W]\$ "

go run main.go run /bin/bash
hostname # inheirited from host
hostname container # host unaffected
# want to set this up before opening container

#step4
# need to set hostname.
# Namespace is created with cmd.Run()
# Can't change hostname after cmd.Run() as we will be changing the current namespace not the new one.
# Can't do it before cmd.Run() as the namespace doesn't exist.
# Use two processes!

#step5
# add child process
go run main.go run /bin/bash
# two runs
hostname
# want pids starting from 1
# ps gets information from /proc
ps 
ls /proc
ls -l /proc/self/exe
ls -l /proc/self

# Let's create chroot folder

# Mark host root with file
touch /ROOT_FOR_HOST
ls /

# Use debootstrap to fetch minimal linux
mkdir -p /home/vscode/ubuntu-fs
apt-get update 
apt-get install debootstrap
debootstrap --variant=minbase focal /home/vscode/ubuntu-fs/

# Mark container root with file
touch /home/vscode/ubuntu-fs/ROOT_FOR_CONTAINER
ls /home/vscode/ubuntu-fs

# Now we have a new root folder for the container

#step6
