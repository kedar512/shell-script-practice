#!/bin/bash

# This script is to demonstrate use of getopts

usage() {
  echo "Usage: ${0} [vs] [l LENGTH]"
  echo 'l LENGTH: Specify lenght of the password'
  echo 's If special character is to be appended in the password or not'
  echo 'v If verbose is on or not'
  exit 1
}

log() {
  local MESSAGE="${1}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
}

# Default password length
LENGTH=32

while getopts vl:s OPTION
do
  case "${OPTION}" in
    v)
      VERBOSE='true'
      log 'Setting verbose to true'
      ;;
    l)
      log 'Setting length'
      LENGTH="${OPTARG}"
      ;;
    s)
      log 'Set special character at the end of the password'
      SET_SPECIAL_CHAR='true'
      ;;
    ?)
      log 'Invalid option'
      usage
      ;;
  esac
done

# no of option
echo "Options: ${OPTIND}"

# Remove options
shift "$(( OPTIND - 1 ))"

if [[ "${#}" -gt 0 ]]
then
  usage
fi

log 'Generating password'
PASSWORD="$(date +%s%N${RANDOM} | sha256sum | head -c${LENGTH})"

if [[ "${SET_SPECIAL_CHAR}" = 'true' ]]
then
  log 'Generating random special character'
  SPECIAL_CHAR="$(echo '!@#$%&*()-+=' | fold -w1 | shuf | head -c1)"
  PASSWORD="${PASSWORD}${SPECIAL_CHAR}"
fi

log 'Password generated successfully'

echo "${PASSWORD}"
exit 0


