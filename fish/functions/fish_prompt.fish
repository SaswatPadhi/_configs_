#!/usr/bin/fish

function fish_prompt --description='Primary/Left prompt on Fish'
  set -l exit_status $status

  set -l last_color ''
  set -l last_bg_color ''
  set -l normal_color white

  #-----------------------------------------------------------------------------

  function __fish_prompt_print_pwd_segment                                     \
    --no-scope-shadowing --description='Print a short $PWD segment'

    set -l ppwd (prompt_pwd)
    set -l parent (dirname "$ppwd")
    set -l current (basename "$ppwd")
    set -l color ([ -w "$PWD" ]; and echo brcyan; or echo red)

    switch "$parent"
      case "."
      case "/"
        __fish_prompt_print_segment left white brblue "/"
      case '*'
        __fish_prompt_print_segment left white brblue "$parent/"
    end

    __fish_prompt_print_segment left white $color "$current" --bold
  end

  #-----------------------------------------------------------------------------

  # Display non-zero exit status
  if [ $exit_status -ne 0 ]
    __fish_prompt_print_segment left white red "$exit_status"
  end

  # Display joub count
  if [ (jobs -l | wc -l) -gt 0 ]
    __fish_prompt_print_segment left white black \u2699' '(jobs -l | wc -l)
  end

  # Highlight super user
  if [ (id -u $USER) -eq 0 ]
    __print_segment left white purple "#" --bold
  end

  __fish_prompt_print_pwd_segment

  __fish_prompt_finalize left
end
