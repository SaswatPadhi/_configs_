#!/usr/bin/fish

function fish_prompt --description "Primary/Left prompt on Fish"
  set -l exit_status $status
  set -l normal_color white

  #-----------------------------------------------------------------------------

  set -l last_color ''
  set -l last_bg_color ''

  function __print_segment --no-scope-shadowing                                \
                           --argument-names 'color' 'bg_color' 'data' 'attr'   \
                           --description='Print a segment with separator'
    [ "$bg_color" = normal ]; and set bg_color "$normal_color"

    if [ "$last_bg_color" ]
      if [ "$last_bg_color" = "$bg_color" ]
        set_color normal ; set_color $last_color --background=$bg_color
        echo -n \uE0B1
      else
        set_color normal ; set_color $last_bg_color --background=$bg_color
        echo -n \uE0B0
      end
    end

    set_color normal ; set_color $color $attr --background=$bg_color
    echo -ns " $data "

    set last_color "$color" ; set last_bg_color "$bg_color"
  end

  function __finalize_prompt --no-scope-shadowing --argument-names 'color'     \
                             --description='Finalized the prompt'
    if [ "$last_bg_color" = "$normal_color" ]
      set_color normal ; set_color ([ -n "$color" ]; and echo $color ; or echo $last_color)
      echo -n \uE0B1
    else
      set_color normal ; set_color ([ -n "$color" ]; and echo $color ; or echo $last_bg_color)
      echo -n \uE0B0
    end

    set_color normal ; echo -n ' '
  end

  #-----------------------------------------------------------------------------

  function __print_pwd_segment --no-scope-shadowing                            \
                               --description='Print a short $PWD segment'
    set -l ppwd (prompt_pwd)
    set -l parent (dirname "$ppwd")
    set -l current (basename "$ppwd")
    set -l color ([ -w "$PWD" ]; and echo brcyan; or echo red)

    switch "$parent"
      case "."
      case "/"
        __print_segment white brblue "/"
      case '*'
        __print_segment white brblue "$parent/"
    end

    __print_segment white $color "$current" --bold
  end

  #-----------------------------------------------------------------------------

  # Display non-zero exit status
  [ $exit_status -ne 0 ]; and __print_segment white red "$exit_status"

  # Display joub count
  [ (jobs -l | wc -l) -gt 0 ]; and __print_segment white black \u2699' '(jobs -l | wc -l)

  # Highlight super user
  [ (id -u $USER) -eq 0 ]; and __print_segment white purple "#" --bold

  __print_pwd_segment

  __finalize_prompt
end
