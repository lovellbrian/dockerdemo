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

#E dit to make it run functions. Connect Stdout etc

go run main.go run /bin/bash

# Now need to containerize