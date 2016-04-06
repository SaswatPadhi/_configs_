#!/usr/bin/fish

# Disable greeting message
set -gx fish_greeting

# Launch byobu on startup
status --is-login; and status --is-interactive; and exec byobu-launcher

# OPAM configuration
source ~/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true


# == PATH =====================================================================#

set -gx PATH ~/bin ~/.rvm/bin $PATH


# == THEME =================================================================== #

set -gx __fish_greys white grey brcyan brblue bryellow brgreen black

set -gx __fish_color_success green
set -gx __fish_color_warning yellow
set -gx __fish_color_failure brred

set -gx __fish_color_info cyan
set -gx __fish_color_head brmagenta
set -gx __fish_color_symbol magenta

# [Re]load colorscheme
fish_reset_colors

# Configuration for __fish_git_prompt
set -g __fish_git_prompt_show_informative_status 'yes'

set -g __fish_git_prompt_char_upstream_prefix ' '
set -g __fish_git_prompt_char_dirtystate      \u2217
set -g __fish_git_prompt_char_invalidstate    \u00D7
set -g __fish_git_prompt_char_stagedstate     \u2299
set -g __fish_git_prompt_char_stashstate      '?'
set -g __fish_git_prompt_char_stateseparator  ' '\uE0B3' '


# == ALIASES ================================================================= #

alias grep  "grep -sin --color=auto"
alias rm    "rm -iv"
alias vi    "nvim"
alias vim   "nvim"


# == GLOBALS ================================================================= #

set -gx EDITOR  nvim
set -gx BROWSER firefox

if not set -q DISPLAY
  set -gx BROWSER lynx
end
