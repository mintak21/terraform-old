#!/bin/sh

function install_tflint() {
  curl -L "$(curl -Ls https://api.github.com/repos/terraform-linters/tflint/releases/latest grep -o -E "https://.+?_linux_amd64.zip")" \
       -o tflint.zip && unzip tflint.zip && rm tflint.zip
  printf '\033[36m%s\033[m\n' "install tflint."
}

function install_tfnotify() {
  REPO_URL="https://github.com/mercari/tfnotify/releases/download"
  DL_LINK="${REPO_URL}/v0.6.2/tfnotify_linux_amd64.tar.gz"
  wget ${DL_LINK} -P /tmp
  tar zxvf /tmp/tfnotify_v0.6.2_linux_amd64.tar.gz -C /tmp
  mv /tmp/tfnotify_v0.6.2_linux_amd64/tfnotify /bin/tfnotify
  rm -rf /tmp
  printf '\033[36m%s\033[m\n' "install tfnotify."
}

install_tflint
install_tfnotify
