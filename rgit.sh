#!/usr/bin/env bash

# Check if the .gitmodules file exists
if [ ! -f ".gitmodules" ]; then
  echo "ERROR: no .gitmodules file, nothing to do..."
  exit 1
fi

# Check if the rgsm.sh file exists
if [ ! -f "rgsm.sh" ]; then
  echo "ERROR: no rgsm.sh, exiting!"
  exit 2
fi

# Define the rgsm call pattern
function call_rgsm()
{
  ./rgsm.sh "$1" --QUIET git "${@:2}"
}

# Check if the first arg is HEAD or TAIL
if [[ "$1" =~ ^(-H|--HEAD|-T|--TAIL)$ ]]; then
  call_rgsm "${@}"
else
  # Make the list of commands to use TAIL
  declare -a tail_commands=(
  "commit"
  "pull"
  "push"
  "status"
  )
  # Check if the command is in the list
  if [[ ${tail_commands[@]} =~ "$1" ]]; then
    call_rgsm --TAIL "${@}"
  else
    call_rgsm --HEAD "${@}"
  fi
fi