#!/bin/sh

install_tflint() {
  REPO_URL="https://github.com/terraform-linters/tflint/releases/download"
  DL_LINK="${REPO_URL}/v0.16.2/tflint_linux_amd64.zip"
  wget ${DL_LINK} -P /tmp
  unzip /tmp/tflint_linux_amd64.zip -d /tmp
  mv /tmp/tflint /packages/tflint
  echo "install tflint"
}

install_tfnotify() {
  REPO_URL="https://github.com/mercari/tfnotify/releases/download"
  DL_LINK="${REPO_URL}/v0.6.2/tfnotify_linux_amd64.tar.gz"
  wget ${DL_LINK} -P /tmp
  tar zxvf /tmp/tfnotify_linux_amd64.tar.gz -C /tmp
  mv /tmp/tfnotify /packages/tfnotify
  echo "install tfnotify"
}

mkdir -p /packages
install_tflint
install_tfnotify
