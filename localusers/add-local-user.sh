#!/bin/bash

# This is a script to add users to ad system
# Check if script is being run with sudo permissions

if [[ "${UID}" -ne 0 ]]
then
  echo 'Please run the script with sudo permissions'
  exit 1
else
  echo 'Script is running with sudo permissions'
fi

# Read username to be created from input

read -p 'Enter username to be created: ' USER_NAME

# Read real name of the user from input

read -p 'Enter full name of the user: ' COMMENT

# Create local username from provided input

useradd -c "${COMMENT}" -m ${USER_NAME}

if [[ "${?}" -ne 0 ]]
then
  echo 'Unable to create username'
  exit
else
  echo "Username ${USER_NAME} created successfully"
fi

# Read temporary password for the created username from input

read -p 'Enter password: ' PASSWORD

# Set password for the created user

echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Expire password

passwd -e ${USER_NAME}

# Display username, password and hostname where user is created
echo "Username created: ${USER_NAME}"
echo "Temporary password: ${PASSWORD}"
echo "Hostname: ${HOSTNAME}"

exit 0






