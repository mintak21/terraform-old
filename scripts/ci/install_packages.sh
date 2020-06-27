#!/bin/sh

function install_tflint() {
  REPO_URL="https://github.com/terraform-linters/tflint/releases/download"
  DL_LINK="${REPO_URL}/v0.16.2/tflint_linux_amd64.zip"
  wget ${DL_LINK} -P /tmp
  unzip /tmp/tflint_linux_amd64.zip -d /tmp
  mv /tmp/tflint /bin/tflint
  echo "install tflint"
}

function install_tfnotify() {
  REPO_URL="https://github.com/mercari/tfnotify/releases/download"
  DL_LINK="${REPO_URL}/v0.6.2/tfnotify_linux_amd64.tar.gz"
  wget ${DL_LINK} -P /tmp
  tar zxvf /tmp/tfnotify_linux_amd64.tar.gz -C /tmp
  mv /tmp/tfnotify /bin/tfnotify
  echo "install tfnotify"
}

install_tflint
install_tfnotify
