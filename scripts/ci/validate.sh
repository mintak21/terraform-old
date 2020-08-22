#!/bin/sh
SCRIPT_DIR=$(
  cd $(dirname $0) || {
    echo "Failed to exec change directory command"
    exit 1
  }
  pwd
)
cd "${SCRIPT_DIR}" || {
  echo "Failed to exec change directory command"
  exit 1
}
. ./settings.sh

validate() {
  target_dirs="$(find ../../${base_dir} -type f -name "*.tf" -exec dirname {} \; | sort -u | grep -v ".terraform")"
  for target in ${target_dirs}; do
    cd "${target}" || return
    terraform init -input=false -no-color
    terraform validate -no-color
    cd "${SCRIPT_DIR}" || return
  done
}

validate
