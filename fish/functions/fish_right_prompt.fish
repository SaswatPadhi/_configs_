#!/usr/bin/fish

function fish_right_prompt --description='Right prompt on Fish'
  set last_color ''
  set last_bg_color ''
  set normal_color (fish_colorscheme_color 1 grey)

  set side right

  #-----------------------------------------------------------------------------

  function __fish_right_prompt_print_duration --no-scope-shadowing             \
    --description='Print the last command duration'

    [ "$CMD_DURATION" -lt 64 ]; and return
    set DURATION $CMD_DURATION

    set hours_mins
    if [ "$DURATION" -ge 3600000 ]
      set hours_mins (math "scale=0; $DURATION / 3600000")h' '
      set DURATION (math "$DURATION % 3600000")
    end
    if [ "$DURATION" -ge 60000 ]
      set hours_mins "$hours_mins"(math "scale=0; $DURATION / 60000")m
      set DURATION (math "$DURATION % 60000")
    end
    if [ "$hours_mins" ]
      __fish_prompt_print_segment $normal_color                     \
                                  (fish_colorscheme_color 3 grey) \
                                  "$hours_mins"
    end

    if [ "$DURATION" -ge 0 ]
      set sec_ms (math "scale=3; $DURATION / 1000")s
      __fish_prompt_print_segment (fish_colorscheme_color 3 grey) \
                                  (fish_colorscheme_color 2 grey) \
                                  "$sec_ms"
    end
  end

  #-----------------------------------------------------------------------------

  __fish_right_prompt_print_duration

  # Display the git branch, with basic status info ...
  git status >/dev/null ^/dev/null
  if [ "$status" -eq 0 ]
    set branch (git rev-parse --abbrev-ref HEAD ^/dev/null)
    set dirty (git status --untracked-files=no --porcelain ^/dev/null)

    set dirty_color (
      [ "$dirty" ]
        and fish_colorscheme_color failure
        or fish_colorscheme_color success
    )

    __fish_prompt_print_segment $normal_color $dirty_color \uE0A0" $branch"

    set deleted (git status ^/dev/null | grep deleted)
    set untracked (git ls-files -z --others --exclude-standard ^/dev/null)

    if [ "$deleted" ]; and [ "$untracked" ]
      set delta_symbol \u00B1
    else if [ "$deleted" ]
      set delta_symbol \u2717
    else if [ "$untracked" ]
      set delta_symbol '+'
    end

    set -q delta_symbol
      and __fish_prompt_print_segment $normal_color                      \
                                      (fish_colorscheme_color warning) \
                                      $delta_symbol --bold
  end

  # ... or the svn revision
  set rev (svn info ^/dev/null | grep Revision | cut -d' ' -f2)
  [ "$rev" ]
    and __fish_prompt_print_segment $normal_color                      \
                                    (fish_colorscheme_color warning) \
                                    "r$rev"

  __fish_prompt_finalize
end
