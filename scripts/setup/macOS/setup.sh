#!/bin/sh

function install_packages() {
  printf '\033[91m%s\033[m\n' 'installing packages...'
  brew upgrade
  brew bundle --file ./Brewfile
  tfenv install
  printf '\033[36m%s\033[m\n' 'install packages completed.'
}


function setup_git_secrets() {
  git secrets --register-aws --global
  git secrets --install ~/.git-templates/git-secrets
  git config --global init.templatedir '~/.git-templates/git-secrets'
  printf '\033[36m%s\033[m\n' 'git-secrets config set up completed.'
}

pushd $(dirname $0)
install_packages
setup_git_secrets
popd
