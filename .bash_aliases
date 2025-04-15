# colors
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# list
alias l='ls -CF --color=auto'
alias la='ls -A --color=auto'
alias ls='ls -1 --group-directories-first -N --color=auto'
alias ll='ls -1l --group-directories-first -hN --color=auto'
alias lla='ls -lA --group-directories-first -hN --color=auto'

# verbose
alias rm='rm -v'
alias cp='cp -vi'
alias mv='mv -vi'
alias mkdir='mkdir -v'

# touch file with verbose mode
vtouch()
{
    for i do
        touch "$i"
        [ $? == 0 ] && echo "touched: '$i'"
    done
} && alias touch='vtouch'

# date
alias eudate='date +"%d/%m/%Y - %H:%M:%S"' # simple date format (eu)
alias isodate='date +"%Y/%m/%d - %H:%M:%S"' # simple date format (ISO-like)
alias daterc='date -R | xsel -b -i' # input date (RFC 5322) to clipboard

# change directory
alias c='cd'
alias g='cd ~/git'
alias s='cd ~/sources'
alias d='cd ~/Downloads'
alias lb='cd ~/.local/bin' # sorry live-build (lb)
alias gx='cd ~/.config/xfce4/xfconf/xfce-perchannel-xml'

alias gp='cd /var/cache/pbuilder'
alias tcd='cd $(mktemp -d)' # temporary directory for experiments

alias m='cd ~/main'
alias tos='cd ~/main/.trash && ls -A'
alias tod='cd ~/main/self && vim todo/head'

alias gw='cd ~/git/work'
alias gm='cd ~/git/myenv'
alias gs='cd ~/git/salsa'
alias gn='cd ~/git/myenv/notes'
alias gd='cd ~/git/myenv/notes/cheat-sheets/debian'

# edit
if [ -n "$EDITOR" ]; then
    alias brc='$EDITOR ~/.bashrc'
    alias sl='sudo $EDITOR /etc/apt/sources.list'
    alias sshc='cd ~/.ssh && $EDITOR ~/.ssh/config'
fi

# sudo
alias docker='sudo docker'
alias a='sudo aptitude'
alias rb='sudo reboot'
alias sdn='sudo shutdown -h now'

# misc
alias pip='pip3'
alias python='python3'
alias v='vim'
alias vf='vifm'
alias nb='newsboat'
alias rmf='shred -uzn 4' # secure remove file
alias cc='xsel -p -c; xsel -b -c' # clear primary/clipboard selections
