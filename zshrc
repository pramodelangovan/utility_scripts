export NVM_NODEJS_ORG_MIRROR=http://nodejs.org/dist
# NodeJS
export NODEJS_HOME=/opt/nodejs/bin
export PATH=$NODEJS_HOME:/usr/games:$PATH

function mkdh () {
    cd /home
    sudo mkdir $1
    sudo chown -R ubuntu:ubuntu $1
    sudo chmod -R 777 $1
    cd $1
    pwd
    cd /home/
}

function gta() {
    git add .
}

function gtc () {
    git commit -m "$1"
}

function gtpl (){
    branchName=$(git rev-parse --abbrev-ref HEAD)
    git pull origin $branchName
}

function gtph (){
    branchName=$(git rev-parse --abbrev-ref HEAD)
    git push origin $branchName
}

function gtckt () {
    git checkout $1
}

function gtst (){
    git status
}

function gtcp () {
    branchName=$(git rev-parse --abbrev-ref HEAD)
    git commit -m "$1"
    git push origin $branchName
}

function gtclr(){
    git reset --hard HEAD
    git checkout .
    git clean -fd
}

git config --get init.defaultBranch

function streamoutput() {
  server="$1"
  ssh "$server" '/bin/bash -c "while ! tail --follow=name $2; do sleep 2; done"'
}

function add-host(){
  # add-host <ip> <name>
  echo "Host ${2}" >> ${HOME}/.ssh/config
  echo "    HostName ${1}" >> ${HOME}/.ssh/config
  echo "    User sdc" >> ${HOME}/.ssh/config
}

function lsfunc(){
  grep -E '^[[:space:]]*(autoload[[:space:]]+(- Uz[[:space:]]+)?)?([[:alnum:]_]+[[:space:]]*\(\)|function[[:space:]]+[[:alnum:]_]+)' ~/.zshrc
}

bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line

source /home/utils/expressions
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

