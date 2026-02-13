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
alias gl='cd ~/.local/bin'
alias gx='cd ~/.config/xfce4/xfconf/xfce-perchannel-xml'

alias gp='cd /var/cache/pbuilder'
alias tcd='cd $(mktemp -d)' # temporary directory for experiments

alias m='cd ~/main'
alias tos='cd ~/main/.trash && ls -A'
alias tod='cd ~/main/self && vim todo/head'

alias gs='cd ~/git/salsa'
alias gg='cd ~/git/github'
alias gn='cd ~/git/github/krxnotes'
alias gd='cd ~/git/github/krxnotes/cheat-sheets/debian'

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

# journals
alias dmesgview='sudo dmesg -HTx'
alias jerrors='journalctl -S today -p 3..4'

# misc
alias pip='pip3'
alias python='python3'
alias nb='newsboat'
alias vf='vifm'
alias v='vim'
alias less='batcat'
alias rmf='shred -uzn 4' # secure remove file (HDD only)
alias rmd='wipe -rfq -Q 4' # secure remove directory (HDD only)
alias nm='neomutt'
alias ff='fastfetch --logo none'
alias f="find . -path ./.git -prune -o -path ./.pc -prune -o -print"
alias cc='xsel -p -c; xsel -b -c' # clear primary/clipboard selections
alias vl='vlock' # quickly lock the terminal
alias wt='curl wttr.in' # check local weather

# adguardvpn-cli
vpnon()
{
    best=$(adguardvpn-cli list-locations | awk 'NR>1 && $NF ~ /^[0-9]+$/ {print $NF, $0}' | \
           sort -n | head -1 | cut -d' ' -f2- | awk '{print $3}')
    [ -n "$best" ] && adguardvpn-cli connect -l "$best"
}

vpnoff()
{
    adguardvpn-cli disconnect
}

# packages
searchpkg()
{
    apt-cache search . | awk -v pat="$1" '$1 ~ pat {print $0}' | grep --color=always "$1"
}

listpkg()
{
    dpkg -l | awk -v pat="$1" '$1 == "ii" && $2 ~ pat {print $0}' | grep --color=always "$1"
}

aptfilelist()
{
    if [ -z "$1" ]; then
        echo "usage: aptfilelist <package>"
        return 1
    fi
    apt-file list "$1" | less
}

listfiles()
{
    if [ -z "$1" ]; then
        echo "usage: listfiles <package>"
        return 1
    fi
    dpkg -L "$1" | less
}

create-orig()
{
    if [ -d ./debian ]; then
        tar --exclude='./.git' --exclude='./.pc' --exclude='./debian' -czvf \
        "../$(dpkg-parsechangelog -S Source)_$(dpkg-parsechangelog -S Version | cut -d'-' -f1).orig.tar.gz" .
    fi
}

# others
wgetf() {
    url="$1"
    case "$url" in
    *github.com/*/blob/*)
        url=$(echo "$url" | sed -e 's#github.com/#raw.githubusercontent.com/#' -e 's#/blob/#/#')
        ;;
    esac
    wget "$url"
}

# games
alias q1='quakespasm -basedir /usr/share/games/quake'
alias q2='quake2'
alias q3='quake3'
alias h3='vcmiclient'
alias d1='devilutionx --data-dir /opt/game-scripts/diablo1/data'
alias d2='diablo-2'
