#!/bin/dash
curWindowId="$(yabai -m query --windows --window | jq -re ".id")"

$(yabai -m query --spaces --space | jq -re ".index" | xargs -I {} bash -c "if [[ '{}' = '1' ]]; then yabai -m window --space 3; elif [[ '{}' = '2' ]]; then yabai -m window --space 1;  elif [[ '{}' = '3' ]]; then yabai -m window --space 2; fi")
$(yabai -m window --focus "$curWindowId")