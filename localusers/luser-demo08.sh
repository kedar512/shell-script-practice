#!/bin/bash

# Script to demonstrate I/O redirection

# Redirect STDOUT to file

FILE="/vagrant/data"
head -n1 /etc/passwd > "${FILE}"

# Redirect program output to STDIN
read LINE < "${FILE}"
echo "Line contains: ${LINE}"

# Redirect STDOUT to file and overwrite
head -n3 /etc/passwd > "${FILE}"

# Redirect STDOUT to file and append it
id -un >> ${FILE}

# Redirect STDOUT to  file using file descriptor(FD) for STDOUT (1)
head -n1 /etc/passwd 1>> "${FILE}"

# Redirect program output to STDIN using FD (0)
read LINE 0< "${FILE}"
echo "Line contains ${LINE}"

# Redirect STDERR to a file using FD(2)
head -n3 /etc/passwd /etc/hosts /fakepath 2> head.err

# Redirect both STDOUT and STDERR using FD to same file (Old way) (When you append &1 to 2> without space STDERR is redirected to STDOUT)
head -n3 /etc/passwd /etc/hosts /falke > head.both 2>&1

# Redirect both STDOUT and STDERR using FD to same file (New way)
head -n3 /etc/passwd /etc/hosts /fake &> both.new

# Redirect both STDOUT and STDERR to pipe
head -n3 /etc/passwd /etc/hosts /fake |& cat -n

# Redirect STDOUT to STDERR
echo 'This is an error!' >&2
echo

# Discarding STDOUT
echo 'DISCARD STDOUT'
head -n3 /etc/passwd /fake > /dev/null
echo

# Discarding STDERR
echo 'DISCARD STDERR'
head -n3 /etc/passwd /fake 2> /dev/null
echo

# Discard both STDOUT and STDERR
echo 'DISCARD STDOUT and STDERR'
head -n3 /etc/passwd /fake &> /dev/null
