#!/bin/sh
cd $(dirname $0)
. ./settings.sh

plan() {
  target_dirs=$(find ../../${base_dir} -type f -name "*.tf" -exec dirname {} \; | sort -u)
  for target in ${target_dirs}; do
    cd ${target}
    terraform init -input=false -no-color
    terraform plan -input=false -no-color |
      tfnotify --config ${CODEBUILD_SRC_DIR}/cicd/tfnotify.yml plan --message "$(date)"
  done
}

plan
