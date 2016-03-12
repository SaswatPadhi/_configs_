#!/bin/bash

if [ -n "${__BASH_LIB_LOGGING_SH_SOURCE__}" ]; then return 0; fi

# ------------------------------------------------------------------------------

__BASH_LIB_LOGGING_SH_SOURCE__="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__BASH_LIB_LOGGING_SH_LIB__="${__BASH_LIB_LOGGING_SH_SOURCE__}"

source "${__BASH_LIB_LOGGING_SH_LIB__}/colors.sh"

# ------------------------------------------------------------------------------

log () {
  local Tag=$1 ; shift
  local Col=`eval "echo $"${Tag::4}`
  local Time=`date +"%T"`

  local ARGUMENTS="$@"
  if [ "${Tag::4}" == "FATA" ]; then
    local CLEAN_ARGUMENTS="$ARGUMENTS"
    if [ "${ARGUMENTS: -2}" == "\n" ]; then
      CLEAN_ARGUMENTS="${ARGUMENTS::$(( ${#ARGUMENTS} - 2))}"
    fi

    printf "${Col}${Tag::4}]--- $Time > $CLEAN_ARGUMENTS"

    LENGTH=$(( 71 - ${#CLEAN_ARGUMENTS} ))
    printf ' %.0s' $(seq 1 $LENGTH)
    if [ "$CLEAN_ARGUMENTS" != "$ARGUMENTS" ] ; then printf '\n' ; fi
  else
    printf "${Col}${Tag::4}]--- $Time > $ARGUMENTS"
  fi
}
