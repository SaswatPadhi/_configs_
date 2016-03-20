#!/bin/bash

__BASH_INSTALL_SH_SOURCE__="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__BASH_INSTALL_SH_LIB__="${__BASH_INSTALL_SH_SOURCE__}/_lib"

source "${__BASH_INSTALL_SH_LIB__}/depends.sh"
source "${__BASH_INSTALL_SH_LIB__}/logging.sh"
source "${__BASH_INSTALL_SH_LIB__}/replace.sh"

# ------------------------------------------------------------------------------

MESSAGE='~/[dot]-files'
LENGTH=$(( 63 - ${#MESSAGE} ))
log HEADING "BEGIN: ${MESSAGE} "; printf '=%.0s' $(seq 1 $LENGTH) ; printf "\n"
for DOT_FILE in "${__BASH_INSTALL_SH_SOURCE__}/tilde"/dot_*; do
  HOME_DOT_FILE=`basename ${DOT_FILE}`
  HOME_DOT_FILE="${HOME}/.${HOME_DOT_FILE:4}"

  log INFO "[+] Linking ${HOME_DOT_FILE} file\n"
  check_and_replace "${HOME_DOT_FILE}" allow_backup
  if [ "$?" -eq $BACKUP_CODE ]; then EXTRA_FLAGS="--backup=numbered" ; fi
  log INFO ; ln -rfsv $EXTRA_FLAGS "${DOT_FILE}" "${HOME_DOT_FILE}"
done
log TAILING "ENDOF: ${MESSAGE} "; printf '=%.0s' $(seq 1 $LENGTH) ; printf "\n"

shopt -s nullglob
for INSTALL_SCRIPT in "${__BASH_INSTALL_SH_SOURCE__}"/*/install.sh; do
  LENGTH=$(( 63 - ${#INSTALL_SCRIPT} ))
  log HEADING "BEGIN: ${INSTALL_SCRIPT} "; printf '=%.0s' $(seq 1 $LENGTH) ; printf "\n"
  bash "${INSTALL_SCRIPT}"
  log TAILING "ENDOF: ${INSTALL_SCRIPT} "; printf '=%.0s' $(seq 1 $LENGTH) ; printf "\n"
done
