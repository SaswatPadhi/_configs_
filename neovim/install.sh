#!/bin/bash

NVIM="nvim"
NVIM_CONFIG_PATH="${HOME}/.config/nvim"

# ------------------------------------------------------------------------------

__BASH_NEOVIM_INSTALL_SH_SOURCE__="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__BASH_NEOVIM_INSTALL_SH_LIB__="${__BASH_NEOVIM_INSTALL_SH_SOURCE__}/../lib"

source "${__BASH_NEOVIM_INSTALL_SH_LIB__}/utils.sh"

verify_dependencies "${NVIM}"

PS3="Please choose an action number: "

# ------------------------------------------------------------------------------

# Download vim-plug

INSTALL_VIM_PLUG="1"
if [ -f "${NVIM_CONFIG_PATH}/autoload/plug.vim" ]; then
  log WARNING "A copy of vim-plug was detected.\n";

  INSTALL_VIM_PLUG_OPTIONS=("Overwrite with latest version"
                            "Preserve existing version")
  select INSTALL_VIM_PLUG in "${INSTALL_VIM_PLUG_OPTIONS[@]}"; do
    case "${REPLY}" in
      1) INSTALL_VIM_PLUG="${REPLY}" ; break ;;
      2) INSTALL_VIM_PLUG="${REPLY}" ; break ;;
      *) echo "Invalid action number!" ; continue ;;
    esac
  done
fi

if [ "${INSTALL_VIM_PLUG}" = "1" ]; then
  curl -fLo "${NVIM_CONFIG_PATH}/autoload/plug.vim" --create-dirs              \
    "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
fi


# Link the neovim init

LINK_NVIM_INIT="1"
if [ -f "${NVIM_CONFIG_PATH}/init.vim" ]; then
  log WARNING "An init.vim for neovim already exists.\n"

  LINK_NVIM_INIT_OPTIONS=("Overwrite with the init.vim in this repository"
                          "Backup existing one and use init.vim in this repository")
  select LINK_NVIM_INIT in "${LINK_NVIM_INIT_OPTIONS[@]}"; do
    case "${REPLY}" in
      1) ;&
      2) LINK_NVIM_INIT="${REPLY}" ; break ;;
      *) echo "Invalid action number!" ; continue ;;
    esac
  done
fi

if [ "${LINK_NVIM_INIT}" = "2" ]; then
  mv "${NVIM_CONFIG_PATH}/init.vim" "${NVIM_CONFIG_PATH}/init.vim.bak"
fi
ln -rfs "${__BASH_NEOVIM_INSTALL_SH_SOURCE__}/init.vim" "${NVIM_CONFIG_PATH}/init.vim"


# Start neovim and update plugins

${NVIM} -S "${__BASH_NEOVIM_INSTALL_SH_SOURCE__}/post-install.vim"
log INFO "Everything looks okay! Have fun with nvim.\n"
