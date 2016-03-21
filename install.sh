#!/bin/bash

CURL="curl"

# ------------------------------------------------------------------------------

__BASH_INSTALL_SH_SOURCE__="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__BASH_INSTALL_SH_LIB__="${__BASH_INSTALL_SH_SOURCE__}/_lib"

source "${__BASH_INSTALL_SH_LIB__}/depends.sh"
source "${__BASH_INSTALL_SH_LIB__}/logging.sh"
source "${__BASH_INSTALL_SH_LIB__}/replace.sh"

verify_dependencies "${CURL}"

# ------------------------------------------------------------------------------

__BASH_INSTALL_SH_MESSAGE__='~/[dot]-files'
print_border HEADING "${__BASH_INSTALL_SH_MESSAGE__}"
for DOT_FILE in "${__BASH_INSTALL_SH_SOURCE__}/tilde"/dot_*; do
  __HOME_DOT_FILE__=`basename ${DOT_FILE}`
  __HOME_DOT_FILE__="${HOME}/.${__HOME_DOT_FILE__:4}"

  log INFO "[+] Linking ${__HOME_DOT_FILE__} file\n"
  check_and_replace "${__HOME_DOT_FILE__}" allow_backup
  if [ "$?" -eq $BACKUP_CODE ]; then EXTRA_FLAGS="--backup=numbered" ; fi
  log INFO ; ln -rfsv $EXTRA_FLAGS "${DOT_FILE}" "${__HOME_DOT_FILE__}"
done
print_border TAILING "${__BASH_INSTALL_SH_MESSAGE__}"


__HOME_DOT_FILE__="${HOME}/.dircolors"
__BASH_INSTALL_SH_MESSAGE__="${__HOME_DOT_FILE__}"
print_border HEADING "${__BASH_INSTALL_SH_MESSAGE__}"
check_and_replace "${__HOME_DOT_FILE__}" allow_backup allow_skip
if [ "$?" -eq $OVERWRITE_CODE ]; then
  log INFO
  rm -rf "${__HOME_DOT_FILE__}" ; $CURL -#fLo "${__HOME_DOT_FILE__}"           \
    "https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-light"
elif [ "$?" -eq $BACKUP_CODE ]; then
  EXTRA_FLAGS="--backup=numbered"
  log INFO ; ln -rfsv $EXTRA_FLAGS "/dev/null" "${__HOME_DOT_FILE__}"
  rm -rf "${__HOME_DOT_FILE__}" ; $CURL -#fLo "${__HOME_DOT_FILE__}"           \
    "https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-light"
fi
print_border TAILING "${__BASH_INSTALL_SH_MESSAGE__}"


shopt -s nullglob
for INSTALL_SCRIPT in "${__BASH_INSTALL_SH_SOURCE__}"/*/install.sh; do
  bash "${INSTALL_SCRIPT}"
done
