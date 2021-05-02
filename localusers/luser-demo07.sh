#!/bin/bash

# Demo script for shift and while

while [[ "${#}" -gt 0 ]]
do
  echo "No of parameters ${#}"
  echo "Parameter 1: ${1}"
  echo "Parameter 2: ${2}"
  echo "Parameter 3: ${3}"
  shift
done
