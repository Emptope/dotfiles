# ~/.zshrc

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

export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"

# Environment variables
export TERM=xterm-256color
export EDITOR='vim'

if [ -f "$HOME/.zsh_aliases" ]; then
  source "$HOME/.zsh_aliases"
fi

# Completion Settings
autoload -Uz compinit
compinit -C

# setopt AUTO_CD # use dir names to cd
setopt AUTO_PUSHD PUSHD_IGNORE_DUPS # dir stack
setopt EXTENDED_GLOB
bindkey -v  # vim mode

# history
HISTFILE=~/.zsh_history
HISTSIZE=120000
SAVEHIST=100000
setopt HIST_EXPIRE_DUPS_FIRST

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

plugins=(
    git 
    zsh-autosuggestions
    zsh-syntax-highlighting
    zoxide
)

source $ZSH/oh-my-zsh.sh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_OPTS="
    --height 100%
    --reverse
    --preview 'bat --color=always --style=numbers --line-range=:500 {}'
"
export FZF_CTRL_R_OPTS="
    --height 100%
    --reverse
"
export FZF_ALT_C_OPTS="
    --height 100%
    --reverse
"

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
