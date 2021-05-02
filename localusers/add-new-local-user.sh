#!/bin/bash

# Script to add users from command line arguments

USAGE='Usage: script USER_NAME COMMENTS. Run with root permissions'

# Check if the script is runnin with root permissions

if [[ "${UID}" -ne 0 ]]
then
  echo "${USAGE}"
  exit 1
fi

if [[ "${#}" -lt 2 ]]
then
  echo "${USAGE}"
  exit 1
fi

# Add user

useradd -c "${2}" -m ${1}

if [[ "${?}" -ne 0 ]]
then
  echo 'Unable to add user'
  exit 1
fi

PASSWORD="$(date +%s%N | sha256sum | head -c32)"

echo "${PASSWORD}" | passwd --stdin ${1}

if [[ "${?}" -ne 0 ]]
then
  echo 'Unable to set password for user'
  exit 1
fi

passwd -e ${1}

echo
echo "Username: ${1}"
echo
echo "Password: ${PASSWORD}"
echo
echo "Hostname: ${HOSTNAME}"
exit 0
