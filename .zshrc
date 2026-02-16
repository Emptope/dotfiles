export LANG=en_US.UTF-8

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

# Completion Settings
autoload -Uz compinit
compinit -C

# setopt AUTO_CD # use dir names to cd
setopt AUTO_PUSHD PUSHD_IGNORE_DUPS # dir stack
setopt EXTENDED_GLOB
bindkey -v  # vim mode

export EDITOR='nvim'

if [ -f "$HOME/.zsh_aliases" ]; then
  source "$HOME/.zsh_aliases"
fi

export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
plugins=(
    git 
    zsh-autosuggestions 
    fast-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

conda() {
    unset -f conda
    
    local CONDA_ROOT_PATH="/home/emptope/pkg/miniconda3"
    
    __conda_setup="$("$CONDA_ROOT_PATH/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
    
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$CONDA_ROOT_PATH/etc/profile.d/conda.sh" ]; then
            . "$CONDA_ROOT_PATH/etc/profile.d/conda.sh"
        else
            export PATH="$CONDA_ROOT_PATH/bin:$PATH"
        fi
    fi
    
    unset __conda_setup
    
    conda "$@"
}

proxy() {
  local mode=$1
  local host="127.0.0.1"
  local port="7890"

  case "$mode" in
    on)
      export http_proxy="http://$host:$port"
      export https_proxy="http://$host:$port"
      echo "Proxy enabled on $host:$port"
      ;;
    off)
      unset http_proxy https_proxy
      echo "Proxy disabled"
      ;;
    status)
      if [[ -n "$http_proxy" ]]; then
        echo "Proxy is currently ENABLED:"
        echo "http_proxy=$http_proxy"
        echo "https_proxy=$https_proxy"
      else
        echo "Proxy is currently DISABLED"
      fi
      ;;
    *)
      echo "Usage: proxy {on|off|status}"
      ;;
  esac
}

eval "$(starship init zsh)"

eval "$(zoxide init zsh)"
