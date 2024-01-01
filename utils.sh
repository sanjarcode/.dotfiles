#!/usr/bin/env sh

# y/n confirmation
# usage: `confirm "Show files" && ls`
## usage (with negatory hook), below
# confirm "Do you want to execute the generated command" || {
#     echo "No command run"
#     return
# }

## actual code
confirm() {
    local prompt="$1"
    local response

    # Prompt the user until a valid response is received
    while true; do
        echo -n "$prompt (y/n): "
        read response
        case "$response" in
        [yY][eE][sS] | [yY])
            return 0 # Success
            ;;
        [nN][oO] | [nN])
            return 1 # Error
            ;;
        *)
            echo "Please answer 'yes' or 'no'."
            ;;
        esac
    done
}

## Create file at path if it doesn't exist
## meant especially for nested paths
## named after: `mkdir -p`
## Usage: `touchp A/B/C/nestedFile.md`
function touchp() {
  local file_path=$1
  local dir_path=$(dirname "$file_path")

  if [ ! -d "$dir_path" ]; then
    mkdir -p "$dir_path"
  fi

  touch "$file_path"
}

# show all files at and under path, one per line
function show_files_tree() {
  find . -type f
}

function ip_self_local() {
  ifconfig 2> /dev/null | grep 'inet' | grep '192' | awk '/inet/ {print $2}'
}
