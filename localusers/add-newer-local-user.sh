#!/bin/bash

# This is a script to add new users
# Input will be taken from command line arguments
# Display STDOUT or STDERR and discard it whenever required

USAGE="Usage: ${0} USER_NAME [COMMENTS]... Run the script with sudo permissions"

if [[ "${UID}" -ne 0 ]]
then
  echo "${USAGE}" 1>&2
  exit 1
fi

if [[ "${#}" -lt 1 ]]
then
  echo "Please provide at least 1 argument" 1>&2
  echo "${USAGE}" 1>&2
  exit 1
fi

USER_NAME="${1}"
shift 1
COMMENTS="${@}"

echo "Adding USER_NAME: ${USER_NAME}"
echo "Comments: ${COMMENTS}"

useradd -c "${COMMENTS}" -m ${USER_NAME} &> /dev/null

if [[ "${?}" -ne 0 ]]
then
  echo "Unable to add username: ${USER_NAME}"
  exit 1
fi

PASSWORD="$(date +%s%N | sha256sum | head -c32)"
echo "Temporary password: ${PASSWORD}"

echo ${PASSWORD} | passwd --stdin ${USER_NAME} &> /dev/null

if [[ "${?}" -ne 0 ]]
then
  echo "Unable to set password for user: ${USER_NAME}"
  exit 1
fi

passwd -e ${USER_NAME} &> /dev/null
exit 0
