#!/usr/bin/fish

function __fish_prompt_finalize --no-scope-shadowing --argument-names 'color'  \
  --description='Finalized the prompt'

  set_color normal

  if [ "$side" = left ]
    if [ "$last_bg_color" = "$normal_color" ]
      set_color ([ "$color" ]; and echo $color ; or echo $last_color)
      echo -n \uE0B1
    else
      set_color ([ "$color" ]; and echo $color ; or echo $last_bg_color)
      echo -n \uE0B0
    end
    echo -n ' '
  end

  set_color normal
end
