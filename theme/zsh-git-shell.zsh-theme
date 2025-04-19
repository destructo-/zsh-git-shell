_bkg=black
_green_t="%F{green}%"
_green="%B%F{green}%"
_blue="%B%F{blue}%"
_red_t="%F{red}%"
_red="%B%F{red}%"
_grey="%B%F{grey}%"
_white="%B%F{white}%"
_dark_yellow="%F{yellow}%"

_clear="%f%k%b%"

# vi-mode configuration
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true
VI_MODE_CURSOR_NORMAL=2
VI_MODE_CURSOR_VISUAL=6
VI_MODE_CURSOR_INSERT=6
VI_MODE_CURSOR_OPPEND=0
#MODE_INDICATOR="%F{white}normal%f"
#INSERT_MODE_INDICATOR="%F{yellow}insert%f"

# git prompt setup
ZSH_THEME_GIT_PROMPT_PREFIX=" : %{$_blue}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$_clear} | "
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%} add"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%} mod"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} del"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%} rnm"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%} umr"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[yellow]%} utr"
ZSH_THEME_GIT_PROMPT_DIVERGED="%{$fg[cyan]%} div"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[magenta]%} bhd"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[blue]%} ahd"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[cyan]%} sth"

function bat_status() {
  STATUS=$(cat '/sys/class/power_supply/BAT0/status')
  CAPACITY=$(cat '/sys/class/power_supply/BAT0/capacity')
  
  if [ "$STATUS" = "Charging" ]; then
    echo "%{$_green}󱐋%{$_clear}"
  elif [ "$STATUS" = "Full" ]; then
    echo "%{$_green}%{$_clear}"
  elif [ "$STATUS" = "Not charging" ]; then
    echo "%{$_green}%{$_clear}"
  elif [[ $CAPACITY > 85 ]]; then
    echo "%{$_green}󱊣%{$_clear}"
  elif [[ $CAPACITY > 40 ]]; then
    echo "%{$_green}󱊢%{$_clear}"
  elif [[ $CAPACITY > 15 ]]; then
    echo "%{$_dark_yellow}󱊡%{$_clear}"
  else
    echo "%{$_red_t}󰂎%{$_clear}"
  fi
}

function env_jvm() {
  echo "%{$_red}%{$_clear} : %{$_dark_yellow}$(archlinux-java get)%{$_clear}"
}

function user() {
  echo "%{$_green}%n%{$_clear}"
}

function where() {
  echo "%{$_dark_yellow}󰉖%{$_clear} : %{$_dark_yellow}%~%{$_clear}"
}

function disc_space() {
  PERCENT=$(df -P / | awk '/%/ {print 100 -$5}')
  if [[ $PERCENT < 15 ]]; then
    echo "  : %{$_red_t}$PERCENT%%%{$_clear}"
  elif [[ $PERCENT < 25 ]]; then
    echo "  : %{$_dark_yellow}$PERCENT%%%{$_clear}"
  else
    echo "  : $PERCENT%%%{$_clear}"
  fi
}

function git_status() {
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    echo "[$(git_prompt_status)%{$_clear} ]"
  else
    echo ""
  fi
}

PROMPT='
┌| $(bat_status) | $(disc_space) | $(where) | $(git_prompt_info)$(env_jvm) |
└$(git_status) '
