function preexec() {
  timer=$(($(print -P %D{%s%6.})/1000))
}

function precmd() {
  if [ $timer ]; then
    now=$(($(print -P %D{%s%6.})/1000))
    elapsed=$(($now - $timer))

    if [ $elapsed -ge 5000 ]; then
      display_time=$(($elapsed / 1000))"s"
    else
      display_time="${elapsed}ms"
    fi

    export RPROMPT="%F{cyan}${display_time} %{$reset_color%}"
    unset timer
  fi
}

# set -x
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#
# lazy load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:~/.npm/node_modules/.bin # Global modules
export NVM_DIR=$HOME/.nvm
nvm_load () { . $NVM_DIR/nvm.sh && . $NVM_DIR/bash_completion; }
alias node='unalias node; nvm_load; node $@'
alias npm=' unalias npm;  nvm_load; npm  $@'
PATH="$HOME/.local/bin:$PATH"
# [[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh  # This loads NVM

# pnpm
export PNPM_HOME="/home/herman/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# alias code='/mnt/c/Users/herman/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code'

# docker integration alias
# alias run-integration-test="docker run --add-host=host.docker.internal:host-gateway --rm --ipc=host -p 44300:44300 -p 44301:44301 -e DISPLAY=host.docker.internal:0 -e PLAYWRIGHT_HEADLESS=true -e PLAYWRIGHT_DEVTOOLS=false bliblidotcom/playwright-runner:1.8.1-2"
#
export NODE_OPTIONS=--max_old_space_size=4096

# support terminal color
export TERM=xterm-256color

# set default text editor
export VISUAL=vim
export EDITOR="$VISUAL"

# Path to your oh-my-zsh installation.
export ZSH="/home/herman/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="candy"
# ZSH_THEME="robbyrussell"
# ZSH_THEME="jonathan"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration
#

(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
# =============================================================================
# git alias
alias git-author-commit="git shortlog -s -n -e --all"
# alias puf="cat * | sort -u | uniq -c"
alias puf="awk 1 ./* | sort -u | uniq -c"

function graphNode() {
  while :; do grep -oP '^VmRSS:\s+\K\d+' /proc/$(ps aux | grep -v -E 'grep|sh' | grep "$1" | awk '{print $2}')/status | numfmt --from-unit Ki --to-unit Mi; sleep 1; done | ttyplot -u Mi
}
# alias graphNode="while :; do grep -oP '^VmRSS:\s+\K\d+' /proc/$(ps aux | grep -v -E 'grep|sh' | grep node | awk '{print $2}')/status | numfmt --from-unit Ki --to-unit Mi; sleep 1; done | ttyplot -u Mi"
# =============================================================================
# tmux aliases

vimSearch () {
  grep -rn "$2" "$1" --exclude="*.map" | awk -F: '{print "+"$2" "$1}' | xargs -o vim
}

# set +x
#
