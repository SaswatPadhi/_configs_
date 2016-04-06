#!/bin/bash

CURL="curl"
FISH="fish"
FISH_CONFIG_PATH="${HOME}/.config/fish"

# ------------------------------------------------------------------------------

__BASH_FISH_INSTALL_SH_SOURCE__="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__BASH_FISH_INSTALL_SH_LIB__="${__BASH_FISH_INSTALL_SH_SOURCE__}/../_lib"

source "${__BASH_FISH_INSTALL_SH_LIB__}/depends.sh"
source "${__BASH_FISH_INSTALL_SH_LIB__}/logging.sh"
source "${__BASH_FISH_INSTALL_SH_LIB__}/replace.sh"

verify_dependencies "${CURL}" "${FISH}"

# ------------------------------------------------------------------------------

print_border HEADING "fish config installation"

# Download rvm.fish

log INFO "[+] Downloading RVM workaround\n"
check_and_replace "${FISH_CONFIG_PATH}/functions/rvm.fish" allow_skip
if [ "$?" -eq $OVERWRITE_CODE ]; then
  log INFO
  $CURL -#fLo "${FISH_CONFIG_PATH}/functions/rvm.fish" --create-dirs           \
        "https://raw.githubusercontent.com/lunks/fish-nuggets/master/functions/rvm.fish"
fi


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
print_border TAILING "fish config installation"
