#!/bin/bash

if [ -n "${__BASH_LIB_DEPENDS_SH_SOURCE__}" ]; then return 0; fi

# ------------------------------------------------------------------------------

__BASH_LIB_DEPENDS_SH_SOURCE__="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__BASH_LIB_DEPENDS_SH_LIB__="${__BASH_LIB_DEPENDS_SH_SOURCE__}"

source "${__BASH_LIB_DEPENDS_SH_LIB__}/colors.sh"
source "${__BASH_LIB_DEPENDS_SH_LIB__}/logging.sh"

# ------------------------------------------------------------------------------

__BASH_LIB_DEPENDS_SH_UNMET_DEPENDENCIES=2

# ------------------------------------------------------------------------------

command_exists () {
  if hash "$1" 2> /dev/null; then
    return 0 # no errors = true = zero exit code
  else
    return 1 # errors = false = non-zero exit code
  fi
}

is_lower_version () {
  [  "$1" = "`echo -e "$1\n$2" | sort -V | head -n1`" ]
}

verify_dependencies () {
  while [ "$1" ]; do
    local dependency="$1" ; shift
    local version_flag="--version"

    if [ "${dependency::1}" == "-" ]; then
      version_flag="${dependency}"
      dependency="$1" ; shift
    fi

    if command_exists "${dependency}"; then
      log SUCCESS "${Pur}${dependency} ${SUCC}detected: ${IPur}"; ${dependency} ${version_flag} | head -n 1
    else
      log FATAL "${dependency} not detected. Please install, add to path and re-run this script.\n"
      exit ${__BASH_LIB_DEPENDS_SH_UNMET_DEPENDENCIES}
    fi
  done
}
