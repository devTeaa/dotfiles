# --- Git prompt: always show branch, status when needed ---
function git_prompt_info() {
  local branch dirty ahead behind arrows

  # not a git repo → show nothing
  git rev-parse --is-inside-work-tree &>/dev/null || return

  # branch name (handles detached HEAD)
  branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null \
           || git describe --tags --exact-match 2>/dev/null \
           || git rev-parse --short HEAD 2>/dev/null)

  # dirty state
  if ! git diff --quiet 2>/dev/null || ! git diff --cached --quiet 2>/dev/null; then
    dirty="%{$fg[red]%}●"
  else
    dirty=""
  fi

  # upstream ahead / behind (no remote name)
  if git rev-parse --abbrev-ref --symbolic-full-name @{u} &>/dev/null; then
    local counts
    counts=($(git rev-list --left-right --count HEAD...@{u} 2>/dev/null))
    ahead=${counts[1]}
    behind=${counts[2]}
  else
    ahead=0
    behind=0
  fi

  (( ahead > 0 ))  && arrows+=" %{$fg[green]%}↑${ahead}"
  (( behind > 0 )) && arrows+=" %{$fg[red]%}↓${behind}"

  echo "%{$fg[yellow]%}‹${branch}${dirty}${arrows}%{$fg[yellow]%}› %{$reset_color%}"
}

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
local user_host="%B%(!.%{$fg[red]%}.%{$fg[green]%})%n@%m%{$reset_color%} "
local user_symbol='%(!.#.$)'
local current_dir="%B%F{032}%~ %f"
local conda_prompt='$(conda_prompt_info)'

local vcs_branch='$(git_prompt_info)$(hg_prompt_info)'

local rvm_ruby='$(ruby_prompt_info)'
local venv_prompt='$(virtualenv_prompt_info)'
if [[ "${plugins[@]}" =~ 'kube-ps1' ]]; then
    local kube_prompt='$(kube_ps1)'
else
    local kube_prompt=''
fi

ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"

PROMPT="╭─${conda_prompt}${user_host}${current_dir}${rvm_ruby}${vcs_branch}${venv_prompt}${kube_prompt}
╰─%B${user_symbol}%b "
RPROMPT="%B${return_code}%b"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}●%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[yellow]%}"

ZSH_THEME_HG_PROMPT_PREFIX="$ZSH_THEME_GIT_PROMPT_PREFIX"
ZSH_THEME_HG_PROMPT_SUFFIX="$ZSH_THEME_GIT_PROMPT_SUFFIX"
ZSH_THEME_HG_PROMPT_DIRTY="$ZSH_THEME_GIT_PROMPT_DIRTY"
ZSH_THEME_HG_PROMPT_CLEAN="$ZSH_THEME_GIT_PROMPT_CLEAN"

ZSH_THEME_RUBY_PROMPT_PREFIX="%{$fg[red]%}‹"
ZSH_THEME_RUBY_PROMPT_SUFFIX="› %{$reset_color%}"

ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg[green]%}‹"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="› %{$reset_color%}"
ZSH_THEME_VIRTUALENV_PREFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX"
ZSH_THEME_VIRTUALENV_SUFFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX"

