#!/usr/bin/fish

status --is-login; and status --is-interactive; and exec byobu-launcher

# OPAM configuration
source ~/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

set -gx PATH "/home/saswat/Repos/Z3-str" $PATH

# Disable greeting message
set -gx fish_greeting

# [Re]load colorscheme
fish_reset_colors


# == ALIASES ================================================================= #

alias grep "grep -sin --color=auto"


# == GLOBALS ================================================================= #

set -gx EDITOR  nvim
set -gx BROWSER firefox

if not set -q DISPLAY
  set -gx BROWSER lynx
end
