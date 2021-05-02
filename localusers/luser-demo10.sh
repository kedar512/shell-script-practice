#!/bin/bash

# This script demonstrates use of funtions

log() {
  # This function logs messages to logger file and optionally to console if VERBOSE is true
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
  logger -t luser-demo10.sh "${MESSAGE}"
}

backup_file() {
  # This function backups file passed to it
  local FILE="${1}"
  # Check if file exists
  if [[ -f "${FILE}" ]]
  then
    local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
    log "Backing up ${FILE} in ${BACKUP_FILE}"
    cp -p "${FILE}" "${BACKUP_FILE}"
  else
    log "Invalid file ${FILE}"
    return 1
  fi
}

readonly VERBOSE='true'
log 'Hello!'
log 'This is fun!'

backup_file '/etc/passwd'

if [[ "${?}" -eq 0 ]]
then
  log 'File backup succeded'
else
  log 'File backup was unsuccessful'
fi
