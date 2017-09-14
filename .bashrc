# common shell script
. ~/system_config/common/escape_regex_char.sh
. ~/system_config/common/match_line.sh
. ~/system_config/common/isdigit.sh
. ~/system_config/common/select_output_line.sh

alias l='ls -lF'
alias cd='. ~/system_config/cd_xul.sh'
alias re='. ~/system_config/re.sh'
alias of='. ~/system_config/of.sh'
alias putclip='. ~/system_config/putclip.sh'
alias up='. ~/system_config/up.sh'
alias s='. ~/system_config/s.sh'
alias e='. ~/system_config/e.sh'
alias rm='. ~/system_config/trash.sh'
alias rmi='/bin/rm'

alias gst='git status'
alias gad='git add'
alias gcm='git commit'
alias gco='git checkout'
alias gdf='git diff'


PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]|\d \t\n\$ '

# update bash history immediately
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# enhanced up and down arrow to see command history
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
