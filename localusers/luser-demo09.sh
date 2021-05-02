#!/bin/bash

# This script demonstrates use of case statement

case "${1}" in
  start)
    echo 'Starting..'
    ;;
  stop)
    echo 'Stopping..'
    ;;
  status|state)
    echo 'Status: '
    ;;
  *)
    echo 'Please provide valid argument' >&2
    exit 1
    ;;
esac
