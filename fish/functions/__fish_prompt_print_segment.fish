#!/usr/bin/fish

function __fish_prompt_print_segment --no-scope-shadowing                      \
  --argument-names 'color' 'bg_color' 'data' 'attr'                            \
  --description='Print a segment with separator'

  [ "$bg_color" = normal ]; and set bg_color "$normal_color"

  set_color normal

  if [ "$side" = left ]
    if [ "$last_bg_color" ]
      if [ "$last_bg_color" = "$bg_color" ]
        set_color $last_color --background=$bg_color
        echo -n \uE0B1
      else
        set_color $last_bg_color --background=$bg_color
        echo -n \uE0B0
      end
    end
  else
    if [ "$last_bg_color" = "$bg_color" ]
      set_color $color --background=$bg_color
      echo -n \uE0B3
    else
      set_color $bg_color \
                ([ "$last_bg_color" ]; and echo "--background=$last_bg_color")
      echo -n \uE0B2
    end
  end

  set_color $color $attr --background=$bg_color
  echo -ns " $data "

  set last_color "$color" ; set last_bg_color "$bg_color"
  set_color normal
end
