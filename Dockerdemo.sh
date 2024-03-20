# This is shell script containing the commands to build a container in GO

# Based on  https://www.youtube.com/watch?v=8fi7uSYlOdc
# and       https://www.youtube.com/watch?v=Utf-A4rODH8

# Step 1
docker run --rm -it ubuntu /bin/bash
hostname # in container
hostname # in host
ps  # in container
# note low pids
ps  # in host
exit # in container

# Want to recreate 'docker run' in Go
# show slide on namespaces - restricting the view

# create main.go
go run main.go run echo "Hello ELEC4630"

#Edit to make it run functions. Connect Stdout etc

go run main.go run /bin/bash

# Now need to containerize

ls -l /proc/self/exe
ls -l /proc/self/  # multiple times

sleep 100 # in container

ps -C sleep # on host
ls -l /proc/8941
ls -l /proc/8941/root

ls /proc # in container
ps
# get Error, do this: mount -t proc proc /proc

# Run again
ps
mount

sleep 100 # in container
ps -C sleep # on host
cat /proc/8029/mounts
# get  /proc proc rw,relatime 0 0

# cGroups to restrict resources

cd /sys/fs/cgroup # on host
ls
cd memory
cat memory.limit_in_bytes


