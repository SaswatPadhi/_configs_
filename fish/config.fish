#!/usr/bin/fish

status --is-login; and status --is-interactive; and exec byobu-launcher

# OPAM configuration
source ~/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

set -gx PATH "/home/saswat/Repos/Z3-str" $PATH

set -gx fish_greeting

fish_reset_colors
