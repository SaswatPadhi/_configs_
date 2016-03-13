#!/usr/bin/fish

# Assumes a solarized-light palette
# Only tested on gnome-terminal

function fish_reset_colors --description='[Re]sets shell colors'
  set -gx fish_color_autosuggestion $__fish_greys[3]
  set -gx fish_color_comment $__fish_greys[4]
  set -gx fish_color_error $__fish_color_failure --underline
  set -gx fish_color_quote $__fish_color_warning

  set -gx fish_color_command $__fish_color_head --bold
  set -gx fish_color_param $__fish_color_info

  set -gx fish_color_escape $__fish_color_symbol
  set -gx fish_color_operator $__fish_color_symbol
  set -gx fish_color_redirection $__fish_color_symbol

  set -gx fish_pager_color_prefix $__fish_color_success
  set -gx fish_pager_color_completion $__fish_color_info
  set -gx fish_pager_color_description $__fish_greys[3]
  set -gx fish_pager_color_progress $__fish_color_warning

  set -gx fish_color_end $__fish_greys[7] --bold

  set -gx fish_pager_color_secondary
  set -gx fish_color_search_match
  set -gx fish_color_selection
  set -gx fish_color_valid_path
end
