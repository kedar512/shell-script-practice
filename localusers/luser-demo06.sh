#!/bin/bash

# This script displays commands and arguments passed to the commnads

echo "You executed following command: ${0}"

echo "You used $(dirname {0}) as the path to execute $(basename ${0}) script."

# Display how many arguments are passed to the command
NO_OF_PARAMETERS="${#}"
echo "You supplied ${NO_OF_PARAMETERS} parameters to the command."

# Check if user has supplied at least 1 parameter
if [[ "${NO_OF_PARAMETERS}" -lt 1 ]]
then
  echo "Usage: ${0} USER_NAME [USER_NAME]..."
  exit 1
fi

# Generate and display password for each user passed as a parameter

for USER_NAME in "${@}"
do
  PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48)
  echo "Username: ${USER_NAME} Password: ${PASSWORD}"
done
