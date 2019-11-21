# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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

#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
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
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias lla='ls -alFh'
alias ll='ls -lFh'
alias la='ls -Ah'
alias l='ls -CFh'

# git support ----
#function cb() {
#  echo $(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
#}

alias glc='git pull --rebase origin $(cb)'
alias gpc='git push origin $(cb)'
alias glgp='glc; gpc'
alias gc='git checkout'
# Some aliases I find useful
alias gch="git checkout -b"
alias gb="git branch"
alias gba="git branch -a"
alias gst="git status"
alias gs="git stash"
alias gsa="git stash apply"
alias gcam="git commit -am"
alias gp="git push origin"
alias gl="git pull origin"
alias glog="git log --graph --pretty=format:'%C(red bold)%h %Creset %Cgreen %ai %Creset %an %C(yellow bold)%d %C(white bold)%s' --color"
alias gaa='git add .'
alias gcad="git commit --amend"
alias gsync="git pull --rebase origin develop"
#----

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

PATH=$PATH:$HOME/.rvm/bin:/Users/sefi/dev/dev-tools/mongodb/bin # Add RVM to PATH for scripting

export PHANTOMJS_BIN=/usr/local/lib/node_modules/phantomjs/bin/phantomjs
export PATH=/usr/local/bin:/usr/local/sbin:$HOME/local/bin:$PATH
export M2_HOME=/usr/share/maven
export M2_REPO=/home/sefi/.m2/repository/
export MOZILLA_FIVE_HOME=/usr/lib/firefox
export LD_LIBRARY_PATH="$MOZILLA_FIVE_HOME":"$LD_LIBRARY_PATH"
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
#PS1='\n\[\033[01;34m\]\u\[\033[01;34m\]@\[\033[01;32m\]\h\[\033[00;33m\]:[\t]\n\[\033[01;35m\]\w\n\[\033[00;35m\]\!\$ \[\033[00;32m\]'

# Configure colors, if available.
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    c_reset='\[\e[0m\]'
    c_user='\[\033[1;33m\]'
    c_path='\[\e[0;33m\]'
    c_git_clean='\[\e[0;36m\]'
    c_git_dirty='\[\e[0;35m\]'
else
    c_reset=
    c_user=
    c_path=
    c_git_clean=
    c_git_dirty=
fi

# Get Virtual Env
venv_prompt ()
{
    if [[ $VIRTUAL_ENV != "" ]]
        then
          # Strip out the path and just leave the env name
          echo "(${VIRTUAL_ENV##*/})\n"
    else
          # In case you don't have one activated
          echo ''
    fi
}

PS1="$(venv_prompt)${c_user}\u${c_reset}@${c_user}\h${c_reset}:${c_path}\w${c_reset}\$\n"

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

# Some work related aliases
alias boos='gulp bootstrap & gulp serve'


export STATIC_CONTENT_DIR='/Users/sefininio/src/frontend'
export PROTRACTOR_BASE_PORT=8888
export PROTRACTOR_BASE_URL=http://10.1.0.26:8888/src/

# virtualenv
export WORKON_HOME=~/virtualenvs
export PROJECT_HOME=$HOME/Documents/Projects/
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
ln -fs /Users/sefi/Library/Python/2.7/bin/virtualenvwrapper.sh /usr/local/bin/virtualenvwrapper.sh
ln -fs /Users/sefi/Library/Python/2.7/bin/virtualenv /usr/local/bin/virtualenv
source /usr/local/bin/virtualenvwrapper.sh
source $(brew --prefix nvm)/nvm.sh

# Globality
alias ansible='ansible --vault-password-file ~/.ansible_vault_password'
alias ansible-playbook='ansible-playbook --vault-password-file ~/.ansible_vault_password'
alias ansible-vault='ansible-vault --vault-password-file ~/.ansible_vault_password'
alias gutok=~/gutok.sh

function getdump() {
workon ansible-deploy;
eval $( botoenv -p development);
ansible-playbook -i ~/dev/ansible-deploy/inventory/aws.py ~/dev/ansible-deploy/tools/copy-db.yml -e service_name=$@ --vault-password-file ~/.ansible_vault_password
}

export PATH=~/bin:$PATH
export CDPATH=.:~:~/dev
export EXTRA_INDEX_URL=https://tom:AKCp5Z2XuLJzPqP7Jk2FGpjCW5ZeKZ4XJiChahFjnqopcAbpU2KtnGnk6aHbU6MdXDxudHC9m@globality.jfrog.io/globality/api/pypi/pypi/simple

export PATH=":$HOME/.config/yarn/global/node_modules/.bin:$PATH"
source /Users/sefi/.oh-my-git/prompt.sh
VIRTUAL_ENV_DISABLE_PROMPT=true
function omg_prompt_callback() {
    if [ -n "${VIRTUAL_ENV}" ]; then
        echo "\e[0;31m(`basename ${VIRTUAL_ENV}`)\e[0m\n"
    fi
}
