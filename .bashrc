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

export GITAWAREPROMPT=~/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"

# Environmental variables
export PATH=${PATH}:/cat/bin # look in the cat bin
export MANPATH=${MANPATH}:/cat/man # look in cat for manpages too
export EDITOR=$(which vim) # sets vim as the standard editor, always

#original ps1 var
#PS1='[\u@\h \W]\$

PATH=$PATH:$HOME/.rvm/bin:$HOME/bin # Add RVM to PATH for scripting

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]$ \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls'

if [ `id -u` -eq 0 ]; then
	#I AM GROOT
	export PS1='\[\e[1;31m\][\u@\h \W]\$\[\e[0m\] '
fi

# short and sweet
alias g='git'
alias v='vim'
alias gcm='git commit -m'
alias ga='git add'
alias gs='git status'
alias gb='git branch'
alias gcb='git checkout -b'
alias gpom='git push origin master'
alias gpo='git push origin'
alias gd='git diff'

# DOCKER specific stuff

command -v docker-machine >/dev/null 2>&1 && out=$(docker-machine status default)

if [ "$out" == "Running" ]; then
  # docker machine is running
  eval $(docker-machine env default)  # get env vars
  echo "Sourced ENV for docker-machine: default"
fi

docker_shell(){
  docker exec -it $1 /bin/sh
  # $1 is container id hash
}

docker_exit(){
  docker ps --filter "status=exited"
}

docker_clean(){
  # remove old stopped containers
  docker rm $(docker ps --filter "status=exited" -q)
}

alias ds=docker_shell
alias dexit=docker_exit
alias dclean=docker_clean
alias dcb='docker-compose kill && docker-compose build && docker-compose up'
alias dcu='docker-compose up'
alias dcbn='docker-compose kill && docker-compose build --no-cache && docker-compose up'
alias d='docker'
alias denv='eval $(docker-machine env default)'
alias dk='docker kill'
alias dr='docker run'
alias dcrm='docker-compose rm'

docker_build(){
  docker build -t $1 .
  # build docker in current dir with tag $1
}
alias db=docker_build
alias dp='docker ps'
alias di='docker images'


# vagrant

vagrant_scp(){
  scp -P 2222 vagrant@127.0.0.1:$1 $2
}

alias vscp=vagrant_scp
