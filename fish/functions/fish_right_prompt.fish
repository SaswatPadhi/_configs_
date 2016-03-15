#!/usr/bin/fish

function fish_right_prompt --description='Right prompt on Fish'
  set last_color ''
  set last_bg_color ''
  set normal_color $__fish_greys[1]

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
      __fish_prompt_print_segment $normal_color $__fish_greys[3] "$hours_mins"
    end

    if [ "$DURATION" -ge 0 ]
      set sec_ms (math "scale=3; $DURATION / 1000")s
      __fish_prompt_print_segment $__fish_greys[3] $__fish_greys[2] "$sec_ms"
    end
  end

  #-----------------------------------------------------------------------------

  function __fish_right_prompt_print_vcs_info --no-scope-shadowing             \
    --argument-names 'label' 'dirty' 'untracked' 'deleted'                     \
    --description='Display basic version control info'

    [ "$dirty" -ne 0 ]
      and set dirty_color $__fish_color_failure
      or set dirty_color $__fish_color_success

    __fish_prompt_print_segment $normal_color $dirty_color "$label"

    if [ "$deleted" -ne 0 ]; and [ "$untracked" -ne 0 ]
      set delta_symbol \u00B1
    else if [ "$deleted" -ne 0 ]
      set delta_symbol \u2717
    else if [ "$untracked" -ne 0 ]
      set delta_symbol '+'
    end

    set -q delta_symbol
      and __fish_prompt_print_segment $normal_color $__fish_color_warning \
                                      $delta_symbol --bold
  end

  #-----------------------------------------------------------------------------

  function __fish_right_prompt_print_git_info --no-scope-shadowing             \
    --description='Display the git branch, with some status info'

    command -s git >/dev/null ^/dev/null; and git status >/dev/null ^/dev/null
    [ "$status" -ne 0 ]; and return

    # TODO: Optimize
    set deleted (git status ^/dev/null | grep -c deleted)
    set dirty (git status --untracked-files=no --porcelain ^/dev/null | wc -l)
    set label (git rev-parse --abbrev-ref HEAD ^/dev/null)
    set untracked \
        (git ls-files --others --exclude-standard ^/dev/null | wc -l)

    __fish_right_prompt_print_vcs_info \uE0A0" $label" \
                                       "$dirty"        \
                                       "$untracked"    \
                                       "$deleted"
  end

  #-----------------------------------------------------------------------------

  function __fish_right_prompt_print_svn_info --no-scope-shadowing             \
    --description='Display the svn revision, with some status info'

    command -s svn >/dev/null ^/dev/null; and  svn info >/dev/null ^/dev/null
    [ "$status" -ne 0 ]; and return

    # TODO: Optimize
    set deleted (svn status ^/dev/null | cut -d' ' -f1 | grep 'D' | wc -l)
    set label (svn info ^/dev/null | grep Revision | cut -d' ' -f2)
    set dirty (svn status -q ^/dev/null | wc -l)
    set untracked (svn status ^/dev/null | cut -d' ' -f1 | grep '?' | wc -l)

    __fish_right_prompt_print_vcs_info "r$label"    \
                                       "$dirty"     \
                                       "$untracked" \
                                       "$deleted"
  end

  #-----------------------------------------------------------------------------

  __fish_right_prompt_print_duration

  __fish_right_prompt_print_git_info
  __fish_right_prompt_print_svn_info

  # TODO: Hack to unexport functions. Fix when Fish supports local functions.
  functions -e __fish_right_prompt_print_duration \
               __fish_right_prompt_print_vcs_info \
               __fish_right_prompt_print_git_info \
               __fish_right_prompt_print_svn_info

  __fish_prompt_finalize
end
