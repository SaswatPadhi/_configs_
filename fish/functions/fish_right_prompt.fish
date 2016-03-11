#!/usr/bin/fish

function fish_right_prompt --description='Right prompt on Fish'
  set last_color ''
  set last_bg_color ''
  set normal_color white

  set side right

  #-----------------------------------------------------------------------------

  function __fish_right_prompt_print_duration                                  \
    --no-scope-shadowing --description='Print the last command duration'

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
    if [ -n "$hours_mins" ]
      __fish_prompt_print_segment white brcyan "$hours_mins"
    end

    if [ "$DURATION" -ge 0 ]
      set sec_ms (math "scale=3; $DURATION / 1000")s
      __fish_prompt_print_segment brcyan grey "$sec_ms"
    end
  end

  #-----------------------------------------------------------------------------

  __fish_right_prompt_print_duration

  # Display the git branch, with basic status info ...
  git status >/dev/null ^/dev/null
  if [ "$status" -eq 0 ]
    set branch (git rev-parse --abbrev-ref HEAD)
    set dirty (git status --untracked-files=no --porcelain)
    set untracked (git ls-files -z --others --exclude-standard)

    set dirty_color ([ -z "$dirty" ]; and echo green; or echo brred)
    set ut_symbol ([ -z "$untracked" ]; and echo ""; or echo " +")
    __fish_prompt_print_segment white $dirty_color \uE0A0" $branch$ut_symbol"
  end

  # ... or the svn revision
  set rev (svn info ^/dev/null | grep Revision | cut -d' ' -f2)
  [ -n "$rev" ]; and __fish_prompt_print_segment white yellow "r$rev"

  __fish_prompt_finalize
end
