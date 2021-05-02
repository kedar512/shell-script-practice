#!/bin/bash

# This is script to generate random passwords

# Try to generate password with RANDOM variable

PASSWORD=${RANDOM}
echo "Password using RANDOM is ${PASSWORD}"

# Try with seconds since unix date

PASSWORD=$(date +%s)
echo "Password using unix seconds is $PASSWORD}"

# Try with combination of seconds since unix date and nanoseconds

PASSWORD=$(date +%s%N)
echo "Password with seconds since unix date and nanoseconds: ${PASSWORD}"

# A better password using hashing functions

PASSWORD=$(date +%s%N | sha256sum | head -c32)
echo "Password using sha256sum: ${PASSWORD}"

# A more secure password
PASSWORD=$(date +%s%N${RANDOM}${RANDOM}${RANDOM} | sha256sum | head -c48)
echo "More secure password using random and sh256sum: ${PASSWORD}"

# Add random special character at the end of the password
SPECIAL_CHAR=$(echo '!@#$%&*()_+=' | fold -w1 | shuf | head -c1)
PASSWORD=$PASSWORD}${SPECIAL_CHAR}
echo "Final password: ${PASSWORD}"
