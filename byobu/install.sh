#!/bin/bash

BYOBU="byobu"
BYOBU_CONFIG_PATH="${HOME}/.byobu"

# ------------------------------------------------------------------------------

__BASH_BYOBU_INSTALL_SH_SOURCE__="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__BASH_BYOBU_INSTALL_SH_LIB__="${__BASH_BYOBU_INSTALL_SH_SOURCE__}/../_lib"

source "${__BASH_BYOBU_INSTALL_SH_LIB__}/depends.sh"
source "${__BASH_BYOBU_INSTALL_SH_LIB__}/logging.sh"
source "${__BASH_BYOBU_INSTALL_SH_LIB__}/replace.sh"

verify_dependencies "-V" "${BYOBU}"

# ------------------------------------------------------------------------------

print_border HEADING "byobu config installation"

# Link status file

log INFO "[+] Linking status file\n"
check_and_replace "${BYOBU_CONFIG_PATH}/status" allow_backup
if [ "$?" -eq $BACKUP_CODE ]; then EXTRA_FLAGS="--backup=numbered" ; fi
log INFO ; ln -rfsv $EXTRA_FLAGS "${__BASH_BYOBU_INSTALL_SH_SOURCE__}/status" "${BYOBU_CONFIG_PATH}/status"

# Link tmux config file

log INFO "[+] Linking tmux config file\n"
check_and_replace "${BYOBU_CONFIG_PATH}/.tmux.conf" allow_backup
if [ "$?" -eq $BACKUP_CODE ]; then EXTRA_FLAGS="--backup=numbered" ; fi
log INFO ; ln -rfsv $EXTRA_FLAGS "${__BASH_BYOBU_INSTALL_SH_SOURCE__}/.tmux.conf" "${BYOBU_CONFIG_PATH}/.tmux.conf"

# Link .always-select

log INFO "[+] Linking tmux config file\n"
log INFO ; ln -rfsv "${__BASH_BYOBU_INSTALL_SH_SOURCE__}/.always-select" "${BYOBU_CONFIG_PATH}/.always-select"

print_border TAILING "byobu config installation"
