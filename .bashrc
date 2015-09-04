# /etc/profile /etc/bash.bashrc $USER/.profile $USER/.bashrc 
# Getting confused?
# http://stefaanlippens.net/bashrc_and_others
# this file is sourced on login by $HOME/.profile if you are using
# the standard set of dotfiles

# Building the shell environment

# Looks for an aliases file and uses it if it exists
if [ -f ~/.bash_aliases ] ; then
  source ${HOME}/.bash_aliases
fi

# Environmental variables
export PATH=${PATH}:/cat/bin # look in the cat bin
export MANPATH=${MANPATH}:/cat/man # look in cat for manpages too
export EDITOR=$(which vim) # sets vim as the standard editor, always

#original ps1 var
#PS1='[\u@\h \W]\$

PATH=$PATH:$HOME/.rvm/bin:$HOME/bin # Add RVM to PATH for scripting

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'


if [ `id -u` -eq 0 ]; then
	#I AM GROOT
	export PS1='\[\e[1;31m\][\u@\h \W]\$\[\e[0m\] '
fi
