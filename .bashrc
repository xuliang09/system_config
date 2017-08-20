alias l='ls -lF'
alias cd='. ~/system_config/cd_xul.sh'
alias re='. ~/system_config/re.sh'
alias of='. ~/system_config/of.sh'
alias putclip='. ~/system_config/putclip.sh'
alias up='. ~/system_config/up.sh'
alias s='. ~/system_config/s.sh'


alias gst='git status'
alias gad='git add'
alias gcm='git commit'
alias gco='git checkout'
alias gdf='git diff'


# update bash history immediately
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"


