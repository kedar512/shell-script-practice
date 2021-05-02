#!/bin/bash

# This script executes commands on remote servers provided in the file

usage() {
  echo "Usage: ${0} [OPTIONS]"
  echo '-f File which contains remote servers list'
  echo '-n Performs dry run of the commands to be executed'
  echo '-s Run the commands with sudo privileges'
  exit 1
}

log() {
  local MESSAGE=${1}
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
}

SERVER_FILE='/vagrant/servers'

while getopts vnf:s OPTION
do
  case "${OPTION}" in
    v)
      VERBOSE='true'
      log 'Enabled verbose'
      ;;
    n)
      DRY_RUN='true'
      log 'Running dry run of commands'
      ;;
    s)
      RUN_SUDO='true'
      log 'Running commands with sudo privileges'
      ;;
    f)
      SERVER_FILE="${OPTARG}"
      if [[ ! -e "${SERVER_FILE}" ]]
      then
        echo 'Please provide valid file path' >&2
        usage
      fi
      ;;
    ?)
      usage
      ;;
  esac
done

if [[ "${RUN_SUDO}" != 'true' && "${UID}" -eq 0 ]]
then
  usage
fi

COMMAND_FILE='/vagrant/remote-host-commands'

if [[ "${DRY_RUN}" = 'true' ]]
then
  for SERVER in $(cat ${SERVER_FILE})
  do
    for COMMAND in $(cat ${COMMAND_FILE})
    do
      echo "${COMMAND}"
    done
  done
  exit 0
fi

if [[ "${RUN_SUDO}" = 'true' ]]
then
  for SERVER in $(cat ${SERVER_FILE})
  do
    sudo ssh -o ConnectTimeout=2 ${SERVER} hostname
    sudo ssh -o ConnectTimeout=2 ${SERVER} uptime
  done
else
  for SERVER in $(cat ${SERVER_FILE})
  do
    ssh -o ConnectTimeout=2 ${SERVER} hostname
    ssh -o ConnectTimeout=2 ${SERVER} uptime
  done
fi

