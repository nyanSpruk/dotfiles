# #!/usr/bin/env bash


yabai_id=$(yabai -m query --windows | jq -r '.[] | select(.app=="iTerm2") | .id')
active_space=$(yabai -m query --spaces --space | jq -r '.index')

if [[ -z $yabai_id ]]; then
    # Run the app
    open /Applications/iTerm.app/Contents/MacOS/iTerm2
else
    # is_yabai_visible=$(yabai -m query --windows | jq -r '.[] | select(.id=='$yabai_id') | .visible')
    # First focus the window with yabai_id then bring it to space active_space
    yabai -m window $yabai_id --space $active_space
    yabai -m window --focus $yabai_id
fi