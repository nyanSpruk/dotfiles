# #!/usr/bin/env bash

# Get active display
active_display=$(yabai -m query --displays --display | jq -r '.index')
kitty_id=$(yabai -m query --windows | jq -r '.[] | select(.app=="kitty") | .id')
active_space=$(yabai -m query --spaces --space | jq -r '.index')

display_width=$(yabai -m query --displays | jq ".[] | select(.index == ${active_display}) | .frame.w")

move_amount_x=0
move_amount_y=-150

# echo ${display}

# Instead of this for loop, just get displays x value TODO

# For each display that has id smaller than display where kitty is located then sum their width
if [[ $((active_display - 1)) -gt 0 ]]; then
    for i in $(seq 1 $((active_display - 1))); do
        size=$(yabai -m query --displays | jq ".[] | select(.index == ${i}) | .frame.w")
        # echo ${i}
        # Add to move_amount_x the value of size
        move_amount_x=$((${move_amount_x}+${size}))
    done
    move_amount_y=$((${move_amount_y} - 10))
fi

echo ${move_amount_x}
# echo ${display_width}
move_amount_x=$((${move_amount_x} + 10))
# echo ${move_amount_x}
# Remove 10px from display width
display_width=$((${display_width} - 20))

# Add if display = 1 then chagne height to smth else


# First focus the window with kitty_id then bring it to space active_space
# yabai -m window $kitty_id --space $active_space

# Tell osascript to unhide kitty
osascript -e 'tell application "Finder"' -e 'set visible of process "kitty" to true' -e 'end tell'

yabai -m window ${kitty_id} --move abs:${move_amount_x}:${move_amount_y} && \
yabai -m window ${kitty_id} --resize abs:${display_width}:500
yabai -m window --focus $kitty_id
