#!/bin/bash

SSH="ssh"
SSH_CONFIG_PATH="${HOME}/.ssh"

# ------------------------------------------------------------------------------

__BASH_SSH_INSTALL_SH_SOURCE__="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__BASH_SSH_INSTALL_SH_LIB__="${__BASH_SSH_INSTALL_SH_SOURCE__}/../_lib"

source "${__BASH_SSH_INSTALL_SH_LIB__}/depends.sh"
source "${__BASH_SSH_INSTALL_SH_LIB__}/logging.sh"
source "${__BASH_SSH_INSTALL_SH_LIB__}/replace.sh"

verify_dependencies "-V" "${SSH}"

# ------------------------------------------------------------------------------

print_border HEADING "ssh config installation"

# Link config file

log INFO "[+] Linking config file\n"
check_and_replace "${SSH_CONFIG_PATH}/config" allow_backup
if [ "$?" -eq $BACKUP_CODE ]; then EXTRA_FLAGS="--backup=numbered" ; fi
log INFO ; ln -rfsv $EXTRA_FLAGS "${__BASH_SSH_INSTALL_SH_SOURCE__}/config" "${SSH_CONFIG_PATH}/config"

print_border TAILING "ssh config installation"
