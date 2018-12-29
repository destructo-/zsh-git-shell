# based on blinks zsh theme

_bkg=black
_green="%B%F{green}%"
_blue="%B%F{blue}%"
_red="%B%F{red}%"
_grey="%B%F{grey}%"
_white="%B%F{white}%"
_dark_yellow="%b%F{yellow}%"

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$_green}on %{$_blue}["
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$_blue}]" 
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%} add"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%} mod"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} del"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%} rnm"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%} umr"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[grey]%} utr"
ZSH_THEME_GIT_PROMPT_DIVERGED="%{$fg[cyan]%} div"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[magenta]%} bhd"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[blue]%} ahd"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[cyan]%} sth"

function _prompt_char() {
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    echo "[$(git_prompt_status)%{$_blue} ]"
  else
    echo ''
  fi
}

function _check_command_result() {
  if [ $(echo $?) = 0 ]; then
    echo "%{%K{black}%{$_blue}┌"
  else
    echo "%{%K{red}$_blue}┌[%{$_grey}COMMAND RUN FAILED%{$_blue}] "
  fi
}

PROMPT='%{%f%k%b%}
$(_check_command_result)[%{$_green}%n%{$_blue}] %{$_green}in %{$_blue}[%{$_dark_yellow}%~%{$_blue}]$(git_prompt_info)%E
$_blue}└$(_prompt_char)->%{%f%k%b%} '
        
RPROMPT='[!%{%B%F{cyan}%}%!%{%f%k%b%}]'
