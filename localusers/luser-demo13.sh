#!/bin/bash

# This script displays ports on which process is running and their PID
# Use -4 option while executing the script if you want just version 4 propcesses for TCP and UDP

sudo netstat -nutlp ${1} | grep ':' | awk '{print $4, $(NF)}' | awk -F ':' '{print $NF}' | awk -F '/' '{print $1}'
