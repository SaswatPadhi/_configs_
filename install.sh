#!/bin/bash

__BASH_INSTALL_SH_SOURCE__="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__BASH_INSTALL_SH_LIB__="${__BASH_INSTALL_SH_SOURCE__}/_lib"

source "${__BASH_INSTALL_SH_LIB__}/logging.sh"

# ------------------------------------------------------------------------------

shopt -s nullglob
for INSTALL_SCRIPT in "${__BASH_INSTALL_SH_SOURCE__}"/*/install.sh; do
  LENGTH=$(( 63 - ${#INSTALL_SCRIPT} ))
  log HEADING "BEGIN: ${INSTALL_SCRIPT} "; printf '=%.0s' $(seq 1 $LENGTH) ; printf "\n"
  bash "${INSTALL_SCRIPT}"
  log TAILING "ENDOF: ${INSTALL_SCRIPT} "; printf '=%.0s' $(seq 1 $LENGTH) ; printf "\n"
done
