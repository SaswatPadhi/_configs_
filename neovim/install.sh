#!/bin/bash

NVIM="nvim"
CURL="curl"
NVIM_CONFIG_PATH="${HOME}/.config/nvim"

# ------------------------------------------------------------------------------

__BASH_NEOVIM_INSTALL_SH_SOURCE__="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__BASH_NEOVIM_INSTALL_SH_LIB__="${__BASH_NEOVIM_INSTALL_SH_SOURCE__}/../_lib"

source "${__BASH_NEOVIM_INSTALL_SH_LIB__}/depends.sh"
source "${__BASH_NEOVIM_INSTALL_SH_LIB__}/logging.sh"
source "${__BASH_NEOVIM_INSTALL_SH_LIB__}/replace.sh"

verify_dependencies "${NVIM}" "${CURL}"

# ------------------------------------------------------------------------------

print_border HEADING "neovim config installation"

# Download vim-plug

log INFO "[+] Installing vim-plug plugin manager\n"
check_and_replace "${NVIM_CONFIG_PATH}/autoload/plug.vim" allow_skip
if [ "$?" -eq $OVERWRITE_CODE ]; then
  log INFO
  $CURL -#fLo "${NVIM_CONFIG_PATH}/autoload/plug.vim" --create-dirs            \
        "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
fi


# Link the neovim init

log INFO "[+] Linking init file\n"
check_and_replace "${NVIM_CONFIG_PATH}/init.vim" allow_backup
if [ "$?" -eq $BACKUP_CODE ]; then EXTRA_FLAGS="--backup=numbered" ; fi
log INFO ; ln -rfsv $EXTRA_FLAGS "${__BASH_NEOVIM_INSTALL_SH_SOURCE__}/init.vim" "${NVIM_CONFIG_PATH}/init.vim"


# Start neovim and update plugins

log INFO "[+] Running post-install scripts\n"
${NVIM} -S "${__BASH_NEOVIM_INSTALL_SH_SOURCE__}/post-install.vim"
log INFO "Everything looks okay! Have fun with nvim.\n"

print_border TAILING "neovim config installation"
