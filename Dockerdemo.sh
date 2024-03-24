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
go run main.go run /bin/bash
ls /
# Note ROOT_FOR_CONTAINER file
# this is how docker mounts its images

#in container
ls /proc
ps
# need to mount /proc
# /proc is a pseudo file system

Sleep 100 #in container
# examine on host
ps -C sleep
ls /proc/<pid>
ls -l /proc/<pid>/root
# note the root for Sleep is the CONTAINER ROOT

# Now to fix proc mount

#step7

# in container
ls /proc
ps
# ps finally works

# in container
mount 
# we see proc mount only

# in host
mount | grep proc
# we see host and container mounts
# not very secure or convenient for host to see all container mounts

#step8

# There is a namespace for mounts
# Edit main.go

# in container
mount 
# we see proc mount only

# in host
mount | grep proc
# we see host mount only

# this effectively hides container mounts
# can examine on host via proc table

Sleep 100 # in container
# examine on host
ps -C sleep
cat /proc/<pid>/mounts

# Show Namespaces Slide
# We have shown how to handle Unix Timesharing System, Process IDs, Mounts
# Can also handle Network, UserIDs, and Interprocess Communication in much the same way.

# Also saw how chroot works to isolate filesystem
# One last property to show
# Show CGroups slide

# Namespaces limit what you can see. CGroups limit what you can do. 

# on host

cd /sys/fs/cgroup
ls

cd memory
ls

cat memory.limit_in_bytes
# very big number

# Create a docker control group
docker run --rm -it ubuntu /bin/bash
exit

cd docker

cat memory.limit_in_bytes
# very big number again

docker run --rm -it --memory=10M ubuntu /bin/bash

# in host, look for container number in /sys/fs/cgroup/memory/docker

ls /sys/fs/cgroup/memory/docker

cat <container number>/memory.limit_in_bytes
# now only 10M

cd /sys/fs/cgroup
ls
cd pids
ls

cat docker/pids.max
# max
# there is no limit

# We are going to do the same king of thing for process numbers
# Edit code
#step9

# So this code goes into the cgroup/pids folder, creates a folder brian
# Sets pids.max
# Adds current process to this control group

# in container
go run main.go run /bin/bash

# in host

cd /sys/fs/cgroup/pids
# now there is a brian folder
cd brian
cat pids.max
# 20

# in container 
sleep 100

# in host
ps -c sleep

cat cgroup.proc
# last process is sleep. parents above. 

# in host
# define a function colon
:0
# in that function we call colon, which we pipe into colon, which we run in the background.  
# That is the definition of our function, and then we invoke it in the container.
:() { : | : &}; :
# This is a FORK BOMB which destroys machines!

# in the host
ps fax
# running nicely, good response, lots of bash sessions

cd /sys/fs/cgroup/brian
cat pids.current
# 20


