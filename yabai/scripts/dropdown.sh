# #!/usr/bin/env bash

# If focused terminal is kitty terminal, then focus on previous window, else focus on kitty terminal and remember the previous window

 if [[ $(yabai -m query --windows --window | jq '.app') == '"kitty"' ]]; then
   osascript -e 'tell application "Finder"' -e 'set visible of process "kitty" to false' -e 'end tell'
   yabai -m window --focus recent
 else
   open -a /Applications/kitty.app
   $(/Users/nik/Developer/GitHubRepos/dotfiles/yabai/scripts/kitty.sh)
 fi