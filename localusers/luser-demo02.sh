#!/bin/bash

# Display UID and username of the user who is executing this script
# Diplay if user has root access or not

# Display UID
echo "My UID is ${UID}"

# Display username
USER_NAME=$(id -un)
#USER_NAME=`id -un`

echo "My usename is ${USER_NAME}"

# Check and display if user has root access or no

if [[ "${UID}" -eq 0 ]]
then
   echo 'You are root user'
else
   echo 'You are not root user'
fi
