#!/bin/bash

# This is a script which adds users
# Display promt for user to type username

read -p 'Enter username of the user to added: ' USER_NAME

# Display promt for user to type real name of the user

read -p 'Enter full name of the user to be added: ' COMMENT

# Display promt for user to type password

read -p 'Enter password: ' PASSWORD

# create user from provided username

useradd -c "${COMMENT}" -m ${USER_NAME}

# create password from provided password

echo "${PASSWORD}" | passwd --stdin ${USER_NAME}

# Expire password so that user can reset it on first login
passwd -e ${USER_NAME}
