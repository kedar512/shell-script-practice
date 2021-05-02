#!/bin/bash

# This script shows failed login attempts for a particular account

usage() {
  echo "USAGE: ${0} -LOG_FILE"
  echo 'FILE - Log file to parse'
  exit 1
}

LOG_FILE="${1}"

if [[ ! -e "${LOG_FILE}" ]]
then
  usage
fi


echo 'COUNT,IP,LOCATION' >> failed-login.csv

# Put data in CSV file
 grep Failed ${LOG_FILE} | awk '{print $(NF - 3)}' | sort | uniq -c | while
read COUNT IP
do
  if [[ "${COUNT}" -gt 10 ]]
  then
    LOCATION=$(geoiplookup ${IP} | cut -d ',' -f 2)
    echo "${COUNT},${IP},${LOCATION}" >> failed-login.csv
  fi
done
