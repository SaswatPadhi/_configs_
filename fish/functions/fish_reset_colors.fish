#!/usr/bin/fish

# Assumes a solarized-light palette
# Only tested on gnome-terminal

function fish_reset_colors --description='[Re]sets shell colors'
  set -gx fish_color_autosuggestion (__fish_colorscheme_color 3 grey)
  set -gx fish_color_comment (__fish_colorscheme_color 4 grey)
  set -gx fish_color_error (__fish_colorscheme_color failure) --underline
  set -gx fish_color_quote (__fish_colorscheme_color warning)

  set -gx fish_color_command (__fish_colorscheme_color head) --bold
  set -gx fish_color_param (__fish_colorscheme_color info)

  set -gx fish_color_escape (__fish_colorscheme_color symbol)
  set -gx fish_color_operator (__fish_colorscheme_color symbol)
  set -gx fish_color_redirection (__fish_colorscheme_color symbol)

  set -gx fish_pager_color_prefix (__fish_colorscheme_color success)
  set -gx fish_pager_color_completion (__fish_colorscheme_color info)
  set -gx fish_pager_color_description (__fish_colorscheme_color 3 grey)
  set -gx fish_pager_color_progress (__fish_colorscheme_color warning)

  set -gx fish_color_end (__fish_colorscheme_color 7 grey) --bold

  set -gx fish_pager_color_secondary
  set -gx fish_color_search_match
  set -gx fish_color_selection
  set -gx fish_color_valid_path
end
