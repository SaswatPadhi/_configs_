#!/bin/bash

__BASH_INSTALL_SH_SOURCE__="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__BASH_INSTALL_SH_LIB__="${__BASH_INSTALL_SH_SOURCE__}/lib"

source "${__BASH_INSTALL_SH_LIB__}/utils.sh"

# ------------------------------------------------------------------------------

shopt -s nullglob
for INSTALL_SCRIPT in "${__BASH_INSTALL_SH_SOURCE__}"/*/install.sh; do
  log INFO "[+I] BEGIN: ${INSTALL_SCRIPT} ================================\n"
  bash "${INSTALL_SCRIPT}"
  log INFO "[-I] ENDOF: ${INSTALL_SCRIPT} ================================\n"
done
