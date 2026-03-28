# ~/.zshenv

add_path() {
  local dir="$1"
  if [ -d "$dir" ] && [[ ":$PATH:" != *":$dir:"* ]]; then
    PATH="$PATH:$dir"
  fi
}

add_path "$HOME/.local/bin"
add_path "$HOME/.cargo/bin"
add_path "$HOME/.npm-global/bin"

export PATH

. "$HOME/.cargo/env"
