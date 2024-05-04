#!/usr/bin/env bash

# Check if the .gitmodules file exists
if [ ! -f ".gitmodules" ]; then
  echo "ERROR: no .gitmodules file, nothing to do..."
  exit 1
fi

# Check that the first arg is HEAD or TAIL
if [[ "$1" =~ ^(-H|--HEAD|-T|--TAIL)$ ]]; then
  if [[ "$1" =~ ^(-H|--HEAD)$ ]]; then
    RECURSION="HEAD"
    declare -a SUBMODULES=($(git submodule foreach -q --recursive pwd))
  else
    RECURSION="TAIL"
    declare -a SUBMODULES=($(git submodule foreach -q --recursive pwd | sort --reverse))
  fi
else
  echo "ERROR: Missing recursion directive!"
  echo "OPTIONS: -H, --HEAD, -T, or --TAIL"
  exit 2
fi

# Define the execution_args function
function execute_args()
{
  if [[ "$1" =~ ^(-Q|--QUIET)$ ]]; then
    "${@:2}"
  else
    echo -e "\e[45m RGSM :: $PWD :: \e[0m"
    "${@}"
  fi
}

# If HEAD, execute on this now
if [[ "$RECURSION" == "HEAD" ]]; then
  execute_args "${@:2}"
fi

# Execute recursively
for sm in "${SUBMODULES[@]}"; do
  pushd "$sm" &> /dev/null
	execute_args "${@:2}"
  popd &> /dev/null
done

# If TAIL, execute on this now
if [[ "$RECURSION" == "TAIL" ]]; then
  execute_args "${@:2}"
fi
