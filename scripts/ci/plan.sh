#!/bin/sh
SCRIPT_DIR=$(
  cd $(dirname $0)
  pwd
)
cd ${SCRIPT_DIR}
. ./settings.sh

plan() {
  target_dirs=$(find ../../${base_dir} -type f -name "*.tf" -exec dirname {} \; | sort -u | grep -v ".terraform")
  for target in ${target_dirs}; do
    cd ${target}
    terraform init -input=false -no-color
    terraform plan -input=false -no-color |
      /usr/local/bin/tfnotify --config ${SCRIPT_DIR}/../cicd/tfnotify.yml plan --message "$(date)"
    cd ${SCRIPT_DIR}
  done
}

plan
