#!/usr/bin/fish

status --is-login; and status --is-interactive; and exec byobu-launcher

# OPAM configuration
source ~/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

set -gx PATH ~/bin $PATH

# Disable greeting message
set -gx fish_greeting


# == COLORSCHEME ============================================================= #

set -gx __fish_greys white grey brcyan brblue bryellow brgreen black

set -gx __fish_color_success green
set -gx __fish_color_warning yellow
set -gx __fish_color_failure brred

set -gx __fish_color_info cyan
set -gx __fish_color_head brmagenta
set -gx __fish_color_symbol magenta


# [Re]load colorscheme
fish_reset_colors


# == ALIASES ================================================================= #

alias grep  "grep -sin --color=auto"
alias rm    "rm -iv"


# == GLOBALS ================================================================= #

set -gx EDITOR  nvim
set -gx BROWSER firefox

if not set -q DISPLAY
  set -gx BROWSER lynx
end
