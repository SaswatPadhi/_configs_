#!/bin/bash

if [ -n "${__BASH_LIB_REPLACE_SH_SOURCE__}" ]; then return 0; fi

# ------------------------------------------------------------------------------

__BASH_LIB_REPLACE_SH_SOURCE__="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__BASH_LIB_REPLACE_SH_LIB__="${__BASH_LIB_REPLACE_SH_SOURCE__}"

source "${__BASH_LIB_REPLACE_SH_LIB__}/logging.sh"

# ------------------------------------------------------------------------------

BACKUP_CODE=1
OVERWRITE_CODE=2
SKIP_CODE=3

# ------------------------------------------------------------------------------

PS3="Please choose an action number: "

function check_and_replace () {
  local target="$1" ; shift
  local ALL_OPTIONS=("Overwrite $(basename $target) with the copy in this repository")
  local TEST_FLAG='-f'

  for arg in  "$@"; do
    if [ "$arg" = "is_directory" ]; then
      TEST_FLAG='-d'
    fi
    BACKUP_OPTION=1
    if [ "$arg" = "allow_backup" ]; then
      BACKUP_OPTION=2
      ALL_OPTIONS+=("Backup existing $(basename $target) and use the copy in this repository")
    fi
    SKIP_OPTION=1
    if [ "$arg" = "allow_skip" ]; then
      SKIP_OPTION=$(( $BACKUP_OPTION + 1 ))
      ALL_OPTIONS+=("Preserve existing $(basename $target) and skip this step")
    fi
  done

  if [ $TEST_FLAG "$target" ]; then
    log WARNING "'$target' already exists.\n";
    select _ in "${ALL_OPTIONS[@]}"; do
      case "${REPLY}" in
        1) return $OVERWRITE_CODE ;;
        *) if [ "${REPLY}" = "${BACKUP_OPTION}" ]; then
             return $BACKUP_CODE
           elif [ "${REPLY}" = "${SKIP_OPTION}" ]; then
             return $SKIP_CODE
           else
             echo 'Invalid action number!'; continue
           fi
           ;;
      esac
    done
  fi

  return $OVERWRITE_CODE
}
