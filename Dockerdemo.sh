# This is shell script containing the commands to build a container in GO

# Based on  https://www.youtube.com/watch?v=8fi7uSYlOdc
# and       https://www.youtube.com/watch?v=Utf-A4rODH8

# Show first 3 slides up to run docker

docker run --rm -it ubuntu /bin/bash
hostname # in container
hostname # in host
ps  # in container
# note low pids
ps  # in host
exit # in container

# Show namespaces slide
# Edit main.go

# step1
# Open bash terminal, detach
sudo -i
cd /workspaces/dockerdemo
go run main.go run Hello ELEC4630
# note - just typing string, not running echo command

#step2
go run main.go run echo Hello ELEC4630  #runs command
go run main.go run /bin/bash
ps
# now to containerize

#step3
# now we can have different hostname in container
go run main.go run /bin/bash
hostname # inheirited from host
hostname container # host unaffected
# want to set this up before opening container

#step4
