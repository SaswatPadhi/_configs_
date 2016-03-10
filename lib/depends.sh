#!/bin/bash

if [ -n "${__BASH_LIB_DEPENDS_SH_SOURCE__}" ]; then return 0; fi

# ------------------------------------------------------------------------------

__BASH_LIB_DEPENDS_SH_SOURCE__="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__BASH_LIB_DEPENDS_SH_LIB__="${__BASH_LIB_DEPENDS_SH_SOURCE__}"

source "${__BASH_LIB_DEPENDS_SH_LIB__}/logging.sh"

# ------------------------------------------------------------------------------

UNMET_DEPENDENCIES=2

# ------------------------------------------------------------------------------

command_exists () {
  if hash "$1" 2> /dev/null; then
    return 0 # no errors = true = zero exit code
  else
    return 1 # errors = false = non-zero exit code
  fi
}

verify_dependencies () {
  for dependency in "$@"; do
    if command_exists "${dependency}"; then
      log SUCCESS "${dependency} detected: "; ${dependency} --version | head -n 1;
    else
      log FATAL "${dependency} not detected. Please install, add to path and re-run this script.\n";
      exit ${UNMET_DEPENDENCIES}
    fi
  done
}
