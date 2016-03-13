#!/usr/bin/fish

function fish_prompt --description='Primary/Left prompt on Fish'
  set exit_status $status

  set last_color ''
  set last_bg_color ''
  set normal_color $__fish_greys[1]

  set side left

  #-----------------------------------------------------------------------------

  function __fish_prompt_print_pwd_segment --no-scope-shadowing                \
    --description='Print a short $PWD segment'

    set ppwd (prompt_pwd)
    set parent (dirname "$ppwd")
    set current (basename "$ppwd")

    if [ -w "$PWD" ]
      set color $__fish_greys[3]
    else
      set lock (echo \uE0A2' ')
      set color $__fish_color_failure
    end

    [ "$parent" != . ]
      and __fish_prompt_print_segment $normal_color $__fish_greys[4] \
                                      (switch "$parent"
                                        case "/" ; echo "/"
                                        case '*' ; echo "$parent/"
                                      end)

    __fish_prompt_print_segment $normal_color $color "$lock$current" --bold
  end

  #-----------------------------------------------------------------------------

  # Display non-zero exit status
  [ $exit_status -ne 0 ]
    and __fish_prompt_print_segment $normal_color $__fish_color_failure \
                                    "$exit_status"

  # Display job count
  [ (jobs -l | wc -l) -gt 0 ]
    and __fish_prompt_print_segment $normal_color $__fish_greys[7] \
                                    \u2699' '(jobs -l | wc -l)

  # Highlight super user
  [ (id -u $USER) -eq 0 ]
    and __fish_prompt_print_segment $normal_color $__fish_color_head "#" --bold

  __fish_prompt_print_pwd_segment

  # Display git info about pending commits
  command -s git >/dev/null ^/dev/null; and git status >/dev/null ^/dev/null
  if [ $status -eq 0 ]
    set local_branch (git rev-parse --abbrev-ref HEAD ^/dev/null)
    set remote_branch (git rev-parse --abbrev-ref --symbolic-full-name @\{u\} \
                           ^/dev/null)

    if [ "$remote_branch" ]
      set pending_commits (git rev-list --left-right --count           \
                                        $local_branch...$remote_branch \
                                        ^/dev/null                     \
                           | tr \t \n)

      [ "$pending_commits[1]" -gt 0 ]
        and __fish_prompt_print_segment $__fish_greys[1] $__fish_color_info \
                                        \u2934"$pending_commits[1]"
      [ "$pending_commits[2]" -gt 0 ]
        and __fish_prompt_print_segment $__fish_greys[1] $__fish_color_info \
                                        \u2935"$pending_commits[2]"
    end
  end

  # Display svn update info --- EXTREMELY SLOW!
  #
  # command -s svn >/dev/null ^/dev/null; and svn info >/dev/null ^/dev/null
  # if [ $status -eq 0 ]
  #   set local_rev (svn info | grep 'Last Changed Rev:' | cut -d' ' -f4)
  #   set remote_rev (svn info -rHEAD | grep 'Last Changed Rev:' | cut -d' ' -f4)
  #
  #   [ "$local_rev" != "$remote_rev" ]
  #     and __fish_prompt_print_segment $__fish_greys[1] $__fish_color_info \
  #                                     \u2935"r$remote_rev"
  # end

  __fish_prompt_finalize
end
