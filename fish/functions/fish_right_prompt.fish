#!/usr/bin/fish

function fish_right_prompt --description='Right prompt on Fish'
  set -l last_color ''
  set -l last_bg_color ''
  set -l normal_color $__fish_greys[1]

  set -l side right

  #-----------------------------------------------------------------------------

  function __fish_right_prompt_print_duration --no-scope-shadowing             \
    --description='Print the last command duration'

    [ "$CMD_DURATION" -lt 64 ]; and return
    set -l DURATION $CMD_DURATION

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
      __fish_prompt_print_segment $normal_color $__fish_greys[3] "$hours_mins"
    end

    if [ "$DURATION" -ge 0 ]
      set sec_ms (math "scale=3; $DURATION / 1000")s
      __fish_prompt_print_segment $__fish_greys[3] $__fish_greys[2] "$sec_ms"
    end
  end

  #-----------------------------------------------------------------------------

  __fish_right_prompt_print_duration

  set -l result (__fish_git_prompt "%s")
  if [ -n "$result" ]
    if [ -n (__fish_git_prompt_dirty) ]
      __fish_prompt_print_segment $normal_color $__fish_color_failure "$result"
    else
      __fish_prompt_print_segment $normal_color $__fish_color_success "$result"
    end
  end

  # TODO: Remove color escape sequences
  set result (__fish_svn_prompt)
  if [ -n "$result" ]
    __fish_prompt_print_segment $__fish_color_warning $normal_color "$result"
  end

  __fish_prompt_finalize
end
