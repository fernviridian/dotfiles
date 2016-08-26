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

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\] \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
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
alias dc='docker-compose'
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
alias drmi='docker rmi'
alias dii=docker_image_ids
alias drmif=docker_remove_all_images
alias db=docker_build
alias dp='docker ps'
alias di='docker images'
alias dstop='docker rm $(docker ps -a -q)' # remove stopped containers
alias dvol='docker volume ls'
alias drmvol="docker volume ls | awk '{print $2}' | grep -v "VOLUME" | xargs docker volume rm"
alias drmlogs="docker ps | grep -v CONTAINER | awk '{print $1}' | xargs docker inspect --format='{{.LogPath}}' | xargs rm -rf"
alias dlogsize="docker ps | grep -v CONTAINER | awk '{print $1}' | xargs docker inspect --format='{{.LogPath}}' | xargs du -h"
alias rc="rancher-compose"

docker_remove_all_images(){
  docker ps | awk '{print $1}' | grep -v "CONTAINER ID" | awk '{print $1}' | xargs docker kill
  docker_image_ids | xargs docker rmi -f 
}

docker_image_ids(){
  docker images | grep -v "IMAGE" | awk '{print $3}'
}

docker_build(){
  docker build -t $1 .
  # build docker in current dir with tag $1
}

# vagrant
vagrant_scp(){
  scp -P 2222 vagrant@127.0.0.1:$1 $2
}

alias vscp=vagrant_scp
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'

# git send-email google smtp cruft yay perl
PATH="/Users/ben/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/ben/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/ben/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/ben/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/ben/perl5"; export PERL_MM_OPT;
