# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# change directory by just typing a dir name
shopt -s autocd

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;93m\]\A|\[\033[01;92m\]\h:\[\033[01;96m\]\u \[\033[01;91m\]\w ]\[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\A|\h:\u \w ] '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Ensures commands entered in one session are available in others,
# with all saved to the shared ~/.bash_history file. Prevents command loss
# and keeps history up-to-date across all open sessions.

_bash_history_sync()
{
    builtin history -a
    HISTFILESIZE=$HISTSIZE
    builtin history -c
    builtin history -r
}

history()
{
    _bash_history_sync
    builtin history "$@"
}

PROMPT_COMMAND=_bash_history_sync

# color man pages
man()
{
    LESS_TERMCAP_mb=$'\e[0;91m'
    LESS_TERMCAP_md=$'\e[0;91m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[07m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[0;4;32m' \
    command man "$@"
}

# exports
export LANG=en_US.UTF8
export LC_ALL=en_US.UTF-8

export EDITOR='/usr/bin/vim'
export BROWSER='/usr/bin/firefox'
export TERMINAL='/usr/bin/xfce4-terminal'

export DEBFULLNAME="Kirill Rekhov"
export DEBEMAIL=krekhov.dev@gmail.com

# function for my .vimrc trick (vnoremap)
# (vim -> visual mode -> ctrl + c -> ~/vbuf)
# ~/vbuf file has saved lines from the clipboard
vb()
{
    [ -s ~/vbuf ] && vim ~/vbuf || echo $?
}

# start the terminal multiplexer
if command -v tmux >/dev/null; then
    [ -z "$TMUX" ] && tmux
fi
