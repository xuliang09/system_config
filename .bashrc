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
alias e='emacsclient'

alias gst='git status'
alias gad='git add'
alias gcm='git commit'
alias gco='git checkout'
alias gdf='git diff'


# update bash history immediately
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
