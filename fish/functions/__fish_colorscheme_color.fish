#!/usr/bin/fish

function __fish_colorscheme_color --argument-names 'code' 'base'               \
  --description="The colorscheme and functions to access them"

  set GREYS white grey brcyan brblue bryellow brgreen black

  set success green
  set warning yellow
  set failure brred

  set info cyan
  set head brmagenta

  set symbol magenta

  [ "$base" = "grey" ]
    and echo $GREYS[$code]
    or echo $$code
end
