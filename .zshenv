# ~/.zshenv

add_path() {
  local dir="$1"
  if [ -d "$dir" ] && [[ ":$PATH:" != *":$dir:"* ]]; then
    PATH="$dir:$PATH"
  fi
}

add_path "$HOME/.local/bin"
add_path "$HOME/.cargo/bin"
add_path "$HOME/.npm-global/bin"

export PATH

export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"

. "$HOME/.cargo/env"
