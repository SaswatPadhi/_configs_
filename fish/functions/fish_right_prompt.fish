#!/usr/bin/fish

function fish_right_prompt --description "Right prompt on Fish"
  [ "$CMD_DURATION" -lt 64 ]; and return
  set -l DURATION $CMD_DURATION

  set_color brblue --bold ; echo -ns \uE0B3 ' '

  if [ "$DURATION" -ge 3600000 ]
    math "scale=0; $DURATION / 3600000" ; echo -ns 'h '
    set DURATION (math "$DURATION % 3600000")
  end
  if [ "$DURATION" -ge 60000 ]
    math "scale=0; $DURATION / 60000" ; echo -ns 'm '
    set DURATION (math "$DURATION % 60000")
  end
  if [ "$DURATION" -ge 10000 ]
    math "scale=0; $DURATION / 1000" ; echo -ns 's '
    set DURATION (math "$DURATION % 1000")
  end
  echo -ns $DURATION 'ms'

  set_color normal
end
