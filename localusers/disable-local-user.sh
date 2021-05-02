#!/bin/bash

# This is script is used for deletion, expiration or optionally archival of the user

usage() {
  echo "Usage: ${0} [avr] [de] USER_NAME"
  echo 'd DELETE Delete user'
  echo 'e EXPIRE Expire user'
  echo 'a ARCHIVE Archive user data'
  exit 1
}

log() {
  local MESSAGE="${1}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
}

if [[ "${UID}" -ne 0 ]]
then
  echo 'Please run the script with root permissions' >&2
  exit 1
fi

# Setting default action to disable user
EXPIRE_FLAG='true'

while getopts derav OPTION
do
  case "${OPTION}" in
    v)
      VERBOSE='true'
      log 'Enabled verbose'
      ;;
    d)
      DELETE_FLAG='true'
      log "Starting deletion of user"
      ;;
    e)
      EXPIRE_FLAG='true'
      log 'Starting user expiration'
      ;;
    r)
      REMOVE_HOME_FLAG='true'
      log 'Home directory will be removed'
      ;;
    a)
      ARCHIVAL_FLAG='true'
      log 'User data will be archived'
      ;;
    ?)
      usage
      ;;
  esac
done

# Removing options
shift "$(( OPTIND - 1 ))"

if [[ "${#}" -lt 1 ]]
then
  usage
fi

USER_NAME="${1}"
USER_ID="$(id -u ${USER_NAME})" &> /dev/null

# Check if user is valid and not system user
if [[ "${?}" -ne 0 ]]
then
  echo "Please provide valid user" >&2
  exit 1
fi

if [[ "${USER_ID}" -lt 1000 ]]
then
  echo "Cannot delete system users"
  exit 1
fi

if [[ "${ARCHIVAL_FLAG}" = 'true' ]]
then
  if [[ -d "/home/${USER_NAME}" ]]
  then
    log "Starting user archival for user: ${USER_NAME}"
    if [[ -d '/vagrant/user-archive' ]]
    then
      tar -zcf "/vagrant/user-archive/${USER_NAME}.tar.gz" "/home/${USER_NAME}" &> /dev/null
    else
      log 'Creating archival directory'
      mkdir /vagrant/user-archive
      tar -zcf "/vagrant/user-archive/${USER_NAME}.tar.gz" "/home/${USER_NAME}" &> /dev/null
    fi
    log "Successfully archived data for user: ${USER_NAME}"
  else
    echo "Cannot archive user data for user: ${USER_NAME}. User home directory does not exist"
  fi
fi

if [[ "${DELETE_FLAG}" = 'true' ]]
then
  log "Starting delete user for ${USER_NAME}"
  if [[ "${REMOVE_HOME_FLAG}" = 'true' ]]
  then
    log "Removing home directory for user: ${USER_NAME}"
    userdel -r ${USER_NAME} &> /dev/null
  else
    log 'Deleting user without removing home directory'
    userdel ${USER_NAME} &> /dev/null
  fi
else
  log "Starting user expiration for user: ${USER_NAME}"
  chage -E 0 ${USER_NAME}  &> /dev/null
fi

if [[ "${?}" -ne 0 ]]
then
  if [[ "${DELETE_FLAG}" = 'true' ]]
  then
    echo "Unable to delete user: ${USER_NAME}" >&2
  else
    echo "Unable to disable user: ${USER_NAME}" >&2
  fi
  exit 1
fi

if [[ "${DELETE_FLAG}" = 'true' ]]
then
  echo "User ${USER_NAME} deleted successfully"
else
  echo "User ${USER_NAME} disabled successfully"
fi

exit 0










