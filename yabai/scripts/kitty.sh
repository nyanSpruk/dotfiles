# #!/usr/bin/env bash

# Get display width where kitty is
display=$(yabai -m query --windows | jq '.[] | select(.app | test("kitty")).display')
display_width=$(yabai -m query --displays | jq ".[] | select(.index == ${display}) | .frame.w")

move_amount=0

echo ${display}

# Instead of this for loop, just get displays x value TODO

# For each display that has id smaller than display where kitty is located then sum their width
if [[ $((display - 1)) -gt 0 ]]; then
    for i in $(seq 1 $((display - 1))); do
        size=$(yabai -m query --displays | jq ".[] | select(.index == ${i}) | .frame.w")
        echo ${i}
        # Add to move_amount the value of size
        move_amount=$((${move_amount}+${size}))
    done
fi

echo ${move_amount}
echo ${display_width}
move_amount=$((${move_amount} + 10))
echo ${move_amount}
# Remove 10px from display width
display_width=$((${display_width} - 20))

# Add if display = 1 then chagne height to smth else

# kitty_id 

yabai -m query --windows | jq '.[] | select(.app | test("kitty")).id' | xargs -L1 sh -c 'yabai -m window $0 --move abs:'$move_amount':-150 && yabai -m window $0 --resize abs:'$display_width':500'
