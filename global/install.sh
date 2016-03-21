#!/bin/bash

TAR="tar"
CURL="curl"
CTAGS="ctags"

GLOBAL_VERSION="6.5.3"
GLOBAL_DOWNLOAD_LINK="http://tamacom.com/global/global-${GLOBAL_VERSION}.tar.gz"

# ------------------------------------------------------------------------------

__BASH_GLOBAL_INSTALL_SH_SOURCE__="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__BASH_GLOBAL_INSTALL_SH_LIB__="${__BASH_GLOBAL_INSTALL_SH_SOURCE__}/../_lib"

source "${__BASH_GLOBAL_INSTALL_SH_LIB__}/depends.sh"
source "${__BASH_GLOBAL_INSTALL_SH_LIB__}/logging.sh"
source "${__BASH_GLOBAL_INSTALL_SH_LIB__}/replace.sh"

verify_dependencies "${CTAGS}" "${CURL}" "${TAR}"

# ------------------------------------------------------------------------------

print_border HEADING "global installation"

if command_exists "gtags"; then
  INSTALLED_VERSION="`gtags --version | head -n 1 | cut -d' ' -f4`"
  is_lower_version "${INSTALLED_VERSION}" "${GLOBAL_VERSION}" && __BASH_GLOBAL_INSTALL_SH_CONTINUE__="yes"
  [ -n "${__BASH_GLOBAL_INSTALL_SH_CONTINUE__}"] && log WARNING \
    "[*] Detected GNU Global version ${INSTALLED_VERSION} is old."
else
  __BASH_GLOBAL_INSTALL_SH_CONTINUE__="yes"
fi

if [ -n "${__BASH_GLOBAL_INSTALL_SH_CONTINUE__}" ]; then
  sudo apt-get -qq purge global
  log INFO "[+] Downloading GNU Global Source\n"
  ${CURL} -#fLo "/tmp/global/src.global.tar.gz" --create-dirs "${GLOBAL_DOWNLOAD_LINK}"
  cd /tmp/global ; rm -rf global*
  tar xzf src.global.tar.gz ; cd global*

  log INFO "[+] Building GNU Global\n"
  ERRORS=`./configure 2>&1 > /dev/null`
  if [ $? -ne 0 ]; then
    log FATAL "${ERRORS}"
    exit $?
  fi
  ERRORS=`make 2>&1 > /dev/null`
  if [ $? -ne 0 ]; then
    log FATAL "${ERRORS}"
    exit $?
  fi

  log INFO "[+] Installing GNU Global\n"
  ERRORS=`sudo make install 2>&1 > /dev/null`
  if [ $? -ne 0 ]; then
    log FATAL "${ERRORS}"
    exit $?
  fi
fi

print_border TAILING "global installation"
