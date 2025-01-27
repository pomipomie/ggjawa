#!/bin/sh
echo -ne '\033c\033]0;GGJ2025\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/bubblescape.x86_64" "$@"
