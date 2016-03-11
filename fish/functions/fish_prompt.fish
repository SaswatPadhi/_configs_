#!/usr/bin/fish

function fish_prompt --description='Primary/Left prompt on Fish'
  set exit_status $status

  set last_color ''
  set last_bg_color ''
  set normal_color white

  set side left

  #-----------------------------------------------------------------------------

  function __fish_prompt_print_pwd_segment                                     \
    --no-scope-shadowing --description='Print a short $PWD segment'

    set ppwd (prompt_pwd)
    set parent (dirname "$ppwd")
    set current (basename "$ppwd")
    set color ([ -w "$PWD" ]; and echo brcyan; or echo red)

    switch "$parent"
      case "."
      case "/"
        __fish_prompt_print_segment white brblue "/"
      case '*'
        __fish_prompt_print_segment white brblue "$parent/"
    end

    __fish_prompt_print_segment white $color "$current" --bold
  end

  #-----------------------------------------------------------------------------

  # Display non-zero exit status
  if [ $exit_status -ne 0 ]
    __fish_prompt_print_segment white red "$exit_status"
  end

  # Display job count
  if [ (jobs -l | wc -l) -gt 0 ]
    __fish_prompt_print_segment white black \u2699' '(jobs -l | wc -l)
  end

  # Highlight super user
  if [ (id -u $USER) -eq 0 ]
    __fish_prompt_print_segment white purple "#" --bold
  end

  __fish_prompt_print_pwd_segment

  # Display git info about pending commits
  git status >/dev/null ^/dev/null
  if [ "$status" -eq 0 ]
    set pending_commits (git rev-list --left-right --count (git rev-parse --abbrev-ref HEAD)...(git rev-parse --abbrev-ref --symbolic-full-name @\{u\}) | tr \t \n)
    if [ "$pending_commits[1]" -gt 0 ]
      __fish_prompt_print_segment grey brmagenta \u2934"$pending_commits[1]"
    end
    if [ "$pending_commits[2]" -gt 0 ]
      __fish_prompt_print_segment grey brmagenta \u2935"$pending_commits[2]"
    end
  end

  # TODO: Above for svn

  __fish_prompt_finalize
end
