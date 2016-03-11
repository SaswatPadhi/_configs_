#!/bin/bash

FISH="fish"
FISH_CONFIG_PATH="${HOME}/.config/fish"

# ------------------------------------------------------------------------------

__BASH_FISH_INSTALL_SH_SOURCE__="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__BASH_FISH_INSTALL_SH_LIB__="${__BASH_FISH_INSTALL_SH_SOURCE__}/../lib"

source "${__BASH_FISH_INSTALL_SH_LIB__}/depends.sh"
source "${__BASH_FISH_INSTALL_SH_LIB__}/logging.sh"
source "${__BASH_FISH_INSTALL_SH_LIB__}/replace.sh"

verify_dependencies "${FISH}"

# ------------------------------------------------------------------------------

# Link config file

log INFO "[+] Linking config file\n"
check_and_replace "${FISH_CONFIG_PATH}/config.fish" allow_backup
if [ "$?" -eq $BACKUP_CODE ]; then EXTRA_FLAGS="--backup=numbered" ; fi
log INFO ; ln -rfsv $EXTRA_FLAGS "${__BASH_FISH_INSTALL_SH_SOURCE__}/config.fish" "${FISH_CONFIG_PATH}/config.fish"


# And everything else

for config_directory in "${__BASH_FISH_INSTALL_SH_SOURCE__}"/*; do
  if [ ! -d "${config_directory}" ]; then continue ; fi

  target=$(basename "$config_directory")
  log INFO "[+] Linking config/${target}\n"
  check_and_replace "${FISH_CONFIG_PATH}/${target}" is_directory allow_backup
  if [ "$?" -eq $BACKUP_CODE ]; then EXTRA_FLAGS="--backup=numbered" ; fi
  log INFO ; ln -rfsv $EXTRA_FLAGS "${config_directory}" -t "${FISH_CONFIG_PATH}"
done

log WARN "[!] Please restart fish to source the new config.\n"
