# #!/usr/bin/env bash

# Check if there are more than 1 window of the app, and unfloat the one with smallest id
wid=$YABAI_WINDOW_ID
# echo "WID IS $wid"

# Get app name from wid
appName=$(yabai -m query --windows --window $wid | jq -e ".app")
# echo "APP NAME IS $appName"

# Check if there are more than 1 window of the app
# ids=$(yabai -m query --windows | jq -e ".[] | select(.app == $appName) | .id")
# # toggle float on the window with the smallest id
# # echo "$ids"
# if [[ $(echo "$ids" | wc -l) -eq 1 ]]; then
#     mainId = $(echo "$ids" | sort -n | head -n 1)
#     yabai -m window $(mainId) --toggle float
# fi

ids=$(yabai -m query --windows | jq -e ".[] | select(.app == $appName) | .id")
if [[ $(echo "$ids" | wc -l) -gt 1 ]]; then
  # If there is, then float it
#   Find the pid of the app with id wid
    pid=$(yabai -m query --windows --window $wid | jq -e ".pid")
    yabai -m window $(pid) --toggle float
fi