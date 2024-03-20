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