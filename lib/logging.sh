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

  printf "${Col}${Tag::4}]--- $Time > $@"
}
