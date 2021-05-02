#!/bin/bash

# Display UID and username of the user

echo "UID is ${UID}"

# Display UID if it is 1000

UID_TO_TEST='1000'

if [[ "${UID}" -ne "${UID_TO_TEST}" ]]
then
  echo "Your UID does not match ${UID_TO_TEST}"
  exit 1
fi

USER_NAME=$(id -un)

# ${?} gives exit status of last executed command

if [[ "${?}" -ne 0 ]]
then
  echo 'id commnad did not execute successfully'
  exit 1
fi

echo "Username is ${USER_NAME}"

USER_NAME_TO_TEST='vagrant'

if [[ "${USER_NAME}" = "${USER_NAME_TO_TEST}" ]]
then
  echo "Your username matches ${USER_NAME_TO_TEST}"
fi

# Display if the user is vagrant or not

if [[ "${USER_NAME}" != "${USER_NAME_TO_TEST}" ]]
  then
  echo 'User is not ${USER_NAME_TO_TEST}'
  exit 1
fi

exit 0

