#!/usr/bin/fish

# Assumes a solarized-light palette
# Only tested on gnome-terminal

function fish_reset_colors --description='[Re]sets shell colors'
  set -gx fish_color_autosuggestion brblue
  set -gx fish_color_comment brcyan
  set -gx fish_color_error brred --underline
  set -gx fish_color_normal normal
  set -gx fish_color_quote yellow

  set -gx fish_color_command magenta --bold
  set -gx fish_color_param cyan

  set -gx fish_color_escape magenta
  set -gx fish_color_operator magenta
  set -gx fish_color_redirection magenta
  set -gx fish_color_end black --bold

  set -gx fish_pager_color_prefix green
  set -gx fish_pager_color_completion cyan
  set -gx fish_pager_color_description brblue
  set -gx fish_pager_color_progress yellow

  set -gx fish_pager_color_secondary
  set -gx fish_color_search_match
  set -gx fish_color_selection
  set -gx fish_color_valid_path
end
